import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { forkJoin } from 'rxjs';
import {
    NgForm, 
    FormBuilder, 
    Validators,
    FormGroup, 
    AbstractControl, 
    ValidationErrors
} from '@angular/forms';
import {
    PoBreadcrumb, 
    PoModalAction, 
    PoModalComponent,
    PoPageAction, 
    PoI18nService, 
    PoI18nPipe, 
    PoNotificationService
} from '@po-ui/ng-components';

import { I{pascalCase}, {pascalCase} } from '../../shared/model/{paramCase}.model';
import { {pascalCase}Service } from '../../shared/services/{paramCase}.service';

@Component({
    selector: 'app-edit',
    templateUrl: './{paramCase}.edit.component.html',
    styleUrls: ['./{paramCase}.edit.component.css']
})
export class {pascalCase}EditComponent implements OnInit, OnDestroy {

    @ViewChild('modalDelete', { static: false }) modalDelete: PoModalComponent;
    @ViewChild('modalCancel', { static: false }) modalCancel: PoModalComponent;

    confirmDeleteAction: PoModalAction;
    cancelModalAction: PoModalAction;
    backModalAction: PoModalAction;

    form: FormGroup;
    errorPattern: string;

    newBreadcrumb: PoBreadcrumb;
    editBreadcrumb: PoBreadcrumb;
    modalActions: Array<PoModalAction>;
    newActions: Array<PoPageAction>;
    editActions: Array<PoPageAction>;

    isPageEdit: boolean;
    {camelCase}: I{pascalCase} = {pascalCase}.empty();

    literals: any = {};
    validate: any = { minLgth: 3, maxLgth: 50 };

    constructor(
        private router: Router,
        private activatedRoute: ActivatedRoute,
        private poI18nPipe: PoI18nPipe,
        private poI18nService: PoI18nService,
        private poNotification: PoNotificationService,
        private service: {pascalCase}Service,
        private fb: FormBuilder
    ) { }

    ngOnInit(): void {
        forkJoin(
            this.poI18nService.getLiterals(),
            this.poI18nService.getLiterals({ context: '{camelCase}' })
        ).subscribe(literals => {
            literals.map(item => Object.assign(this.literals, item));
            this.createFormControl();
            this.setupComponents();
            this.get();
        });

        this.form.valueChanges.subscribe(
            () => {
                this.{camelCase}.name = this.form.controls.name.value;
            }
        );
    }

    change() {
        if (this.form.controls.name.errors && this.form.controls.name.errors.minlength) {
            this.errorPattern = this.poI18nPipe.transform(
                this.literals['minLength'], [this.validate.minLgth]
            );
        } else {
            this.errorPattern = this.literals['emptyInput'];
        }
    }

    private createFormControl() {
        this.form = this.fb.group({
            name: ['', Validators.compose([
                Validators.required, Validators.minLength(this.validate.minLgth),
                Validators.maxLength(this.validate.maxLgth), this.customIsEmpty
            ])]
        });
    }

    private customIsEmpty(control: AbstractControl): ValidationErrors {
        if (control.value.trim().length === 0) {
            return {isEmpty: true};
        }
        return null;
    }

    private checkInteractionOnForm(form: NgForm): void {
        if (form.dirty === true) {
            this.modalCancel.open();
        } else {
            this.closeModal();
            this.router.navigate(['./{camelCase}']);
        }
    }

    private closeModal() {
        this.modalDelete.close();
        this.modalCancel.close();
    }

    private get() {
        const id = parseInt(this.activatedRoute.snapshot.paramMap.get('id'), 10);
        if (id) {
            this.isPageEdit = true;
            this.service.getById(id).subscribe((item: I{pascalCase}) => {
                this.{camelCase} = item;
                this.form.setValue({
                    name: item.name
                });
            });
        }
    }

    private create() {
        this.service.create(this.{camelCase}).subscribe(() => {
            this.router.navigate(['/{camelCase}']);
            this.poNotification.success(this.literals['createdMessage']);
        });
    }

    private update() {
        this.service.update(this.{camelCase}).subscribe(() => {
            this.router.navigate(['/{camelCase}']);
            this.poNotification.success(this.literals['updatedMessage']);
        });
    }

    private delete() {
        this.service.delete(this.{camelCase}.id).subscribe(data => {
            this.router.navigate(['/{camelCase}']);
            this.poNotification.success(
                this.poI18nPipe.transform(
                    this.literals['excludedMessage'], [this.{camelCase}.name]
                )
            );
        });
    }

    private onConfirmDelete() {
        this.modalDelete.close();
        this.delete();
    }

    private setupComponents() {

        this.confirmDeleteAction = { 
            action: () => this.onConfirmDelete(), 
            label: this.literals['yes'] 
        };

        this.cancelModalAction = { 
            label: this.literals['no'], 
            action: this.closeModal.bind(this)
        };

        this.backModalAction = { 
            label: this.literals['yes'], 
            action: () => this.router.navigate(['./{camelCase}']) 
        };

        this.editActions = [
            { 
                label: this.literals['save'], 
                action: this.update.bind(this, this.{camelCase}), 
                disabled: () => this.form.invalid 
            },
            { 
                label: this.literals['remove'], 
                action: () => this.modalDelete.open() 
            },
            { 
                label: this.literals['return'], 
                action: this.checkInteractionOnForm.bind(this, this.form) 
            }
        ];

        this.editBreadcrumb = {
            items: [
                {
                    label: this.literals['{camelCase}'], 
                    link: '/{camelCase}' },
                {
                    label: this.literals['edit'], 
                    link: '/{camelCase}/edit' 
                }
            ]
        };

        this.newActions = [
            { 
                label: this.literals['save'], 
                action: this.create.bind(this), 
                icon: 'po-icon-plus', 
                disabled: () => this.form.invalid 
            },
            { 
                label: this.literals['return'], 
                action: this.checkInteractionOnForm.bind(this, this.form) 
            }
        ];

        this.newBreadcrumb = {
            items: [
                { 
                    label: this.literals['{camelCase}'], 
                    link: '/{camelCase}' 
                },
                { 
                    label: this.literals['new'], 
                    link: '/{camelCase}/new' 
                }
            ]
        };

    }

    ngOnDestroy(): void {}
}
