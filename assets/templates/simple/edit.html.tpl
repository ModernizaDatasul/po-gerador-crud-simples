<po-page-default
    [p-actions]="isPageEdit ? editActions : newActions"
    [p-breadcrumb]="isPageEdit ? editBreadcrumb : newBreadcrumb"
    [p-title]="isPageEdit ? literals?.edit{pascalCase} : literals?.addNew{pascalCase}">

    <div class="po-row">
        <div class="po-lg-6 po-offset-lg-3 po-xl-6 po-offset-xl-3">
            <form [formGroup]="form">
                <div>
                    <po-input
                        formControlName="name"
                        [p-error-pattern]="errorPattern"
                        p-required="true"
                        [p-placeholder]="literals?.name"
                        p-auto-focus="true"
                        [p-label]="literals?.name"
                        p-maxlength="50"
                        (p-change-model)="change()"
                        name="name"
                        p-clean>
                    </po-input>
                </div>
            </form>
        </div>
    </div>
</po-page-default>

<po-modal
    #modalDelete
    p-click-out="true"
    p-close
    p-size="auto"
    [p-title]="literals?.excludeTitle"
    [p-primary-action]="confirmDeleteAction"
    [p-secondary-action]="cancelModalAction">

    <div class="po-font-text-large po-text-left">
        {{ literals?.excludeText | poI18n: [{camelCase}.name] }}
    </div>
    
</po-modal>

<po-modal
    #modalCancel
    p-close
    p-size="auto"
    [p-title]="literals?.cancelTitle"
    [p-primary-action]="backModalAction"
    [p-secondary-action]="cancelModalAction">

    <div class="po-font-text-large po-text-left">
        {{ literals?.cancelText }}
    </div>

</po-modal>
