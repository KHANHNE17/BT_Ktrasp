using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace QLBanSach
{
    public partial class XemSach : System.Web.UI.Page
    {
        // Lấy chuỗi kết nối từ Web.config
        string strConn = ConfigurationManager.ConnectionStrings["MSSQL"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadChuDe();
                // Mặc định hiển thị sách của chủ đề đầu tiên
                if (ddlChuDe.Items.Count > 0)
                {
                    BindBooks(int.Parse(ddlChuDe.SelectedValue));
                }
            }
        }

        // Nạp danh sách chủ đề vào DropDownList
        private void LoadChuDe()
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlDataAdapter da = new SqlDataAdapter("SELECT * FROM ChuDe", conn);
                DataTable dt = new DataTable();
                da.Fill(dt);

                ddlChuDe.DataSource = dt;
                ddlChuDe.DataTextField = "TenCD";
                ddlChuDe.DataValueField = "MaCD";
                ddlChuDe.DataBind();

                // Thêm tùy chọn "Tất cả chủ đề" nếu muốn
                ddlChuDe.Items.Insert(0, new ListItem("--- Tất cả chủ đề ---", "0"));
            }
        }

        // Nạp danh sách sách theo mã chủ đề
        private void BindBooks(int maCD)
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string sql = "SELECT * FROM Sach";
                if (maCD > 0)
                {
                    sql += " WHERE MaCD = @macd";
                }

                SqlCommand cmd = new SqlCommand(sql, conn);
                if (maCD > 0)
                {
                    cmd.Parameters.AddWithValue("@macd", maCD);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    rptSach.DataSource = dt;
                    rptSach.DataBind();
                    lblMsg.Text = "";
                }
                else
                {
                    rptSach.DataSource = null;
                    rptSach.DataBind();
                    lblMsg.Text = "Chưa có sách cho chủ đề này.";
                }
            }
        }

        // Sự kiện khi thay đổi chủ đề trên DropDownList
        protected void ddlChuDe_SelectedIndexChanged(object sender, EventArgs e)
        {
            int maCD = int.Parse(ddlChuDe.SelectedValue);
            BindBooks(maCD);
        }
    }
}