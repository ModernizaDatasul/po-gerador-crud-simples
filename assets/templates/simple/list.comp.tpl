import { Component, OnDestroy, OnInit, ViewChild } from '@angular/core';
import { Router } from '@angular/router';

import {
    PoBreadcrumb, PoDisclaimerGroup, PoDisclaimer, PoModalAction,
    PoModalComponent, PoPageAction, PoPageFilter, PoTableColumn,
    PoI18nService, PoI18nPipe, PoNotificationService
} from '@portinari/portinari-ui';

import { forkJoin, Subscription } from 'rxjs';

import { TotvsResponse } from '../shared/interfaces/totvs-response.interface';

import { I{pascalCase} } from '../shared/model/{paramCase}.model';
import { {pascalCase}Service } from '../shared/services/{paramCase}.service';

@Component({
    selector: 'app-{paramCase}',
    templateUrl: './{paramCase}.list.component.html',
    styleUrls: ['./{paramCase}.list.component.css']
})
export class {pascalCase}ListComponent implements OnInit, OnDestroy {

    @ViewChild('modalDelete', { static: false }) modalDelete: PoModalComponent;

    private itemsSubscription$: Subscription;
    private disclaimers: Array<PoDisclaimer> = [];

    cancelDeleteAction: PoModalAction;
    confirmDeleteAction: PoModalAction;

    pageActions: Array<PoPageAction>;
    tableActions: Array<PoPageAction>;

    breadcrumb: PoBreadcrumb;
    disclaimerGroup: PoDisclaimerGroup;
    filterSettings: PoPageFilter;

    items: Array<I{pascalCase}> = new Array<I{pascalCase}>();
    columns: Array<PoTableColumn>;

    hasNext = false;
    pageSize = 20;
    currentPage = 0;
    isLoading = true;
    quickSearchValue = '';
    moreSelected = false;
    selectedLength = 0;

    literals: any = {};

    constructor(
        private service: {pascalCase}Service,
        private poI18nPipe: PoI18nPipe,
        private poI18nService: PoI18nService,
        private poNotification: PoNotificationService,
        private router: Router,
    ) { }

    ngOnInit(): void {
        forkJoin(
            this.poI18nService.getLiterals(),
            this.poI18nService.getLiterals({ context: '{camelCase}' })
        ).subscribe(literals => {
            literals.map(item => Object.assign(this.literals, item));
            this.setupComponents();
            this.search();
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
                    this.poNotification.success(
                        this.poI18nPipe.transform(
                            this.literals['excludedMessage'], [item.name]
                        )
                    );
                    if (++count === selected.length) {
                        this.search();
                    }
                }, (err: any) => {
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
        this.selectedLength = 0;
        this.moreSelected = false;
    }

    private cancelDelete() {
        this.modalDelete.close();
        this.selectedLength = 0;
        this.moreSelected = false;
    }

    private selected() {
        return !this.items.find(item => item['$selected']);
    }

    private deleteModalValidate() {
        const selected = this.items.filter((item: any) => item.$selected);
        if (selected.length > 1) {
            this.moreSelected = true;
            this.selectedLength = selected.length;
        }
        this.modalDelete.open();
    }

    private setupComponents(): void {

        this.confirmDeleteAction = { 
            action: () => this.onConfirmDelete(), 
            label: this.literals['yes'] 
        };

        this.cancelDeleteAction = { 
            action: () => this.cancelDelete(), 
            label: this.literals['no'] 
        };

        this.pageActions = [
            {
                label: this.literals['addNew{pascalCase}'],
                action: () => this.router.navigate(['{camelCase}/new']), icon: 'po-icon-plus'
            },
            { 
                label: this.literals['remove'], 
                action: () => this.deleteModalValidate(), 
                disabled: () => this.selected()
            }
        ];

        this.columns = [
            { 
                property: 'name', 
                label: this.literals['name'], 
                type: 'link', 
                action: (value, row) => this.edit(row) 
            }
        ];

        this.breadcrumb = {
            items: [
                { 
                    label: this.literals['{camelCase}'], 
                    link: '/{camelCase}' 
                }
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
