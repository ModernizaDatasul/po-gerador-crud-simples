import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { HttpClientModule } from '@angular/common/http';

import { ThfModule } from '@totvs/thf-ui';
import { ThfI18nPipe } from '@totvs/thf-ui/services/thf-i18n';

import { {pascalCase}Service } from '../shared/services/{paramCase}.service';
import { {pascalCase}EditComponent } from './edit/{paramCase}.edit.component';
import { {pascalCase}ListComponent } from './{paramCase}.list.component';
import { {pascalCase}RoutingModule } from './{paramCase}-routing.module';

@NgModule({
    imports: [
        CommonModule,
        ThfModule,
        FormsModule,
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
        ThfI18nPipe,
        {pascalCase}Service
    ],
})
export class {pascalCase}Module { }

