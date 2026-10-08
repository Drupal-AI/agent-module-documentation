<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Name — settings & the link alter

Everything the module does lives in two files: the settings form
`src/Form/AccountNameSettingsForm.php` and the hook `account_name_link_alter()` in
`account_name.module`.

## Install / enable

- `composer require drupal/account_name` then `drush en account_name -y` (or via
  `/admin/modules`). No dependencies outside core; core requirement `^8.9 || ^9 || ^10 || ^11`.
- To render a picture the user needs a populated core **`user_picture`** field and the chosen
  **image style** must exist (core `image` module). The module does not declare these as deps.

## Configuration

- **Route:** `account_name.settings_form` → `/admin/config/user-interface/account-name`.
- **Permission:** `administer site configuration`.
- **Menu link:** `account_name.links.menu.yml`, title "Account name settings", parent
  `system.admin_config_ui` (Configuration → User interface).
- **Form:** `AccountNameSettingsForm` (id `account_name_settings_form`), extends `ConfigFormBase`,
  editable config `account_name.settings`. It injects `entity_type.manager` to list image styles
  (`getStorage('image_style')->loadMultiple()`). `validateForm()` is empty. `submitForm()` saves
  `enable`, `flip`, `label`, `image_style` and shows a status message.

### Config object `account_name.settings`

Install defaults (`config/install/account_name.settings.yml`):

    enable: 1
    label: 'Welcome'
    image_style: 'thumbnail'

Schema (`config/schema/account_name.schema.yml`) declares `enable` (integer), `label` (string),
`image_style` (string).

Keys:

- `enable` — master on/off. When falsy the alter does nothing.
- `label` — greeting text prepended to the username (e.g. "Welcome", "Hi", "Hello").
- `image_style` — machine name of the image style used to render `user_picture`.
- `flip` — boolean written by the form and read by the alter to swap picture/name order.
  **Caveat:** `flip` is NOT present in the install config or the schema, only in the form and the
  hook, so it starts unset and produces a schema-checker notice (`account_name.settings:flip`)
  under strict config schema testing.

## How the link alter works (`account_name_link_alter(&$variables)`)

Named `account_name_link_alter`, so it is a `hook_link_alter` implementation (the `@Implements
hook_menu_alter()` docblock is inaccurate). Flow:

1. Loads `account_name.settings`; returns immediately if `enable` is falsy.
2. Reads `$variables['url']` (a `Url`); returns if it `isExternal()` or is not `isRouted()` — this
   avoids `UnexpectedValueException` from `getRouteName()` on external URLs.
3. Acts only when `$url->getRouteName() == 'user.page'` **and**
   `strtolower($variables['text']) == 'my account'`.
4. Builds `$accountName` = `FormattableMarkup('<div class="account-name">@accountname</div>',
   ['@accountname' => $label . ' ' . \Drupal::currentUser()->getAccountName()])`.
5. If the loaded current `User`'s `user_picture` is non-empty, renders it through the configured
   image style with label hidden, then `renderer->render()`.
6. Sets `$variables['text']` via `t()` to a `<div class="account-link">` containing the picture
   and name in the order chosen by `flip`.

Only the **current viewer's own** account name/picture is used; the alter targets the current
user's own menu link, not a list of other users.

## Operating notes

- If avatars don't appear, confirm the user has a `user_picture` value and that the selected image
  style exists; the picture branch is skipped when `user_picture` is empty.
- Match by the visible link text "my account" (case-insensitive) means renaming the core link text
  (e.g. via a translation/override) can stop the alter from firing.
- No template, block, or theme changes are required; the effect is purely in the link build.
