import { ComponentFixture, TestBed } from '@angular/core/testing';

import { QuanlyloaisanphamComponent } from './quanlyloaisanpham.component';

describe('QuanlyloaisanphamComponent', () => {
  let component: QuanlyloaisanphamComponent;
  let fixture: ComponentFixture<QuanlyloaisanphamComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ QuanlyloaisanphamComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(QuanlyloaisanphamComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
