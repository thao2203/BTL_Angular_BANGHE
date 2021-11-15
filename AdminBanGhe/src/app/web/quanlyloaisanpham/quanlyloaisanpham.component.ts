import { Component, OnInit } from '@angular/core';
import { SystemService} from '../../share/system.service';
@Component({
  selector: 'app-quanlyloaisanpham',
  templateUrl: './quanlyloaisanpham.component.html',
  styleUrls: ['./quanlyloaisanpham.component.css']
})
export class QuanlyloaisanphamComponent implements OnInit {
  constructor(private system : SystemService) { }

  categories:any = [];
  listcate = [];
  ngOnInit(): void {
    this.system.getAllCategory().subscribe(
      (rep:any)=>
      {

        this.categories = rep;
        this.categories.forEach(element => {
          this.listcate.push(element);

          if(element.parenT_ITEM_GROUP_ID==0)
          {
            element.treeMenu=[];
            this.createTreeMenu(element, this.categories);
          }
          
        });
        console.log(this.categories);
      },(rep1:any)=>
      {
        console.log(rep1)
      }
    )

  }

  createTreeMenu(elementHienTai, listcate){
    for(let i=0 ; i<listcate.length ;i++)
    {
      if(elementHienTai.iteM_GROUP_ID == listcate[i].parenT_ITEM_GROUP_ID){
        // this.categories.remove(elementHienTai);
        if(!elementHienTai.treeMenu)
        {
          elementHienTai.treeMenu=[]
        }
        console.log(elementHienTai.treeMenu)
        elementHienTai.treeMenu.push(listcate[i]);
        this.createTreeMenu(listcate[i],listcate)
        
       
      }
      // if(elementHienTai.parenT_ITEM_GROUP_ID != 0 && elementHienTai.iteM_GROUP_ID == listcate[i].parenT_ITEM_GROUP_ID)
      // {
      //   elementHienTai.treeMenu=[];
      //   elementHienTai.treeMenu.push(listcate[i]);
      //   listcate.splice(i, 1);
      // }
      // if(elementHienTai.treeMenu)
      // {
      //   this.createTreeMenu(listcate[i], listcate);
      // }
    }
    // listcate.forEach(element => {
      
    //   if(elementHienTai.iteM_GROUP_ID == element.parenT_ITEM_GROUP_ID){
    //     // this.categories.remove(elementHienTai);
    //     elementHienTai.treeMenu.push(element);
    //   }
    //   if(elementHienTai.parenT_ITEM_GROUP_ID != 0 && elementHienTai.iteM_GROUP_ID == element.parenT_ITEM_GROUP_ID)
    //   {
    //     elementHienTai.treeMenu=[];
    //     elementHienTai.treeMenu.push(element);
       
    //   }
    //   if(elementHienTai.treeMenu)
    //   {
    //     this.createTreeMenu(element, listcate);
    //   }

    // });
  }

}
