<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Permissions: `access language <langcode>`

The module has **no config UI**. Its only control surface is a set of **dynamic
permissions**, one per configured language.

## The permission

- **Machine name:** `access language <langcode>` — the string `access language ` plus the
  language id, e.g. `access language en`, `access language fr`, `access language de`.
- **Built by:** `Drupal\language_access\LanguageAccessPermissions::permissions()`
  (registered via `permission_callbacks` in `language_access.permissions.yml`). It loops
  over `\Drupal::languageManager()->getLanguages()` and emits one permission per language,
  titled *"Access language @language"*. Adding a new site language automatically creates a
  new permission after a cache rebuild.
- **What it gates:** having the permission for langcode `X` means the role may view pages
  served in language `X`, see `X` in the language switcher / hreflang / sitemap, and pick
  `X` in language selects. Lacking it → 403 on `X` pages and `X` is hidden everywhere.

## Install defaults

`hook_install()` grants `access language <default>` (the site default language, usually
`en`) to both the **anonymous** and **authenticated** roles, so the default language keeps
working out of the box. No other permission is granted — every non-default language starts
locked until you grant it.

## Grant / revoke it

- **UI:** *People → Permissions* (`/admin/people/permissions`), filter for
  "Access language", tick the box per role.
- **Drush:** `drush role:perm:add <role> 'access language fr'` /
  `drush role:perm:remove <role> 'access language fr'`.
- **Programmatically:**
  ```php
  \Drupal\user\Entity\Role::load('editor')
    ->grantPermission('access language fr')->save();
  ```
- Grant an "every language" role by adding all `access language *` permissions.

Because these are ordinary Drupal permissions they export with `user.role.*` config and
deploy across environments like any other permission.
