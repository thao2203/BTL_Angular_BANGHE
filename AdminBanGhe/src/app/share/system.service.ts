import { Injectable } from '@angular/core';
import {HttpClient} from '@angular/common/http';
import {environment} from '../../environments/environment';
@Injectable({
  providedIn: 'root'
})
export class SystemService {
  private host = environment.hiiii;
  // private SaveForm = this.form.group({
  //   tenSP : ["",[Validators.required, Validators.minLength(8)]],
  //   giaSP : ["",[Validators.required, Validators.min(0), Validators.max(900000)]],
  //   hinhAnh : [""],
  //   moTa : [""]

  // });
  constructor(private http: HttpClient) { }
  getAllItems(){
    return this.http.get(this.host+"item/get-AllItem", {responseType:"json"})
  }
  getAllCategory(){
    return this.http.get(this.host+"itemGroup/get-allItemGroup", {responseType:"json"})
  }
  getSupplier(){
    return this.http.get(this.host+"item/get-allSupplier", {responseType:"json"})
  }
}
