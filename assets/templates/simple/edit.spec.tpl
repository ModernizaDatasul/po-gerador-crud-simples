import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { {pascalCase}EditComponent } from './{paramCase}.edit.component';

describe('{pascalCase}EditComponent', () => {

    let component: {pascalCase}EditComponent;
    let fixture: ComponentFixture<{pascalCase}EditComponent>;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [{pascalCase}EditComponent]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent({pascalCase}EditComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
