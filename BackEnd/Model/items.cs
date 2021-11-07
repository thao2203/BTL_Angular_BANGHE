using System;
using System.Collections.Generic;
using System.Text;

namespace Model
{
    public class items
    {

        public int ITEM_ID { get; set; }

        public int ITEM_GROUP_ID { get; set; }
        public int SUPPLIER_ID { get; set; }

        public string ITEM_NAME { get; set; }
        public string ITEM_IMAGE { get; set; }

        public string ITEM_DESCRIPTION { get; set; }
        public float ITEM_PRICE { get; set; }
    }
}
