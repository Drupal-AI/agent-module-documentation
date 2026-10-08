<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The breakpoint settings modal (route, form, access, token)

The only route the module exposes. It is a per-widget helper that returns the four breakpoint
column-counts back into the editor — there is no global/site settings form and no `configure`
route in the info file.

## Route

`ck5_column_layout.routing.yml` → `ck5_column_layout.settings_form`:

- path `/admin/ck5-column-layout/settings`, `_form: \Drupal\ck5_column_layout\Form\ColumnSettingsForm`,
  title *Column Settings*.
- requirements: `_custom_access: ck5_column_layout.ajax_access_check:access` and
  `_csrf_token: TRUE`.
- options: `_admin_route: TRUE`.

## Access check

`src/Access/AjaxOnlyAccessCheck.php` (service `ck5_column_layout.ajax_access_check`,
`ck5_column_layout.services.yml`). `access(AccountInterface $account, Request $request)` returns
`AccessResult::allowed()` (cache context `url.query_args:_wrapper_format`) when the request is an
XmlHttpRequest **or** `_wrapper_format === 'drupal_modal'`, otherwise `AccessResult::forbidden()`.
It checks the request *shape*, not a permission. Access to the route therefore rests on the
`_csrf_token: TRUE` requirement plus the AJAX/modal shape.

## Form

`src/Form/ColumnSettingsForm.php`, `class ColumnSettingsForm extends FormBase`, form id
`flex_column_settings_form`. Injects `request_stack` (`create()`).

- `buildForm()` builds four `select` elements (`xs`, `sm`, `md`, `lg`), options *1-6 Columns*
  (xs/sm limited to 1-2, md to 1-4, lg full 1-6). Default values come from the query string
  (`$request->query->get('xs') ?: '1'`, etc.), i.e. the current widget's attributes passed by the
  JS. Submit uses `#ajax` callback `::ajaxSubmit`.
- `ajaxSubmit()` returns an `AjaxResponse` that: `InvokeCommand('body','trigger',['columnLayoutApply',[$data]])`
  with `$data = {xs,sm,md,lg}` from `getValue()`, then `CloseModalDialogCommand`, then refocuses
  `body`. This is how the chosen counts reach the editor (see [../plugins/ckeditor5.md](../plugins/ckeditor5.md)).
- `submitForm()` is **empty** — the form persists nothing; it only echoes the selected values back
  to the browser via the AJAX command. No config object, no state, no entity is written.

## Permission & token attachment

- Permission `ck5 column layout settings` (`ck5_column_layout.permissions.yml`) — *"Access CKEditor 5
  Column Settings"*. It gates the in-editor UI, surfaced through `drupalSettings` rather than on the
  route itself.
- `src/Render/ElementTokenAttachment.php` (`TrustedCallbackInterface`, method `attachToken`) is
  attached to every `text_format` render element by `ck5_column_layout_element_info_alter`
  (`hook_element_info_alter`). It writes into
  `drupalSettings.ck5_column_layout`: `hasPermission` = `current_user->hasPermission('ck5 column
  layout settings')`, and `token` = CSRF token for the route's internal path
  (`csrf_token->get($path)`, wrapped in try/catch that logs to the `ck5_column_layout` channel on
  failure). Adds cache contexts `user.permissions` and `session`.

No config schema and no `config/install` are shipped (`provides_config_schema: false`); the module
stores no configuration of its own.
