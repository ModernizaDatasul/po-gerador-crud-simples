import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { ActivatedRoute, Router } from '@angular/router';
import { Location } from '@angular/common';
import { NgForm } from '@angular/forms';

import { Observable } from 'rxjs';

import { ThfBreadcrumb } from '@totvs/thf-ui/components/thf-breadcrumb';
import { ThfModalAction } from '@totvs/thf-ui/components/thf-modal';
import { ThfModalComponent } from '@totvs/thf-ui/components/thf-modal/thf-modal.component';
import { ThfPageAction } from '@totvs/thf-ui/components/thf-page';
import { ThfI18nService, ThfI18nPipe } from '@totvs/thf-ui/services/thf-i18n';
import { ThfNotificationService } from '@totvs/thf-ui/services/thf-notification/thf-notification.service';

import { I{pascalCase}, {pascalCase} } from '../../shared/model/{paramCase}.model';
import { {pascalCase}Service } from '../../shared/services/{paramCase}.service';

@Component({
    selector: 'app-edit',
    templateUrl: './{paramCase}.edit.component.html',
    styleUrls: ['./{paramCase}.edit.component.css']
})
export class {pascalCase}EditComponent implements OnInit, OnDestroy {

    @ViewChild('modalDelete') modalDelete: ThfModalComponent;
    @ViewChild('modalCancel') modalCancel: ThfModalComponent;
    
    @ViewChild('form{pascalCase}') form{pascalCase}: NgForm;

    returnAction: ThfModalAction;
    confirmDeleteAction: ThfModalAction;
    confirmReturnToListAction: ThfModalAction;
    
    newBreadcrumb: ThfBreadcrumb;
    editBreadcrumb: ThfBreadcrumb;

    newActions: Array<ThfPageAction>;
    editActions: Array<ThfPageAction>;

    isPageEdit: boolean;
    {camelCase}: I{pascalCase} = {pascalCase}.empty();
    
    literals: any = {};

    constructor(
        private router: Router,
        private location: Location,
        private activatedRoute: ActivatedRoute,
        private thfI18nPipe: ThfI18nPipe,
        private thfI18nService: ThfI18nService,
        private thfNotification: ThfNotificationService,
        private service: {pascalCase}Service
    ) { }

    ngOnInit(): void {
        Observable.forkJoin(
            this.thfI18nService.getLiterals(),
            this.thfI18nService.getLiterals({ context: '{camelCase}' })
        ).subscribe(literals => {
            literals.map(item => Object.assign(this.literals, item));
            this.setupComponents();
            this.get();
        });
    }

    private checkInteractionOnForm(form: NgForm): void {
        if (form.dirty === true) {
            this.modalCancel.open();
        } else {
            this.location.back();
        }
    }

    private closeModal() {
        this.modalDelete.close();
        this.modalCancel.close();
    }

    private isValid() {

        // FIXME: Put validations here.
        // TODO: Waiting for the TOTVS UX Team deliver the right way to present the error messages.

        return true;
    }

    private get() {
        const id = parseInt(this.activatedRoute.snapshot.paramMap.get('id'), 10);
        if (id) {
            this.isPageEdit = true;
            this.service.getById(id).subscribe((item: I{pascalCase}) => {
                this.{camelCase} = item;
            });
        }
    }

    private create(item: I{pascalCase}) {
        if (this.isValid()) {
            this.service.create(item).subscribe(() => {
                this.router.navigate(['/{camelCase}']);
                this.thfNotification.success(this.literals['created{pascalCase}Message']);
            });
        }
    }

    private update() {
        this.service.update(this.{camelCase}).subscribe(() => {
            this.router.navigate(['/{camelCase}']);
            this.thfNotification.success(this.literals['updatedMessage']);
        });
    }

    private delete() {
        this.service.delete(this.{camelCase}.id).subscribe(data => {
            this.router.navigate(['/{camelCase}']);
            this.thfNotification.success(
                this.thfI18nPipe.transform(
                    this.literals['excluded{pascalCase}Message'], [this.{camelCase}.name]
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
            action: () => this.onConfirmDelete(), label: this.literals['remove']
        };

        this.confirmReturnToListAction = {
            label: this.literals['yes'], action: () => this.location.back()
        };

        this.editActions = [
            { label: this.literals['save'], action: this.update.bind(this, this.{camelCase}) },
            { label: this.literals['remove'], action: () => this.modalDelete.open() },
            { label: this.literals['return'], action: this.checkInteractionOnForm.bind(this, this.form{pascalCase}) }
        ];

        this.editBreadcrumb = {
            items: [
                { label: this.literals['{camelCase}'], link: '/{camelCase}' },
                { label: this.literals['edit{pascalCase}'], link: '/{camelCase}/edit' }
            ]
        };

        this.newActions = [
            { label: this.literals['save'], action: this.create.bind(this, this.{camelCase}), icon: 'thf-icon-plus' },
            { label: this.literals['return'], action: this.checkInteractionOnForm.bind(this, this.form{pascalCase}) }
        ];

        this.newBreadcrumb = {
            items: [
                { label: this.literals['{camelCase}'], link: '/{camelCase}' },
                { label: this.literals['addNew{pascalCase}'], link: '/{camelCase}/new' }
            ]
        };

        this.returnAction = {
            action: this.closeModal.bind(this), label: this.literals['return']
        };
    }

    ngOnDestroy(): void {}
}
