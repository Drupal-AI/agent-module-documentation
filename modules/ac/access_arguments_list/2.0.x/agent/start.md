<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Arguments List (access_arguments_list) — agent index

A developer convenience module: it adds a **"Machine name: `<permission>`"** line to every
permission row on the core permissions admin page (`/admin/people/permissions`), and lets you
click that machine name to **copy it to the clipboard**. Package `Access control`. Depends only
on core **`user`**. Core requirement `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 2.0.1.

- **What it does, how it hooks in, the JS/CSS, and how to use the copied name** →
  [config/behavior.md](config/behavior.md)

## What it actually is

- Pure **`.module`** file — no `src/`, no classes, no plugins, no routes, no services, no
  permissions of its own, no config, no config schema, no Drush, no install hook.
- Three hook implementations in `access_arguments_list.module`:
  - `access_arguments_list_help()` — renders `README.md` (via
    `extension.list.module`→`getPath()` + `file_get_contents`) on `help.page.access_arguments_list`.
  - `access_arguments_list_form_user_admin_permissions_alter()` — the core of the module.
  - (no other hooks.)

## Mechanism (from source)

- The form-alter targets core's **`user_admin_permissions`** form. It attaches library
  `access_arguments_list/permissions_form` (see `.libraries.yml`) and then loops
  `\Drupal::service('user.permissions')->getPermissions()`, overwriting each row's
  `$form['permissions'][$name]['description']['#context']['description']` with a
  `TranslatableMarkup` that prints the permission machine name inside
  `<code class="access-arguments-value">`.
- `js/access_arguments_list.js` is a plain (non-Drupal.behaviors) delegated click listener: click
  a `.access-arguments-value` → `navigator.clipboard.writeText()` the trimmed text, flash
  "✓ Copied!" for 1 s. `css/access_arguments_list.css` styles the label/value.

## Notes

- The machine name is passed as the `@permission` placeholder of `TranslatableMarkup`, so it is
  auto-escaped; the values are Drupal permission keys, not user input.
- The whole surface is the existing permissions form, gated by core's **`administer permissions`**.
  There is no new route, endpoint, or write path.
