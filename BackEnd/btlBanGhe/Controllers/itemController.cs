using Microsoft.AspNetCore.Mvc;
using DAL.Interface;
using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace btlBanGhe.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class itemController : ControllerBase
    {
        private Iitem _db;
        public itemController(Iitem db)
        {
            _db = db;
        }
        [HttpGet]
        [Route("get-random")]

        public object getRandom()
        {
            return _db.ngauNhien();
        }

        [HttpGet]
        [Route("get-detail/{id}")]

        public object getDetail(int id)
        {
            return _db.chiTiet(id);
        }

        [HttpGet]
        [Route("get-category/{id}")]

        public object getCategory(int id)
        {
            return _db.DSdanhMuc(id);
        }

        [HttpGet]
        [Route("get-allSupplier")]

        public object getAllSupplier()
        {
            return _db.TatCaNCC();
        }
    }
}
