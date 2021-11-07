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
    }
}
