<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# User display name (user_display_name) — agent index

Adds a **`display_name` string base field** to every user account and makes Drupal render it
instead of the username, by riding core's own name-resolution hook. Depends on core `user` only.
Core requirement `^10.1 || ^11 || ^12` (already declares Drupal 12). **No routes, permissions,
config UI, plugins, services or Drush commands** — the entire module is four hook implementations
in `src/Hook/UserDisplayNameHooks.php`.

## What you'd do → where

- **Read/set the `display_name` field, understand the four hooks, or further alter the shown name
  (custom format, fallbacks) in your own module** → [api/user_display_name.md](api/user_display_name.md)

## Key facts

- Mechanism: `hook_user_format_name_alter` swaps `$name` for `$account->display_name->value` when
  that value is non-empty, so anything rendering an *account* picks it up automatically. That is why
  the module is so small.
- `hook_entity_base_field_info` defines the `display_name` field (type `string`, translatable, form
  widget `text_textfield`); `hook_install` / `hook_uninstall` install/remove the field storage;
  `user_display_name.post_update.php` migrates existing rows. `hook_user_prepare_form` seeds an empty
  `display_name` with the current username on user-edit.
- Existing users keep showing their username until they set a display name.
- **If the goal is privacy, the raw username still leaks** at `/admin/people`, in JSON:API/REST user
  resources, in any View that adds the `name` field directly, and in login / password-reset flows.
  The hook covers rendered accounts, not every path that reads `name`.
- Surface: `src/Hook/UserDisplayNameHooks.php`, `user_display_name.module` (`#[LegacyHook]`
  wrappers), `.install`, `.post_update.php`, `.services.yml` (autowires the hook class).
- Modern, minimal alternative to Real Name and similar; nothing is migrated from those automatically.
