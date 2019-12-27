export interface I{pascalCase} {
    id: number;
    name: string;
}

export class {pascalCase} implements I{pascalCase} {

    id: number;
    name: string;

    constructor(values: Object = {}) {
        Object.assign(this, values);
    }

    get $id() {
        return this.id;
    }

    get $name() {
        return this.name;
    }

    set $id(id: number) {
        this.id = id;
    }

    set $name(name: string) {
        this.name = name;
    }

    static of(json: any = {}) {
        return new {pascalCase}(json);
    }

    static empty() {
        return new {pascalCase}();
    }

    static fromJson(json: Array<any> = []) {

        const items: Array<I{pascalCase}> = [];

        for (const values of json) {
            items.push(new {pascalCase}(values));
        }

        return items;
    }

}
