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
    public class itemGroupController : ControllerBase
    {
        private IitemGroup _db;
        public itemGroupController(IitemGroup db)
        {
            _db = db;
        }
        [HttpGet]
        [Route("get-allItemGroup")]
        public object getAllItemGroup()
        {
            return _db.GetAllItemGroup();
        }
    }
}
