'use strict';

import * as vscode from 'vscode';

import { Observable } from 'rxjs';

import { CRUDSimple } from './model/CRUDSimple';

export function activate(context: vscode.ExtensionContext) {

    let componentNameInput: vscode.InputBoxOptions = {
        prompt: 'Inform o nome do componente utilizando cameCaso, exemplo: ticketStatus',
        placeHolder: 'componentName',
        validateInput: validateInputValue
    };
    
    let poCRUDSimple = vscode.commands.registerCommand('extension.poCRUDSimple', () => {
        showInput(componentNameInput).concatMap(value => {
            if (!value) return Observable.empty();
            return CRUDSimple.createComponent(value);
        }).subscribe(showCompletedMessage, showErrorMessage);
    });

    function validateInputValue(value: string): string {
        if (!value || value.length === 0) return 'O nome não pode ser vazio!';
        else return undefined;
    };

    function showInput(options: vscode.InputBoxOptions): Observable<string> {
        return Observable.from(vscode.window.showInputBox(options));
    };

    function showCompletedMessage(): void {
        vscode.window.setStatusBarMessage('Componente criado com sucesso!', 5000);
    };

    function showErrorMessage(err: Error): void {
        if (err.message) vscode.window.showErrorMessage(err.message);
    };

    context.subscriptions.push(poCRUDSimple);
}

export function deactivate() { }
