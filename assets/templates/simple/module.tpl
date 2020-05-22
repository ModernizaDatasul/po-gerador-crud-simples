import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule, ReactiveFormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { PoModule, PoI18nPipe } from '@po-ui/ng-components';

import { {pascalCase}Service } from '../shared/services/{paramCase}.service';
import { {pascalCase}EditComponent } from './edit/{paramCase}.edit.component';
import { {pascalCase}ListComponent } from './{paramCase}.list.component';
import { {pascalCase}RoutingModule } from './{paramCase}-routing.module';

import { LoadingInterceptorModule } from '../loading-interceptor.module';

@NgModule({
    imports: [
        CommonModule,
        LoadingInterceptorModule,
        PoModule,
        FormsModule,
        ReactiveFormsModule,
        HttpClientModule,
        {pascalCase}RoutingModule
    ],
    declarations: [
        {pascalCase}ListComponent,
        {pascalCase}EditComponent
    ],
    exports: [
        {pascalCase}ListComponent
    ],
    providers: [
        PoI18nPipe,
        {pascalCase}Service
    ],
})
export class {pascalCase}Module { }

