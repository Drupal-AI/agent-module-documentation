<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Modal (account_modal) — agent index

Opens Drupal's **account links in an AJAX modal dialog** (jQuery UI dialog) instead of full-page
navigations — login, register, password reset, user page, account cancellation, and (with the
contrib **Profile** module) profile add/edit. Package `User interface`. Core `^10 || ^11`.
License GPL-2.0-or-later. Version 2.0.0. **No hard dependencies**; Profile is optional.

- **Settings form, config object + schema, the hook mechanism, routes, events, and how to operate
  it** → [config/settings.md](config/settings.md)

## What it actually is (from source)

- **Pure hook module — no custom form-rendering route.** The account forms are still served by their
  own core routes (`user.login`, `user.register`, `user.pass`, `user.cancel_confirm`, `user.page`,
  Profile's form routes). Account Modal only changes presentation, so core access checks, flood
  control and CSRF form tokens on those forms are unchanged.
- `account_modal.module`:
  - `hook_link_alter` — when a link's route matches a configured/enabled page, adds
    `use-ajax` + `data-dialog-type="modal"` + `data-dialog-options` (width/height from config,
    `dialogClass = account-modal account-modal--<page>`).
  - `hook_form_alter` — only on an XHR request and only for the enabled account forms: wraps the form
    in `#account_modal_<page>_wrapper`, sets `$form['actions']['submit']['#ajax']['callback']` to
    `account_modal_<page>_ajax_callback`, optionally strips field `#description`s, and injects
    header/footer blocks for login/register/password.
  - `hook_page_attachments` — attaches the `account_modal/account_modal` library on every page
    (there is a `@todo` to load it only when account links are present).
  - Procedural `account_modal_{login,register,password,profile_add,profile_edit}_ajax_callback`
    functions delegate to `AccountModalAjaxHelper::ajaxCallback()`.
- **Classes:**
  - `AccountPageHelper` — defines the supported pages array (page id → label, core route(s), core
    form id), reads `enabled_pages` config, and maps a route/form-id back to a page id
    (`getPageFromRoute()`, `getPageFromFormId()`). Dispatches the `account_modal.pages` event so other
    modules can add pages.
  - `AccountModalAjaxHelper` — builds the `AjaxResponse`: closes the dialog on success, adds a
    redirect (`RedirectCommand`) or full page reload (`RefreshPageCommand`), re-renders status
    messages inside the wrapper, hides field descriptions, injects blocks, and (register + Profile)
    opens a "Create a Profile" dialog.
  - `AjaxCommand\RefreshPageCommand` — custom AJAX command `accountModalRefreshPage`; the JS behavior
    in `js/account_modal.js` maps it to `window.location.reload()`.
  - `Event\AccountModalEvents` (const `PAGES = 'account_modal.pages'`) + `Event\PagesEvent`
    (get/set the pages array) — the extension point.
  - `Form\AccountModalSettingsForm` — `ConfigFormBase`, form id `account_modal_admin_settings`,
    edits config `account_modal.settings`.
- **Routes:** one only — `account_modal.admin_settings` at
  `/admin/config/user-interface/account-modal`, `_permission: 'administer account_modal'`. No
  controller, no AJAX endpoint route (the AJAX is core form `#ajax`, not a dedicated route).
- **Config:** object `account_modal.settings` (install defaults in `config/install/`, typed schema in
  `config/schema/`). No permissions.yml, no services.yml, no plugin types, no Drush.
- **Library:** `account_modal/account_modal` = `js/account_modal.js` + core jquery/drupal/
  drupal.ajax/drupal.dialog. No external/CDN assets.

## Caveats worth knowing

- The route requires permission `administer account_modal`, but the module ships **no
  `*.permissions.yml` declaring it**, so no role can be granted it — the settings form is reachable
  only by **user 1** unless another module defines that permission. Fail-closed, but a real
  operational gotcha.
- `enabled_pages` defaults to `{}` (empty), so out of the box **no** page opens in a modal until you
  configure it.
- Update hook `account_modal_update_8100` backfills default `dialog_width` (480) / `dialog_height`
  (auto).
