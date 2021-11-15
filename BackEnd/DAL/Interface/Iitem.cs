using System;
using System.Collections.Generic;
using System.Text;

namespace DAL.Interface
{
    public interface Iitem
    {
        public object ngauNhien();
        public object chiTiet(int id);
        public object DSdanhMuc(int id);
        public object TatCaNCC();
        public object GetAllItems();
    }
}
