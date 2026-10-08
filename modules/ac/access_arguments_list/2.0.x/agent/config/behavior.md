<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Behavior & operation

## Install / enable

- `composer require drupal/access_arguments_list` then `drush en access_arguments_list -y`.
- Requires core `user` (always present). No configuration, no settings form, nothing to set up.
- Core requirement `^9.3 || ^10 || ^11`.

## What happens after enabling

Go to **People → Permissions** (`/admin/people/permissions`). Under each permission's description
you now see a line like:

> Machine name: `administer book outlines`

Click the machine name and it is copied to your clipboard (a "✓ Copied!" flash confirms).

## How it works (files)

- `access_arguments_list.module`:
  - `access_arguments_list_form_user_admin_permissions_alter(&$form, $form_state)` — implements
    `hook_form_FORM_ID_alter()` for the core **`user_admin_permissions`** form. It:
    1. Attaches `$form['#attached']['library'][] = 'access_arguments_list/permissions_form'`.
    2. Calls `\Drupal::service('user.permissions')->getPermissions()`
       (`PermissionHandlerInterface`).
    3. For each `$permission_name`, replaces
       `$form['permissions'][$permission_name]['description']['#context']['description']` with a
       `TranslatableMarkup` rendering
       `<div class="access-arguments-item"><span class="access-arguments-label">Machine name:</span>
       <code class="access-arguments-value">@permission</code></div>`, where `@permission` is the
       machine name (auto-escaped placeholder).
  - `access_arguments_list_help()` — returns `README.md` wrapped in `<pre>` on the module's help
    page.
- `access_arguments_list.libraries.yml` defines the **`permissions_form`** library:
  `css/access_arguments_list.css` (theme) + `js/access_arguments_list.js`.
- `js/access_arguments_list.js` — a plain IIFE (not registered as a `Drupal.behaviors`), attaches
  a single delegated `click` listener on `document`. On a click inside `.access-arguments-value`
  it calls `navigator.clipboard.writeText(value.textContent.trim())`, swaps the text to
  "✓ Copied!" for 1000 ms, then restores it. Clipboard copy requires a secure context (HTTPS or
  localhost) as browsers gate the Clipboard API.

## Routes & permissions

None added. The only affected page is core's `/admin/people/permissions`, gated by core's
**`administer permissions`** permission. The module defines no routes, permissions, services,
config objects, config schema, plugins, Drush commands, or install/update hooks.

## Using the copied machine name

The machine name is exactly what you pass as an access argument. Example routing requirement:

```yaml
my_module.example:
  path: '/example'
  defaults:
    _controller: '\Drupal\my_module\Controller\ExampleController::content'
  requirements:
    _permission: 'administer book outlines'
```

Or in code: `$account->hasPermission('administer book outlines')`.
