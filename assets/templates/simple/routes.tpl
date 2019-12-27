import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { {pascalCase}EditComponent } from './edit/{paramCase}.edit.component';
import { {pascalCase}ListComponent } from './{paramCase}.list.component';

const routes: Routes = [
    {
        path: '',
        component: {pascalCase}ListComponent,
    },
    {
        path: 'new',
        component: {pascalCase}EditComponent
    },
    {
        path: 'edit/:id',
        component: {pascalCase}EditComponent
    }
];

@NgModule({
    declarations: [],
    imports: [RouterModule.forChild(routes)],
    exports: [RouterModule]
})

export class {pascalCase}RoutingModule { }
