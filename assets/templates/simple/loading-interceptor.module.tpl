import { NgModule } from '@angular/core';
import { LoadingInterceptorService } from './loading-interceptor.service';
import { HTTP_INTERCEPTORS } from '@angular/common/http';

@NgModule({
    providers: [
        {
            provide: HTTP_INTERCEPTORS,
            useClass: LoadingInterceptorService,
            multi: true,
        }
    ],
})

export class LoadingInterceptorModule {}
