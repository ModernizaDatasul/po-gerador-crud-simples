import * as vscode from 'vscode';
import * as fse from 'fs-extra';

import { Observable } from 'rxjs';

export class FileHelper {

    private static createFile = <(file: string, data: string) => Observable<{}>>Observable.bindNodeCallback(fse.outputFile);
    
    public static createSharedDirectoryTree(): string {

        let sharedDirectory = `${vscode.workspace.rootPath}/src/app/shared`;

        fse.mkdirsSync(sharedDirectory);
        fse.mkdirsSync(`${sharedDirectory}/model`);
        fse.mkdirsSync(`${sharedDirectory}/services`);

        return sharedDirectory;
    };

    public static createComponentDirectoryTree(parentName: string, childName: string = undefined): string {

        let componentDirectory = `${vscode.workspace.rootPath}/src/app/${parentName}`;

        fse.mkdirsSync(componentDirectory);
        fse.mkdirsSync(`${componentDirectory}/edit`);

        if (childName) {
            fse.mkdirsSync(`${componentDirectory}/detail`);
        }

        return componentDirectory;
    };

    public static createComponentFile(filename: string, content: string): Observable<string> {
        return this.createFile(filename, content).map(result => filename);
    };
}
