<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Column Layout (ck5_column_layout) — agent index

A **CKEditor 5 plugin** that inserts responsive, flexbox multi-column sections (`div.cl-flex-row`
with 1-6 `div.cl-flex-col` children) into rich-text fields. Column stacking per breakpoint is set
through an in-editor **AJAX modal**. Package *CKEditor 5*. Depends only on core **`ckeditor5`**.
Core `^10 || ^11`. License GPL-2.0-or-later. Version 1.0.1. No config entities, no Drush, no
config schema.

- **The CKEditor 5 plugin, toolbar button, widget model/converters, JS behavior** →
  [plugins/ckeditor5.md](plugins/ckeditor5.md)
- **The output filter + entity_presave cleanup + allowed elements** →
  [filters/filter.md](filters/filter.md)
- **The settings modal: route, form, AJAX access check, CSRF token, permission** →
  [config/settings-modal.md](config/settings-modal.md)

## What it actually is (from source)

- **CKEditor 5 plugin** declared in `ck5_column_layout.ckeditor5.yml` (`ck5_column_layout_plugin`):
  JS plugin `columnLayout.columnLayout`, toolbar item `columnLayout` (label *Columns*), library
  `ck5_column_layout/editor`, admin library `ck5_column_layout/admin`. Allowed `elements` are only
  `<div class="cl-flex-row" data-xs data-sm data-md data-lg contenteditable>` and
  `<div class="cl-flex-col" contenteditable>`. It is `conditions: filter: filter_ck5_column_layout`
  (button only available when that filter is enabled). JS in `js/ck5-column-layout.js`.
- **Text filter** `filter_ck5_column_layout` (`src/Plugin/Filter/FilterColumnLayout.php`, label
  *"CKEditor 5 Column Layout Asset Loader & Cleaner"*, `TYPE_TRANSFORM_REVERSIBLE`) — removes
  editor-only markers/attributes, clamps `data-xs/sm/md/lg` to a single digit 1-6, and attaches the
  `ck5_column_layout/editor` library.
- **Route** `ck5_column_layout.settings_form` → `/admin/ck5-column-layout/settings`, a `FormBase`
  `ColumnSettingsForm` (`src/Form/ColumnSettingsForm.php`, form id `flex_column_settings_form`)
  served as a modal. Requirements: `_custom_access` (AJAX/modal only) + `_csrf_token: TRUE`.
- **Custom access service** `ck5_column_layout.ajax_access_check` →
  `AjaxOnlyAccessCheck` (`src/Access/AjaxOnlyAccessCheck.php`): allows the route only for
  XmlHttpRequest or `_wrapper_format=drupal_modal` requests.
- **Pre-render callback** `ElementTokenAttachment::attachToken` (`src/Render/ElementTokenAttachment.php`,
  a `TrustedCallbackInterface`) added to every `text_format` element via
  `hook_element_info_alter`; puts `hasPermission` and a CSRF `token` into
  `drupalSettings.ck5_column_layout`.
- **Permission** `ck5 column layout settings` (`ck5_column_layout.permissions.yml`) — gates the
  in-editor controls and the modal (checked in the pre-render and in JS).
- **`hook_entity_presave`** (`ck5_column_layout.module`) rewrites text/text_long/text_with_summary
  field values containing `cl-flex`, replacing editor control `div`s with `data-cl-marker` spans and
  stripping `contenteditable`/`role`.
- **`hook_help`** for `help.page.ck5_column_layout`. One kernel test:
  `tests/src/Kernel/ColumnLayoutFilterTest.php`.

## Setup (from hook_help)

1. On *Text formats and editors*, edit a format and drag the **Columns** button into the toolbar.
2. On the same format, enable the **"CKEditor 5 Column Layout Asset Loader & Cleaner"** filter
   (order it **after** *Limit allowed HTML tags*).
3. Grant the **`ck5 column layout settings`** permission to roles that may configure breakpoints.

No `configure` route / global settings form — the only route is the per-widget breakpoint modal.
