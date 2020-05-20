import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpRequest, HttpHandler, HttpInterceptor, HttpEvent, HttpHeaders } from '@angular/common/http';

@Injectable()
export class LoadingInterceptorService implements HttpInterceptor {
    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

        let req: HttpRequest<any>;

        const headers = new HttpHeaders({
            'X-Po-Screen-Lock': 'true'
        });

        if (!request.headers.get('X-Po-Screen-Lock')) {
            req = request.clone({headers});
        } else {
            req = request.clone();
        }

        return next.handle(req);
    }

}
