import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { IndexComponent } from './web/index/index.component';
import { QuanlyloaisanphamComponent } from './web/quanlyloaisanpham/quanlyloaisanpham.component';
import { QuanlysanphamComponent } from './web/quanlysanpham/quanlysanpham.component';
//import { ThemsanphamComponent } from './web/themsanpham/themsanpham.component';

const routes: Routes = [
  {
    path:"",
    component: IndexComponent
  },
  {
    path:"quanlyloaisanpham",
    component: QuanlyloaisanphamComponent
  },
  {
    path:"quanlysanpham",
    component: QuanlysanphamComponent
  }
  // {
  //   path:"themsanpham",
  //   component: ThemsanphamComponent
  // }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
