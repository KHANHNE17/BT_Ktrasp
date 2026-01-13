using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.IO;

namespace QLBanSach
{
    public partial class ThemSach : System.Web.UI.Page
    {
        string strConn = ConfigurationManager.ConnectionStrings["MSSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChuDe();
            }
        }

        // 1. Nạp dữ liệu vào DropDownList Chủ đề
        private void LoadChuDe()
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM ChuDe", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);
                ddlChuDe.DataSource = dt;
                ddlChuDe.DataBind();
            }
        }

        // 2. Xử lý thêm mới sách
        protected void btXuLy_Click(object sender, EventArgs e)
        {
            if (Page.IsValid)
            {
                try
                {
                    // Xử lý upload ảnh
                    string fileName = "";
                    if (Hinh.HasFile)
                    {
                        fileName = Path.GetFileName(Hinh.FileName);
                        string path = Server.MapPath("~/Bia_sach/") + fileName;
                        Hinh.SaveAs(path);
                    }

                    // Thực hiện Insert vào CSDL
                    using (SqlConnection conn = new SqlConnection(strConn))
                    {
                        string sql = "INSERT INTO Sach (TenSach, Dongia, MaCD, Hinh, KhuyenMai, NgayCapNhat) " +
                                     "VALUES (@ten, @gia, @macd, @hinh, @km, @ngay)";

                        SqlCommand cmd = new SqlCommand(sql, conn);
                        cmd.Parameters.AddWithValue("@ten", txtTen.Text);
                        cmd.Parameters.AddWithValue("@gia", txtDonGia.Text);
                        cmd.Parameters.AddWithValue("@macd", ddlChuDe.SelectedValue);
                        cmd.Parameters.AddWithValue("@hinh", fileName);
                        cmd.Parameters.AddWithValue("@km", chkKhuyenMai.Checked);
                        cmd.Parameters.AddWithValue("@ngay", DateTime.Now); // Ngày hiện hành

                        conn.Open();
                        cmd.ExecuteNonQuery();

                        lblStatus.Text = "Thêm sách mới thành công!";
                        lblStatus.CssClass = "text-success font-weight-bold";

                        // Làm sạch form sau khi thêm thành công (tùy chọn)
                        txtTen.Text = "";
                        txtDonGia.Text = "";
                    }
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "Thêm thất bại. Lỗi: " + ex.Message;
                    lblStatus.CssClass = "text-danger font-weight-bold";
                }
            }
        }
    }
}