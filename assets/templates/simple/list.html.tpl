<po-page-list
    [p-title]="literals?.{camelCase}"
    [p-actions]="pageActions"
    [p-breadcrumb]="breadcrumb"
    [p-disclaimer-group]="disclaimerGroup"
    [p-filter]="filterSettings">

    <po-table
        p-checkbox="true"
        p-hide-select-all="true"
        [p-columns]="columns"
        [p-items]="items"
        [p-show-more-disabled]="!hasNext"
        (p-show-more)="search(true)">        
    </po-table>
    
</po-page-list>

<po-modal
    #modalDelete
    p-close
    p-size="auto"
    [p-title]="literals?.excludeTitle"
    [p-primary-action]="confirmDeleteAction"
    [p-secondary-action]="cancelDeleteAction">

    <div class="po-font-text-large po-text-left">
        {{ !moreSelected? literals?.excludeOne:literals?.excludeMore | poI18n:[selectedLength] }}
    </div>

</po-modal>
