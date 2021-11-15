import { Component, OnInit } from '@angular/core';
import { SystemService} from '../../share/system.service';
import { Subscription } from 'rxjs';
import { ActivatedRoute } from '@angular/router';
@Component({
  selector: 'app-quanlysanpham',
  templateUrl: './quanlysanpham.component.html',
  styleUrls: ['./quanlysanpham.component.css','../../../assets/css/main2.css']
})
export class QuanlysanphamComponent implements OnInit {
  private a:Subscription;
  constructor(private system : SystemService, private router:ActivatedRoute) { }

  items:any = [];
  totalItem;
  current_Page;
  ngOnInit(): void {
    this.system.getAllItems().subscribe(
      (rep:any)=>
      {
        this.totalItem = rep.Length;
        this.items = rep;
        console.log(rep)
      },(rep1:any)=>
      {
        console.log(rep1)
      }
    )
  }

}
