<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="ThemSach.aspx.cs" Inherits="QLBanSach.ThemSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="NoiDung" runat="server">
    <h2 class="text-center">THÊM SÁCH MỚI</h2>
    <hr />
    <div class="w-100">
        <%-- Hiển thị tổng hợp lỗi --%>
        <asp:ValidationSummary ID="vsTongHop" runat="server" CssClass="alert alert-danger" HeaderText="Vui lòng kiểm tra lại các lỗi sau:" />

        <div class="form-group">
            <label class="font-weight-bold">Tên sách</label>
            <asp:TextBox ID="txtTen" runat="server" CssClass="form-control"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvTen" runat="server" ControlToValidate="txtTen" 
                ErrorMessage="Tên sách không được rỗng" Display="Dynamic" ForeColor="Red">(*) Tên sách bắt buộc nhập</asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="font-weight-bold">Đơn giá</label>
            <asp:TextBox ID="txtDonGia" runat="server" CssClass="form-control" Type="Number"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvGia" runat="server" ControlToValidate="txtDonGia" 
                ErrorMessage="Đơn giá không được rỗng" Display="Dynamic" ForeColor="Red">(*) Giá bắt buộc nhập</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="cvGia" runat="server" ControlToValidate="txtDonGia" 
                ErrorMessage="Đơn giá phải là kiểu số > 0" ValueToCompare="0" Operator="GreaterThan" 
                Type="Integer" Display="Dynamic" ForeColor="Red">(*) Giá phải là số lớn hơn 0</asp:CompareValidator>
        </div>

        <div class="form-group">
            <label class="font-weight-bold">Chủ đề</label>
            <asp:DropDownList ID="ddlChuDe" runat="server" CssClass="form-control" DataTextField="TenCD" DataValueField="MaCD"></asp:DropDownList>
        </div>

        <div class="form-group">
            <label class="font-weight-bold">Ảnh bìa sách</label>
            <asp:FileUpload ID="Hinh" runat="server" CssClass="form-control-file" />
            <asp:RequiredFieldValidator ID="rfvHinh" runat="server" ControlToValidate="Hinh" 
                ErrorMessage="Ảnh bìa không được bỏ trống" Display="Dynamic" ForeColor="Red">(*) Chưa chọn ảnh</asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <label class="font-weight-bold">Khuyến mãi</label>
            <asp:CheckBox ID="chkKhuyenMai" runat="server" Checked="true" CssClass="ml-2" />
        </div>

        <asp:Button ID="btXuLy" runat="server" Text="Lưu" CssClass="btn btn-success" OnClick="btXuLy_Click" />
        <br /><br />
        <asp:Label ID="lblStatus" runat="server" CssClass="font-weight-bold"></asp:Label>
    </div>
</asp:Content>
