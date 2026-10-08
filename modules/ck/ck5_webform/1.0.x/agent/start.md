<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Webform Embed (ck5_webform) — agent index

Lets editors embed a **Webform** into rich text. A CKEditor 5 plugin inserts a
`<drupal-webform data-webform-id="ID">` tag (shown as a placeholder in the editor); a text-format
**filter** rewrites that tag into the live webform on display. Package `CKEditor 5`. Core
`^10 || ^11`. Depends on core **`ckeditor5`** and contrib **`webform` (^6.2)**. License
GPL-2.0-or-later. Version 1.0.0. No permissions, no settings form, no config schema, no Drush.

- **The render filter + how the tag becomes a form** → [plugins/filter.md](plugins/filter.md)
- **The CKEditor 5 widget, the select modal, the route + CSRF token wiring** →
  [plugins/editor.md](plugins/editor.md)

## What it actually provides (from source)

- **Filter plugin** `filter_ck5_webform` — `WebformFilter` (`src/Plugin/Filter/WebformFilter.php`),
  `TYPE_TRANSFORM_REVERSIBLE`. Regex-replaces `<drupal-webform … data-webform-id="X" …>…</drupal-webform>`
  with the rendered webform. Injects `entity_type.manager` + `renderer`.
- **CKEditor 5 plugin** declared in `ck5_webform.ckeditor5.yml` (`ck5_webform_insert`): toolbar item
  `webformInsert` (label "Embed Webform"), allowed element `<drupal-webform data-webform-id>`,
  condition `filter: filter_ck5_webform`. JS `WebformInsert` in `js/webforminsert.js`.
- **Modal form** `WebformSelectForm` (`src/Form/WebformSelectForm.php`, form id
  `ck5_webform_select_form`) — a `<select>` of open webforms; AJAX submit fires JS
  `ck5WebformInsertTrigger` to insert the chosen ID.
- **Route** `ck5_webform.open_modal` at `/ck5-webform/insert-modal` (`ck5_webform.routing.yml`):
  `_form: WebformSelectForm`, `_access: 'TRUE'`, `_csrf_token: 'TRUE'`, `_admin_route: TRUE`.
- **Pre-render / trusted callback** `ElementTokenAttachment::attachToken`
  (`src/Render/ElementTokenAttachment.php`) — added to the `text_format` element via
  `hook_element_info_alter` (`ck5_webform.module`); injects the modal route's CSRF token into
  `drupalSettings.ck5_webform.token` and adds `user.permissions` + `session` cache contexts.
- **Libraries** (`ck5_webform.libraries.yml`): `ck5_webform/webform` (JS, deps core/drupal,
  core/drupal.ajax, core/jquery) and `ck5_webform/admin` (`css/admin.css`).
- **Hooks** (`ck5_webform.module`): `hook_element_info_alter`, `hook_help`.

## Mechanism (from source)

- On save, the CKEditor widget downcasts to `<drupal-webform data-webform-id="ID">` in the stored
  markup (`_defineConverters`, dataDowncast). Nothing is rendered client-side.
- On view, `WebformFilter::process()` early-returns unless the text contains `drupal-webform`, then
  for each match loads the webform by ID and, **only if `$webform->isOpen()`**, renders
  `getViewBuilder('webform')->view($webform)` (→ Webform's `WebformEntityViewBuilder::view()` →
  `$webform->getSubmissionForm()`) and adds the webform as a cacheable dependency. Non-existent or
  non-open IDs render to an empty string.
- Submission access, handlers, confirmation, spam protection etc. are all Webform's own — this
  module only injects the render output.

## Not present

No `*.permissions.yml`, no `*.services.yml`, no `config/install` or `config/schema`, no `.install`,
no settings route, no submodules, no Drush commands.
