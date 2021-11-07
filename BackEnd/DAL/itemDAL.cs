using System;
using System.Collections.Generic;
using Model;
using DAL.Helper;
using System.Linq;
using DAL.Interface;
namespace DAL
{
    public class itemDAL:Iitem
    {
        private IDatabaseHelper _dbHelper;
        public itemDAL(IDatabaseHelper dbHelper)
        {
            _dbHelper = dbHelper;
        }

        public object ngauNhien()
        {
                string Error = "";
                var db1 = _dbHelper.ExecuteSProcedureReturnDataTable(out Error, "sp_item_ngauNhien");
                var db2 = _dbHelper.ExecuteSProcedureReturnDataTable(out Error, "sp_item_bestSeller");
            if (!string.IsNullOrEmpty(Error))
                return Error;
            return Tuple.Create(db1.ConvertTo<items>().ToList(), db2.ConvertTo<items>().ToList());
            
        }
    }
}
