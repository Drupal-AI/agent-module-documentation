<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Paragraphs tabs bootstrap displays the items of a multi-value Paragraphs reference field as Bootstrap 5 tabs (or pills), horizontally or vertically, and gives editors a matching tabbed widget for managing them.

---

The module ships a field formatter (`ParagraphsTabsBootstrapFormatter`) and field widget (`ParagraphsTabsBootstrapWidget`) for entity-reference-revisions/paragraph fields, plus front-end libraries (`paragraphs-tabs-bootstrap`, `paragraphs-vertical-tabs-bootstrap`) built on core jQuery/once/js-cookie. Formatter settings (schema in `config/install`) include vertical vs horizontal, tab vs pill mode, the form mode used for inline editing, a custom CSS class, bottom text, and which buttons/operations to hide. It also exposes an AJAX "add component" flow: a route `/paragraphs-tabs/add/{paragraph_type}/{entity_type}/{entity_field}/{entity_id}` (`ComponentFormController::addForm`) opens `AddComponentForm` in a modal dialog; on submit the form creates the new paragraph and appends it to the host entity's field, then reloads.

That add route is guarded by a custom access check (`ParagraphAccessController::accessAdd`): if `paragraphs_type_permissions` is enabled it requires the `create paragraph content <bundle>` permission; if `field_permissions` is enabled it honours that field's permission model; otherwise it falls back to requiring `update` access on the parent host entity. So the mutating endpoint is not anonymous — it requires edit rights on the target entity (or the relevant paragraph/field permission). Setup: add a Paragraphs field, then on the content type's Manage form display / Manage display choose the "Paragraphs Tabs" widget and formatter and pick tab orientation and mode. A Bootstrap 5 theme is expected for correct styling.
---
- Display a Paragraphs field as horizontal Bootstrap tabs
- Display a Paragraphs field as vertical Bootstrap tabs
- Render the tabs as Bootstrap pills instead of tabs
- Give editors a tabbed widget for managing many paragraphs
- Add a new paragraph via an AJAX modal without leaving the page
- Choose which form mode is used when editing paragraphs inline
- Hide selected row operation buttons to simplify the editor UI
- Add a custom CSS class to the tab container for theming
- Append extra text below the tab set
- Organise long stacks of paragraphs into navigable tabs
- Improve editor UX for content types with many paragraph components
- Respect paragraphs_type_permissions when adding components
- Respect field_permissions on the paragraphs field when adding components
- Fall back to parent-entity update access when no permission module is present
- Present multi-section landing pages as tabbed content on the front end
- Switch a single content type between tab and pill presentation
- Integrate field_group rendering inside the add-component modal
- Build FAQ-style or step-by-step tabbed layouts from paragraphs
- Keep the active tab via js-cookie across interactions
- Style tabs consistently with a Bootstrap 5 front-end theme
