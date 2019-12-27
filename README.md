# [Portinari](https://portinari.io/) Gerador de CRUD Simples Portinari

Esse extensão cria um CRUD básico com toda a estrutura necessário utilizando o Portinari

Estrutura das pastas:

```html
- shared
    - interfaces
        > totvs-response.interface.ts
    - literals
        - i18n
            > component-name-pt.ts
            > component-name-en.ts
            > component-name-es.ts
    - model
        > component-name.ts
    - services
        > component-name.service.ts
- component-name
    - edit
        > component-name.edit.component.css
        > component-name.edit.component.html
        > component-name.edit.component.ts
        > component-name.edit.component.spec.ts
    > component-name.list.component.css
    > component-name.list.component.html
    > component-name.list.component.ts
    > component-name.list.component.spec.ts
    > component-name-routing.module.ts
    > component-name.module.ts
```