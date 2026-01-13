<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="QTSach.aspx.cs" Inherits="QLBanSach.QTSach" %>
<asp:Content ID="Content1" ContentPlaceHolderID="NoiDung" runat="server">
    <h2 class="text-center">TRANG QUẢN TRỊ SÁCH</h2>
    <hr />   
    <div class="row mb-2">
        <div class="col-md-6">
            <div class="form-inline">
                Tựa sách <asp:TextBox ID="txtTen" runat="server" placeholder="Nhập tựa sách cần tìm" CssClass="form-control ml-2" Width="300"></asp:TextBox>
                <asp:Button ID="btTraCuu" runat="server" Text="Tra cứu" CssClass="btn btn-info ml-2" OnClick="btTraCuu_Click" />                 
            </div>
        </div>
        <div class="col-md-6 text-right">
            <a href="ThemSach.aspx" class="btn btn-success">Thêm sách mới</a>
        </div>
    </div>

    <%-- Thông báo khi không tìm thấy kết quả --%>
    <asp:Label ID="lblThongBao" runat="server" CssClass="text-danger font-weight-bold"></asp:Label>

    <%-- GridView hiển thị danh sách sách --%>
    <asp:GridView ID="gvSach" runat="server" AutoGenerateColumns="False" 
        CssClass="table table-bordered table-hover" 
        DataKeyNames="MaSach" 
        AllowPaging="True" PageSize="4"
        OnPageIndexChanging="gvSach_PageIndexChanging" 
        OnRowEditing="gvSach_RowEditing" 
        OnRowCancelingEdit="gvSach_RowCancelingEdit" 
        OnRowUpdating="gvSach_RowUpdating" 
        OnRowDeleting="gvSach_RowDeleting">
        
        <Columns>
            <asp:TemplateField HeaderText="Tựa sách" HeaderStyle-CssClass="bg-danger text-white">
                <ItemTemplate>
                    <%# Eval("TenSach") %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditTen" runat="server" Text='<%# Bind("TenSach") %>' CssClass="form-control"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Ảnh bìa" HeaderStyle-CssClass="bg-danger text-white" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <img src='<%# "Bia_sach/" + Eval("Hinh") %>' width="80px" />
                </ItemTemplate>
                <EditItemTemplate>
                     <img src='<%# "Bia_sach/" + Eval("Hinh") %>' width="50px" />
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Đơn giá" HeaderStyle-CssClass="bg-danger text-white">
                <ItemTemplate>
                    <%# Eval("Dongia", "{0:0,000}") %> đồng
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="txtEditGia" runat="server" Text='<%# Bind("Dongia") %>' CssClass="form-control" Type="Number"></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Khuyến mãi" HeaderStyle-CssClass="bg-danger text-white" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <%# (bool)Eval("KhuyenMai") ? "x" : "" %>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:CheckBox ID="chkEditKM" runat="server" Checked='<%# Bind("KhuyenMai") %>' />
                </EditItemTemplate>
            </asp:TemplateField>

            <asp:TemplateField HeaderText="Chọn thao tác" HeaderStyle-CssClass="bg-danger text-white" ItemStyle-HorizontalAlign="Center">
                <ItemTemplate>
                    <asp:Button ID="btnEdit" runat="server" CommandName="Edit" Text="Sửa" CssClass="btn btn-primary btn-sm" />
                    <asp:Button ID="btnDelete" runat="server" CommandName="Delete" Text="Xoá" CssClass="btn btn-danger btn-sm" 
                        OnClientClick="return confirm('Bạn có chắc chắn muốn xoá sách này không?');" />
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="Ghi" CssClass="btn btn-success btn-sm" />
                    <asp:Button ID="btnCancel" runat="server" CommandName="Cancel" Text="Không" CssClass="btn btn-warning btn-sm" />
                </EditItemTemplate>
            </asp:TemplateField>
        </Columns>

        <PagerStyle CssClass="pagination-ys" HorizontalAlign="Center" />
    </asp:GridView>
</asp:Content>