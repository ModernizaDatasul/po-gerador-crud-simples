import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';

import { Observable } from 'rxjs';

import { ThfDisclaimer } from '@totvs/thf-ui/components/thf-disclaimer/thf-disclaimer.interface';

import { TotvsResponse } from '../interfaces/totvs-response.interface';

import { I{pascalCase} } from '../model/{paramCase}.model';

@Injectable()
export class {pascalCase}Service {

    // FIXME: Change to the backend service URL
    private apiUrl = '/{camelCase}';

    constructor(private http: HttpClient) { }

    query(filters: ThfDisclaimer[], page = 1, pageSize = 20): Observable<TotvsResponse<I{pascalCase}>> {
        
        let url: string = `${this.apiUrl}?pageSize=${pageSize}&page=${page}`;

        if (filters && filters.length > 0) {

            const urlParams = new Array<String>();

            filters.map(filter => {
                urlParams.push(`${filter.property}=${filter.value}`);
            });

            url = `${url}&${urlParams.join('&')}`;
        }

        return this.http.get<TotvsResponse<I{pascalCase}>>(url);
    }

    getById(id: number): Observable<I{pascalCase}> {
        return this.http.get<I{pascalCase}>(`${this.apiUrl}/${id}`);
    }

    create(model: I{pascalCase}): Observable<I{pascalCase}> {
        return this.http.post<I{pascalCase}>(`${this.apiUrl}`, model);
    }

    update(model: I{pascalCase}): Observable<I{pascalCase}> {
        return this.http.put<I{pascalCase}>(`${this.apiUrl}/${model.id}`, model);
    }

    delete(id: number): Observable<Object> {
        return this.http.delete(`${this.apiUrl}/${id}`);
    }

}
