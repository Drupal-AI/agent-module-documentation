<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Account Name (account_name) — agent index

Rewrites the core **"My account"** user-menu link to show a greeting **label + the current
user's username** and (optionally) their **user picture** through a chosen image style. Display
only. No dependencies beyond Drupal core. Core requirement `^8.9 || ^9 || ^10 || ^11`.
License GPL-2.0-or-later. Version 2.1.2.

- **The settings form, config object, keys, route/permission, and how the link alter works** →
  [config/settings.md](config/settings.md)

## What it actually is

- One hook: `account_name_link_alter(&$variables)` in `account_name.module` (a
  `hook_link_alter`; the docblock mislabels it `hook_menu_alter`). Runs on every link build.
- One admin form: `Drupal\account_name\Form\AccountNameSettingsForm` (`ConfigFormBase`), form id
  `account_name_settings_form`, at route **`account_name.settings_form`**
  (`/admin/config/user-interface/account-name`, permission **`administer site configuration`**),
  linked from *Configuration → User interface* via `account_name.links.menu.yml`.
- One config object: **`account_name.settings`** (schema in `config/schema/`, install defaults in
  `config/install/`).
- Also `account_name_help()` (help.page text). **No** permissions.yml, **no** services, **no**
  plugins, **no** entities, **no** Drush, **no** libraries.

## Mechanism (from source)

- The alter returns early unless `account_name.settings:enable` is set, and unless the link's
  `Url` is routed/internal (guards against `UnexpectedValueException` on external URLs).
- It only acts when the link's route is `user.page` **and** its lowercased text equals
  `my account`. It then builds the display from `\Drupal::currentUser()->getAccountName()`
  (the current viewer's own name) prefixed by the configured `label`.
- The name is wrapped with `FormattableMarkup('<div class="account-name">@accountname</div>', …)`
  (the `@` placeholder escapes it). If the current user's `user_picture` is non-empty it is
  rendered via `$user->user_picture->view(['settings' => ['image_style' => …]])` and the
  renderer. The `flip` flag chooses picture-before-name vs. name-before-picture; both branches
  build the final `$variables['text']` with `t()` and `@` placeholders over the already-safe
  markup.

## Settings (`account_name.settings`)

`enable` (int, default 1), `label` (string, default `Welcome`), `image_style` (string, default
`thumbnail`), and `flip` (checkbox in the form controlling picture/name order — note: `flip` is
read by the module and set by the form but is absent from `config/schema` and `config/install`).
Details in [config/settings.md](config/settings.md).
