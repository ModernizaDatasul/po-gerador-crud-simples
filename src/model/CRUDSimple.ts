import * as changeCase from 'change-case';

import { Observable } from 'rxjs';

import { FileHelper } from '../helper/FileHelper';
import { TemplateHelper } from '../helper/TemplateHelper';

export class CRUDSimple {

    public static createComponent(componentName: string): Observable<string[]> {

        componentName = changeCase.paramCase(componentName);

        let sharedDirectory = FileHelper.createSharedDirectoryTree();
        let componentDirectory = FileHelper.createComponentDirectoryTree(componentName);

        return Observable.forkJoin(
            
            // Loading Interceptor
            FileHelper.createComponentFile(
                `${componentDirectory}/../loading-interceptor.module.ts`, 
                TemplateHelper.getTemplate('simple/loading-interceptor.module.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/../loading-interceptor.service.ts`, 
                TemplateHelper.getTemplate('simple/loading-interceptor.service.tpl')
            ),
            // List Component
            FileHelper.createComponentFile(
                `${componentDirectory}/${componentName}.list.component.css`, 
                TemplateHelper.getTemplate('simple/list.css.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/${componentName}.list.component.html`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/list.html.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/${componentName}.list.component.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/list.comp.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/${componentName}.list.component.spec.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/list.spec.tpl')
            ),

            // EDIT Component
            FileHelper.createComponentFile(
                `${componentDirectory}/edit/${componentName}.edit.component.css`, 
                TemplateHelper.getTemplate('simple/edit.css.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/edit/${componentName}.edit.component.html`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/edit.html.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/edit/${componentName}.edit.component.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/edit.comp.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/edit/${componentName}.edit.component.spec.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/edit.spec.tpl')
            ),

            // SHARED
            FileHelper.createComponentFile(
                `${sharedDirectory}/interfaces/totvs-response.interface.ts`, 
                TemplateHelper.getTemplate('simple/response.model.tpl')
            ),
            FileHelper.createComponentFile(
                `${sharedDirectory}/model/${componentName}.model.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/model.tpl')
            ),
            FileHelper.createComponentFile(
                `${sharedDirectory}/services/${componentName}.service.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/service.tpl')
            ),
            FileHelper.createComponentFile(
                `${sharedDirectory}/literals/i18n/${componentName}-pt.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/i18n.tpl', { language: 'Pt' })
            ),
            FileHelper.createComponentFile(
                `${sharedDirectory}/literals/i18n/${componentName}-en.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/i18n.tpl', { language: 'En' })
            ),
            FileHelper.createComponentFile(
                `${sharedDirectory}/literals/i18n/${componentName}-es.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/i18n.tpl', { language: 'Es' })
            ),

            // MODULE
            FileHelper.createComponentFile(
                `${componentDirectory}/${componentName}-routing.module.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/routes.tpl')
            ),
            FileHelper.createComponentFile(
                `${componentDirectory}/${componentName}.module.ts`, 
                TemplateHelper.getParsedTemplate(componentName, 'simple/module.tpl')
            )
        );
    };

}