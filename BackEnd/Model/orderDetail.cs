using System;
using System.Collections.Generic;
using System.Text;

namespace Model
{
    public class orderDetail
    {
		public int ORDER_DETAIL_ID { get; set; }
		public int ORDER_ID { get; set; }
		public int ITEM_ID { get; set; }
		public int QUANTITY { get; set; }
		public float PRICE { get; set; }
		public string IMAGE { get; set; }
		public float TOTAL { get; set; }
	}
}
