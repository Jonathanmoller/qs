﻿<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="JurisdictionGroups.ascx.cs" Inherits="Mediachase.Commerce.Manager.Order.JurisdictionGroups" %>
<%@ Register Src="~/Apps/Core/Controls/EcfListViewControl.ascx" TagName="EcfListViewControl" TagPrefix="core" %>
<core:EcfListViewControl id="MyListView" runat="server" DataKey="JurisdictionGroupId" AppId="Order" ViewId="JurisdictionGroups-List" ShowTopToolbar="true"></core:EcfListViewControl>