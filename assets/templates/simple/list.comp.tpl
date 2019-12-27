import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';

import { ThfBreadcrumb } from '@totvs/thf-ui/components/thf-breadcrumb';
import { ThfDisclaimerGroup } from '@totvs/thf-ui/components/thf-disclaimer-group';
import { ThfDisclaimer } from '@totvs/thf-ui/components/thf-disclaimer/thf-disclaimer.interface';
import { ThfModalAction } from '@totvs/thf-ui/components/thf-modal';
import { ThfModalComponent } from '@totvs/thf-ui/components/thf-modal/thf-modal.component';
import { ThfPageAction, ThfPageFilter } from '@totvs/thf-ui/components/thf-page';
import { ThfTableColumn } from '@totvs/thf-ui/components/thf-table';
import { ThfI18nService, ThfI18nPipe } from '@totvs/thf-ui/services/thf-i18n';
import { ThfNotificationService } from '@totvs/thf-ui/services/thf-notification/thf-notification.service';

import { Observable, Subscription } from 'rxjs';

import { TotvsResponse } from '../shared/interfaces/totvs-response.interface';

import { I{pascalCase} } from '../shared/model/{paramCase}.model';
import { {pascalCase}Service } from '../shared/services/{paramCase}.service';

@Component({
    selector: 'app-{paramCase}',
    templateUrl: './{paramCase}.list.component.html',
    styleUrls: ['./{paramCase}.list.component.css']
})
export class {pascalCase}ListComponent implements OnInit, OnDestroy {

    @ViewChild('modalDelete') modalDelete: ThfModalComponent;

    private itemsSubscription$: Subscription;

    private disclaimers: Array<ThfDisclaimer> = [];

    cancelDeleteAction: ThfModalAction;
    confirmDeleteAction: ThfModalAction;

    pageActions: Array<ThfPageAction>;
    tableActions: Array<ThfPageAction>;

    breadcrumb: ThfBreadcrumb;
    disclaimerGroup: ThfDisclaimerGroup;
    filterSettings: ThfPageFilter;

    items: Array<ITicketStatus> = new Array<ITicketStatus>();
    columns: Array<ThfTableColumn>;

    hasNext: boolean = false;
    pageSize: number = 20;
    currentPage: number = 0;

    isLoading = true;
    quickSearchValue: string = '';

    literals: any = {};

    constructor(
        private service: {pascalCase}Service,
        private thfI18nPipe: ThfI18nPipe,
        private thfI18nService: ThfI18nService,
        private thfNotification: ThfNotificationService,
        private router: Router,
    ) {}

    ngOnInit(): void {
        Observable.forkJoin(
            this.thfI18nService.getLiterals(),
            this.thfI18nService.getLiterals({ context: '{camelCase}' })
        ).subscribe(literals => {
            literals.map(item => Object.assign(this.literals, item));
            this.setupComponents();
        });
    }

    searchByName(filter = [{ property: 'name', value: this.quickSearchValue }]): void {
        this.disclaimers = [...filter];
        this.disclaimerGroup.disclaimers = [...this.disclaimers];
    }

    search(loadMore = false): void {

        const disclaimer = this.disclaimers || [];

        if (loadMore === true) {
            this.currentPage = this.currentPage + 1;
        } else {
            this.items = [];
            this.currentPage = 1;
        }

        this.isLoading = true;
        this.itemsSubscription$ = this.service
            .query(disclaimer, this.currentPage, this.pageSize)
            .subscribe((response: TotvsResponse<I{pascalCase}>) => {
                this.items = [...this.items, ...response.items];
                this.hasNext = response.hasNext;
                this.isLoading = false;
            });
    }

    private delete(): void {

        let count = 0;
        const selected = this.items.filter((item: any) => item.$selected);

        if (selected.length > 0) {
            selected.map((item: I{pascalCase}) => {
                this.service.delete(item.id).subscribe(response => {
                    this.thfNotification.success(
                        this.thfI18nPipe.transform(
                            this.literals['excluded{pascalCase}Message'], [item.name]
                        )
                    );
                    if (++count === selected.length) {
                        this.search();
                    }
                }, (err:any) => {
                    if (++count === selected.length) {
                        this.search();
                    }
                });
            });
        }
    }

    private edit(item: I{pascalCase}): void {
        this.router.navigate(['/{camelCase}/edit', item.id]);
    }

    private resetFilters(): void {
        this.quickSearchValue = '';
    }

    private onChangeDisclaimer(disclaimers): void {
        this.disclaimers = disclaimers;
        if (this.disclaimers.length === 0) {
            this.resetFilters();
        }
        this.search();
    }

    private onConfirmDelete(): void {
        this.modalDelete.close();
        this.delete();
    }

    private setupComponents(): void {

        this.confirmDeleteAction = {
            action: () => this.onConfirmDelete(), label: this.literals['remove']
        };

        this.cancelDeleteAction = {
            action: () => this.modalDelete.close(), label: this.literals['return']
        };

        this.pageActions = [
            {
                label: this.literals['addNew{pascalCase}'],
                action: () => this.router.navigate(['{camelCase}/new']), icon: 'thf-icon-plus'
            },
            { label: this.literals['remove'], action: () => this.modalDelete.open() }
        ];

        this.tableActions = [
            { action: this.edit.bind(this), label: this.literals['edit'] },
        ];

        this.columns = [
            { column: 'id', label: this.literals['code'], type: 'string' },
            { column: 'name', label: this.literals['name'], type: 'link', action: (value, row) => this.edit(row) }
        ];

        this.breadcrumb = {
            items: [
                { label: this.literals['{camelCase}'], link: '/{camelCase}' }
            ]
        };

        this.disclaimerGroup = {
            title: this.literals['filters'],
            disclaimers: [],
            change: this.onChangeDisclaimer.bind(this)
        };

        this.filterSettings = {
            action: 'searchByName',
            ngModel: 'quickSearchValue',
            placeholder: this.literals['search']
        };
    }

    ngOnDestroy(): void {
        this.itemsSubscription$.unsubscribe();
    }
}
