﻿using EPiServer.Commerce.Order;
using EPiServer.Reference.Commerce.Site.Features.Cart.Services;
using EPiServer.Reference.Commerce.Site.Features.Market.Services;
using EPiServer.Reference.Commerce.Site.Features.Market.ViewModels;
using Mediachase.Commerce;
using System.Linq;
using System.Web.Mvc;

namespace EPiServer.Reference.Commerce.Site.Features.Market.Controllers
{
    public class CurrencyController : Controller
    {
        private readonly ICurrencyService _currencyService;
        private readonly ICartService _cartService;
        private readonly IOrderRepository _orderRepository;

        public CurrencyController(ICurrencyService currencyService, 
            ICartService cartService, 
            IOrderRepository orderRepository)
        {
            _currencyService = currencyService;
            _cartService = cartService;
            _orderRepository = orderRepository;
        }

        [ChildActionOnly]
        public ActionResult Index()
        {
            var model = new CurrencyViewModel
            {
                Currencies = _currencyService.GetAvailableCurrencies()
                    .Select(x => new SelectListItem
                {
                    Selected = false,
                    Text = x.CurrencyCode,
                    Value = x.CurrencyCode
                }),
                CurrencyCode = _currencyService.GetCurrentCurrency().CurrencyCode,
            };
            return PartialView(model);
        }

        [HttpPost]
        public ActionResult Set(string currencyCode)
        {
            if (!_currencyService.SetCurrentCurrency(currencyCode))
            {
                return new HttpStatusCodeResult(400, "Unsupported");
            }

            var cart = _cartService.LoadCart(_cartService.DefaultCartName);
            if (cart != null)
            {
                var currentCurrency = new Currency(currencyCode);
                if (currentCurrency != cart.Currency)
                {
                    _cartService.SetCartCurrency(cart, currentCurrency);
                    _orderRepository.Save(cart);
                }
            }
            
            return Json(new { returnUrl = Request.UrlReferrer.ToString() });
        }
    }
}