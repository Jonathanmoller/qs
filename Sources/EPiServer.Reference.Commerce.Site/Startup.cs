using EPiServer.ServiceApi.Owin;
using Owin;

namespace EPiServer.Reference.Commerce.Site
{
    public class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            // Enable bearer token authentication using Membership for Service Api
            app.UseServiceApiMembershipTokenAuthorization();
        }      
    }
}