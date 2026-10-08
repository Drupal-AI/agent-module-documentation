# eca_form plugins

Registers into ECA Core managers. Config schema: `config/schema/eca_form.schema.yml`.

**Events** (`FormEvent`, derived): form build/alter, validate, submit — for any form id.

**Conditions** (`src/Plugin/ECA/Condition`): `FormOperation`, `FormFieldExists`,
`FormFieldValue`, `FormSubmitted`, `FormTriggered`, `FormHasErrors` (base
`FormFieldConditionBase`).

**Actions** (`src/Plugin/Action`) — grouped:
- Add elements: `FormAddTextfield`, `FormAddHiddenField`, `FormAddOptionsField`,
  `FormAddContainerElement`, `FormAddGroupElement`, `FormAddSubmitButton`, `FormAddAjax`.
- Field properties: `FormFieldSetLabel`, `FormFieldSetDescription`, `FormFieldSetWeight`,
  `FormFieldDefaultValue`, `FormFieldGetDefaultValue`, `FormFieldSetOptions`,
  `FormFieldGetOptions`, `FormFieldSetValue`, `FormFieldGetValue`, `FormFieldRequire`,
  `FormFieldDisable`, `FormFieldAccess`, `FormFieldAddState`, `FormFieldSetError`.
- Form/state: `FormGetErrors`, `FormSetMethod`, `FormBuildEntity`, `FormSetAction`,
  `FormStateGetPropertyValue`, `FormStateSetPropertyValue`, `FormStateSetRebuild`,
  `FormStateSetRedirect`.

Many share bases (`FormActionBase`, `FormFieldActionBase`, `FormAddFieldActionBase`, etc.).
