import { Component } from '@angular/core';
//@ts-ignore
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrl: './app.component.css'
})
export class AppComponent {
  title = 'Registration form';

  displayname = ''
  displayadd = ''
  displaycontact = ''
  displayemail = ''

  getvalue(name:string,address:string,contact:any,email:string){
    this.displayname = name
    this.displayadd = address
    this.displaycontact = contact
    this.displayemail = email
  }
}
