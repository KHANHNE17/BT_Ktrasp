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
    public partial class QTSach : System.Web.UI.Page
    {
        string strConn = ConfigurationManager.ConnectionStrings["MSSQL"].ConnectionString;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        // Hàm đổ dữ liệu vào GridView
        void BindGrid(string tenSach = "")
        {
            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string sql = "SELECT * FROM Sach";
                if (!string.IsNullOrEmpty(tenSach))
                {
                    sql += " WHERE TenSach LIKE @ten";
                }

                SqlDataAdapter da = new SqlDataAdapter(sql, conn);
                da.SelectCommand.Parameters.AddWithValue("@ten", "%" + tenSach + "%");

                DataTable dt = new DataTable();
                da.Fill(dt);

                if (dt.Rows.Count > 0)
                {
                    gvSach.DataSource = dt;
                    gvSach.DataBind();
                    lblThongBao.Text = "";
                }
                else
                {
                    gvSach.DataSource = null;
                    gvSach.DataBind();
                    lblThongBao.Text = "Tìm kiếm không có kết quả nào.";
                }
            }
        }

        // Xử lý nút Tra cứu
        protected void btTraCuu_Click(object sender, EventArgs e)
        {
            BindGrid(txtTen.Text);
        }

      
        protected void gvSach_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gvSach.PageIndex = e.NewPageIndex;
            BindGrid(txtTen.Text);
        }

       
        protected void gvSach_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvSach.EditIndex = e.NewEditIndex;
            BindGrid(txtTen.Text);
        }


        protected void gvSach_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvSach.EditIndex = -1;
            BindGrid(txtTen.Text);
        }

  
        protected void gvSach_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int maSach = int.Parse(gvSach.DataKeys[e.RowIndex].Value.ToString());
            string ten = ((TextBox)gvSach.Rows[e.RowIndex].FindControl("txtEditTen")).Text;
            string gia = ((TextBox)gvSach.Rows[e.RowIndex].FindControl("txtEditGia")).Text;
            bool khuyenmai = ((CheckBox)gvSach.Rows[e.RowIndex].FindControl("chkEditKM")).Checked;

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                string sql = "UPDATE Sach SET TenSach=@ten, Dongia=@gia, KhuyenMai=@km WHERE MaSach=@id";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@ten", ten);
                cmd.Parameters.AddWithValue("@gia", gia);
                cmd.Parameters.AddWithValue("@km", khuyenmai);
                cmd.Parameters.AddWithValue("@id", maSach);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            gvSach.EditIndex = -1;
            BindGrid(txtTen.Text);
        }

   
        protected void gvSach_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int maSach = int.Parse(gvSach.DataKeys[e.RowIndex].Value.ToString());

            using (SqlConnection conn = new SqlConnection(strConn))
            {
                SqlCommand cmd = new SqlCommand("DELETE FROM Sach WHERE MaSach=@id", conn);
                cmd.Parameters.AddWithValue("@id", maSach);

                conn.Open();
                cmd.ExecuteNonQuery();
            }
            BindGrid(txtTen.Text);
        }
    }
}