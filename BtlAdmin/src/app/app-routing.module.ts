import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { IndexComponent } from './web/index/index.component';
import { QuanlysanphamComponent } from './web/quanlysanpham/quanlysanpham.component';


const routes: Routes = [
  {
    path:"",
    component: IndexComponent
  },
  {
    path:"quanlysanpham",
    component: QuanlysanphamComponent
  }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
