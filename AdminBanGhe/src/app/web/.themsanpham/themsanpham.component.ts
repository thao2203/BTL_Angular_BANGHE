import { Component, OnInit } from '@angular/core';
import { SystemService} from '../../share/system.service';

@Component({
  selector: 'app-themsanpham',
  templateUrl: './themsanpham.component.html',
  styleUrls: ['./themsanpham.component.css']
})
export class ThemsanphamComponent implements OnInit {

  constructor(private system : SystemService) { }

  ncc:any=[];
  lsp:any=[];
  ngOnInit(): void {
    this.system.getSupplier().subscribe(
      (rep:any)=>
      {
        this.ncc = rep;
        console.log(rep)
      },(rep1:any)=>
      {
        console.log(rep1)
      }
    )

    this.system.getAllCategory().subscribe(
      (rep:any)=>
      {
        this.lsp = rep;
        console.log(rep)
      },(rep1:any)=>
      {
        console.log(rep1)
      }
    )
  }

}
