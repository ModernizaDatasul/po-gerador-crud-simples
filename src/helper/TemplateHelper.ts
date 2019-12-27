import * as fs from 'fs';
import * as path from 'path';
import * as changeCase from 'change-case';

export class TemplateHelper {

    private static templatesDirectory: string = path.join(__dirname, '../../../assets/templates/');

    public static getTemplate(templateFilename: string): string {
        return fs.readFileSync(`${this.templatesDirectory}/${templateFilename}`).toString();
    };

    public static parseTemplate(componentName:string, template: string, options: any = {}): string {
        return (template || 'wrong')
            .replace(/{paramCase}/g, componentName)
            .replace(/{camelCase}/g, changeCase.camelCase(componentName))
            .replace(/{pascalCase}/g, changeCase.pascalCase(componentName))
            .replace(/{language}/g, options.language);
    };

    public static getParsedTemplate(componentName:string, templateFilename: string, options: any = {}): string {
        return this.parseTemplate(componentName, this.getTemplate(templateFilename), options);
    };
}
