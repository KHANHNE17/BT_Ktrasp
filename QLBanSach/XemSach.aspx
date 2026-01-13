<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.Master" AutoEventWireup="true" CodeBehind="XemSach.aspx.cs" Inherits="QLBanSach.XemSach" %>

<asp:Content ID="Content1" ContentPlaceHolderID="NoiDung" runat="server">
    <h3 class="text-center">Trang xem sách</h3>
    <hr />
    <div class="alert alert-info">
         <div class="form-inline justify-content-center">
              <label class="font-weight-bold">Chủ đề</label>
             <asp:DropDownList ID="ddlChuDe" CssClass="form-control ml-2" runat="server" 
                 AutoPostBack="True" OnSelectedIndexChanged="ddlChuDe_SelectedIndexChanged">
             </asp:DropDownList>
         </div>
    </div>   

    <div class="row mt-2">
        <asp:Repeater ID="rptSach" runat="server">
            <ItemTemplate>
                <div class="col-md-4 col-sm-6">
                    <div class="card mb-4 shadow-sm">
                        <div class="card-header text-center" style="height: 250px; overflow: hidden;">
                            <%-- Đường dẫn ảnh: ~Images/ --%>
                            <img class="img-fluid" src='<%# "Bia_sach/" + Eval("Hinh") %>' alt='<%# Eval("TenSach") %>' style="max-height: 100%" />
                        </div>
                        <div class="card-body">
                            <h5 class="card-title text-primary" style="height: 50px; overflow: hidden;">
                                <%# Eval("TenSach") %>
                            </h5>
                            <p class="card-text">
                                Giá bán: <span class="text-danger font-weight-bold"><%# Eval("Dongia", "{0:#,##0}") %> VNĐ</span>
                            </p>
                        </div>
                        <div class="card-footer text-center">
                            <a href="#" class="btn btn-success btn-sm">Xem chi tiết</a>
                            <a href="#" class="btn btn-info btn-sm">Đặt mua</a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        
        <%-- Thông báo khi không có sách --%>
        <div class="col-12 text-center">
            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
        </div>
    </div>
</asp:Content>