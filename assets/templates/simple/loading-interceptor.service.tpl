import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { HttpRequest, HttpHandler, HttpInterceptor, HttpEvent, HttpHeaders } from '@angular/common/http';

@Injectable()
export class LoadingInterceptorService implements HttpInterceptor {
    intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

        const headers = new HttpHeaders({
            'X-Portinari-Screen-Lock': 'true'
        });

        const req = request.clone({headers});

        return next.handle(req);
    }

}
