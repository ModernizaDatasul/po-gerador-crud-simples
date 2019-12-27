<thf-page-default
    [t-actions]="isPageEdit ? editActions : newActions"
    [t-breadcrumb]="isPageEdit ? editBreadcrumb : newBreadcrumb"
    [t-title]="isPageEdit ? literals?.edit{pascalCase} : literals?.addNew{pascalCase}"
>

    <div class="thf-row">
        <div class="thf-lg-6 thf-offset-lg-3 thf-xl-6 thf-offset-xl-3">
            <form #form{pascalCase}="ngForm">

                <div class="thf-row">

                    <thf-input
                        class="thf-md-12"
                        name="name"
                        [(ngModel)]="{camelCase}.name"
                        t-clean
                        [t-label]="literals?.name"
                        t-minlength="3"
                        [t-placeholder]="literals?.name"
                        t-required="true"
                        #uname="ngModel"
                    >
                    </thf-input>

                </div>

            </form>
        </div>
    </div>
</thf-page-default>

<thf-modal
    #modalDelete
    t-close
    t-size="sm"
    [t-title]="literals?.modalDeleteTitle"
    [t-primary-action]="confirmDeleteAction"
    [t-secondary-action]="returnAction"
>
    <div class="thf-font-text-large thf-text-left">
        {{ literals?.modalDeleteMessage }}
    </div>
</thf-modal>

<thf-modal
    #modalCancel
    t-close
    t-size="sm"
    [t-title]="literals?.modalCancelEditTitle"
    [t-primary-action]="confirmReturnToListAction"
    [t-secondary-action]="returnAction"
>
    <div class="thf-font-text-large thf-text-left">
        {{ literals?.modalCancelEditMessage }}
    </div>
</thf-modal>
