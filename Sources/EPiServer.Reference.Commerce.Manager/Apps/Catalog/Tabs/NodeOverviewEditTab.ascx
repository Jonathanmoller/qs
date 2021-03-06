<%@ Control Language="C#" AutoEventWireup="true" Inherits="Mediachase.Commerce.Manager.Catalog.Tabs.NodeOverviewEditTab" CodeBehind="NodeOverviewEditTab.ascx.cs" %>
<%@ Register Src="~/Apps/Core/Controls/BooleanEditControl.ascx" TagName="BooleanEditControl" TagPrefix="ecf" %>
<%@ Register Src="~/Apps/Core/Controls/CalendarDatePicker.ascx" TagName="CalendarDatePicker" TagPrefix="ecf" %>
<%@ Register Src="~/Apps/Core/MetaData/EditTab.ascx" TagName="MetaData" TagPrefix="ecf" %>
<style type="text/css">
    .ajax__validatorcallout_popup_table {
        top: 100px;
        left: 390px;
        border: none 0px;
        background-color: transparent;
        padding: 0px;
        margin: 0px;
    }

    .ajax__validatorcallout_popup_table1 {
        top: 230px;
        left: 390px;
        border: none 0px;
        background-color: transparent;
        padding: 0px;
        margin: 0px;
    }
</style>
<script type="text/javascript">


    function extendToolkitHidePopupTimer() {
        if (AjaxControlToolkit && AjaxControlToolkit.PopupBehavior) {
            extendToolkitHidePopup();
        }
        else {
            window.setTimeout(extendToolkitHidePopup, 500);
        }
    }

    function extendToolkitHidePopup() {
        AjaxControlToolkit.PopupBehavior.prototype.hide = function() {
            var eventArgs = new Sys.CancelEventArgs();
            this.raiseHiding(eventArgs);
            if (eventArgs.get_cancel()) {
                return;
            }

            // Either hide the popup or play an animation that does
            this._visible = false;
            if (this._onHide) {
                this.onHide();
            } else {
                this._hidePopup();
                this._hideCleanup();
            }
        }
    }

    extendToolkitHidePopupTimer();

</script>
<div id="DataForm">
    <table class="DataForm">
        <tr>
            <td class="FormLabelCell">
                <asp:Label runat="server" Text="<%$ Resources:SharedStrings, Name %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <asp:TextBox runat="server" Width="250" ID="Name"></asp:TextBox><br />
                <asp:Label CssClass="FormFieldDescription" runat="server" Text="<%$ Resources:CatalogStrings, Node_Name_Description %>"></asp:Label>
                <asp:RequiredFieldValidator runat="server" ID="NameRequired" ControlToValidate="Name" Display="Dynamic" ErrorMessage="<%$ Resources:CatalogStrings, Catalog_Name_Required %>" />
                <br />
                <asp:CustomValidator runat="server" ID="NameLengthValidator" ControlToValidate="Name" Display="Dynamic"
                    OnServerValidate="NameLengthValidator_Validate"
                    ErrorMessage="<%$ Resources:CatalogStrings, Catalog_Catalog_Name_TooLong %>" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <tr>
            <td class="FormLabelCell">
                <asp:Label ID="Label1" runat="server" Text="<%$ Resources:SharedStrings, Available_From %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <ecf:CalendarDatePicker runat="server" ID="AvailableFrom" />
                <asp:CustomValidator runat="server" ID="AvailableFromValidator" ControlToValidate="AvailableFrom" Display="Dynamic"
                                     OnServerValidate="AvailableFromValidator_Validate" ErrorMessage="<%$ Resources:CatalogStrings, Entry_AvailableFrom_Too_Late %>" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <tr>
            <td class="FormLabelCell">
                <asp:Label ID="Label2" runat="server" Text="<%$ Resources:SharedStrings, Expires_On %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <ecf:CalendarDatePicker runat="server" ID="ExpiresOn" />
                <asp:CustomValidator runat="server" ID="ExpiresOnValidator" ControlToValidate="ExpiresOn" Display="Dynamic"
                    OnServerValidate="ExpiresOnValidator_Validate" ErrorMessage="<%$ Resources:CatalogStrings, Entry_ExpiresOn_Too_Early %>" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <tr>
            <td class="FormLabelCell">
                <asp:Label ID="Label9" runat="server" Text="<%$ Resources:SharedStrings, Code %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <asp:TextBox runat="server" Width="250" ID="CodeText"></asp:TextBox>
                <asp:RequiredFieldValidator runat="server" ID="CodeTextRequired" ControlToValidate="CodeText" Display="Dynamic" ErrorMessage="<%$ Resources:SharedStrings, Code_Required %>" />
                <br />
                <asp:CustomValidator runat="server" ID="cvCodeCheck"
                    ControlToValidate="CodeText"
                    OnServerValidate="NodeCodeCheck" Display="Dynamic"
                    ErrorMessage="<%$ Resources:CatalogStrings, Catalog_Node_With_Code_Exists %>" />
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <tr>
            <td class="FormLabelCell">
                <asp:Label ID="Label11" runat="server" Text="<%$ Resources:SharedStrings, Sort_Order %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <asp:TextBox runat="server" Width="50" ID="SortOrder"></asp:TextBox><br />
                <asp:RequiredFieldValidator runat="server" ID="SortOrderRequiredValidator" ControlToValidate="SortOrder" ErrorMessage="<%$ Resources:SharedStrings, Sort_Order_Required %>" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RangeValidator runat="server" ID="SortOrderRangeValidator" ControlToValidate="SortOrder" MinimumValue="0" MaximumValue="1000000000" Type="Integer" ErrorMessage="<%$ Resources:SharedStrings, Sort_Order_Invalid %>" Display="Dynamic"></asp:RangeValidator>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <tr>
            <td class="FormLabelCell">
                <asp:Label ID="Label5" runat="server" Text="<%$ Resources:SharedStrings, Available %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <ecf:BooleanEditControl id="IsCatalogNodeActive" runat="server"></ecf:BooleanEditControl>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <tr>
            <td class="FormLabelCell">
                <asp:Label ID="Label6" runat="server" Text="<%$ Resources:CatalogStrings, Meta_Class %>"></asp:Label>:</td>
            <td class="FormFieldCell">
                <asp:DropDownList runat="server" AutoPostBack="true" ID="MetaClassList" DataTextField="FriendlyName" DataValueField="Id">
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2" class="FormSpacerCell"></td>
        </tr>
        <ecf:MetaData runat="server" ID="MetaDataTab" MDContext="<%# Mediachase.Commerce.Catalog.CatalogContext.MetaDataContext %>" />
    </table>
</div>
