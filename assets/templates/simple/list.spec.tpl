import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { {pascalCase}ListComponent } from './{paramCase}.list.component';

describe('{pascalCase}ListComponent', () => {

    let component: {pascalCase}ListComponent;
    let fixture: ComponentFixture<{pascalCase}ListComponent>;

    beforeEach(async(() => {
        TestBed.configureTestingModule({
            declarations: [{pascalCase}ListComponent]
        }).compileComponents();
    }));

    beforeEach(() => {
        fixture = TestBed.createComponent({pascalCase}ListComponent);
        component = fixture.componentInstance;
        fixture.detectChanges();
    });

    it('should create', () => {
        expect(component).toBeTruthy();
    });
});
