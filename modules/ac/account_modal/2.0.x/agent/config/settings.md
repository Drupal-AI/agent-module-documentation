<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring & operating Account Modal

## Install & enable

```bash
composer require drupal/account_modal
drush en account_modal -y
```

No hard dependencies. The **Profile** contrib module is optional and only unlocks the
profile add/edit pages and the post-registration profile dialog.

## Settings form

- Route: `account_modal.admin_settings` → **`/admin/config/user-interface/account-modal`**
  (menu link under *Configuration → User interface*).
- Requirement: `_permission: 'administer account_modal'`.
- Form: `Drupal\account_modal\Form\AccountModalSettingsForm` (`ConfigFormBase`, form id
  `account_modal_admin_settings`), editing config object **`account_modal.settings`**.

> Operational gotcha: the module does **not** ship a `*.permissions.yml`, so the
> `administer account_modal` permission is never declared and cannot be assigned to any role. Until
> some module defines it, only **user 1** can open the settings form. (This is a fail-closed access
> quirk, not a bypass.)

## Config keys (`account_modal.settings`)

Install defaults from `config/install/account_modal.settings.yml`; types from
`config/schema/account_modal.schema.yml`.

| Key | Default | Type | Meaning |
|---|---|---|---|
| `enabled_pages` | `{}` | mapping | Which pages open in a modal (`checkboxes`). Values are page ids: `page`, `login`, `register`, `password`, `cancel`, and with Profile `profile_add`, `profile_edit`. Empty = nothing modal-ized. |
| `hide_field_descriptions` | `FALSE` | integer/bool | Strip `#description` from every form element shown in the modal. |
| `reload_on_success` | `FALSE` | integer/bool | On success reload the current page (`RefreshPageCommand`) instead of redirecting. |
| `dialog_width` | `480` | string | Modal width in px or `auto`. |
| `dialog_height` | `auto` | string | Modal height in px or `auto`. |
| `messages_position` | `append` | string | `append` = messages below the form, `prepend` = above. |
| `create_profile_after_registration` | `FALSE` | boolean | After register, open a profile-create dialog. Requires Profile; the checkbox is disabled without it. |
| `profile_type` | `customer` | string | Profile bundle to create when the above is on. |
| `header_blocks` | `{}` | string | Block IDs (one per line) rendered in the dialog header for login/register/password. |
| `footer_blocks` | `{}` | string | Block IDs (one per line) rendered in the dialog footer. |

Config-export example:

```yaml
# account_modal.settings
enabled_pages:
  login: login
  register: register
  password: password
hide_field_descriptions: 0
reload_on_success: 1
dialog_width: '480'
dialog_height: auto
messages_position: append
create_profile_after_registration: false
profile_type: customer
header_blocks: ''
footer_blocks: ''
```

## How it works (mechanism)

Account Modal adds **no route that renders the auth forms** — they stay on their core routes, so all
their access control, flood protection and CSRF tokens are core's. It works through hooks in
`account_modal.module`:

1. **`hook_link_alter`** — for a routed link, `AccountPageHelper::getPageFromRoute($routeName)`
   checks whether the route belongs to an *enabled* page (exact match, or a regex entry for Profile's
   add route). If so it adds `class="use-ajax"`, `data-dialog-type="modal"`, and JSON
   `data-dialog-options` (`width`, `height`, `dialogClass = "account-modal account-modal--<page>"`).
   Core's `drupal.ajax`/`drupal.dialog` then load that link's target route into a modal.

2. **`hook_form_alter`** — guarded by `\Drupal::request()->isXmlHttpRequest()` (only alters when the
   form is loaded inside the AJAX dialog) and by
   `AccountPageHelper::getPageFromFormId($form_id)` (only the enabled account forms). It:
   - optionally calls `AccountModalAjaxHelper::hideFieldDescriptions($form)`;
   - for `login`/`register`/`password`, `AccountModalAjaxHelper::injectBlocks($form)` renders the
     configured header/footer blocks (via `Block::load()` + the block view builder);
   - wraps the form in `#account_modal_<page>_wrapper` and sets
     `$form['actions']['submit']['#ajax']['callback'] = 'account_modal_<page>_ajax_callback'`.

3. **AJAX callbacks** — `account_modal_{login,register,password,profile_add,profile_edit}_ajax_callback`
   call `AccountModalAjaxHelper::ajaxCallback($pageId, $form, $formState)`. Because these are core
   form `#ajax` callbacks, they run only after core has already validated the submission (including
   the form/CSRF token and flood control). The response:
   - if there are no error messages: closes the dialog (`CloseModalDialogCommand`); for `login` adds
     a success message + a redirect/reload command; for `register` adds a success message and either
     a redirect/reload or (Profile + `create_profile_after_registration`) an
     `OpenModalDialogCommand` with the profile add form;
   - always removes and re-renders `.account-modal-messages` (status messages) prepended or appended
     to the wrapper per `messages_position`.

4. **Redirect vs reload** — `AccountModalAjaxHelper::redirectCommand()` returns a `RefreshPageCommand`
   when `reload_on_success` is set, else a core `RedirectCommand` built from the form's own
   `$formState->getRedirect()` (the destination core assigns to the auth form). `RefreshPageCommand`
   emits the custom AJAX command `accountModalRefreshPage`; `js/account_modal.js`
   (`Drupal.behaviors.accountModal`) maps it to `window.location.reload()`.

## Extending the page list (event)

Other modules can add modal-capable pages by subscribing to `AccountModalEvents::PAGES`
(`'account_modal.pages'`), dispatched at the end of `AccountPageHelper::getPages()`. The listener
receives a `PagesEvent`; call `getPages()`, add an entry of the shape
`['label' => …, 'routes' => ['route.name' | '/regex/'], 'form' => 'form_id' | '/regex/' | FALSE]`,
then `setPages()`. A route/form entry beginning with `/` is treated as a regex.

## What it provides / does not

- **Provides:** one config object (`account_modal.settings`) with typed schema, one settings form,
  one menu link, one JS library, one custom AJAX command (`RefreshPageCommand`), and one event
  (`account_modal.pages`).
- **Does not provide:** entities, plugins, services, permissions file, Drush commands, REST/AJAX
  controller routes, or any external HTTP calls.

## Notes

- `hook_page_attachments` attaches the JS library on **every** page (there's a source `@todo` to
  scope it) — a minor front-end cost, not a functional issue.
- `enabled_pages` is empty by default; nothing becomes a modal until configured.
- Update hook `account_modal_update_8100` sets default `dialog_width`/`dialog_height` on old installs.
