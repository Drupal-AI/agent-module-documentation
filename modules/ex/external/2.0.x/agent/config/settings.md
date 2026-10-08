<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Links — configuration, route & new-tab behaviour

Focused reference for the whole module (it is small: one config object, one form, one JS behaviour).

## Install / enable

- `composer require drupal/external` then enable `external` (Drush: `drush en external -y`).
- No dependencies beyond Drupal core (`core_version_requirement: ^10 || ^11`).
- On uninstall, `external_uninstall()` (`external.install`) deletes the `external.settings` config.

## Configuration

Config object `external.settings` (defaults in `config/install/external.settings.yml`, schema in
`config/schema/external.schema.yml`):

| Key | Type | Default | Meaning |
| --- | --- | --- | --- |
| `external_enabled` | boolean | `true` | Master switch. When false, the library is never attached. |
| `external_docs_enabled` | boolean | `false` | When true, links ending in `.pdf` also open in a new tab. Mirrored to `drupalSettings.external.externalpdf`. |
| `external_disabled_patterns` | string | `admin*`\n`img_assist*`\n`node/add/*`\n`node/*/edit` | One Drupal path per line on which the behaviour is suppressed. |

Edit them at **`/admin/config/content/external`** via `Drupal\external\Form\ExternalAdminSettings`
(a `ConfigFormBase`; `getEditableConfigNames()` = `['external.settings']`). The pattern textarea
accepts the `*` wildcard and the `<front>` token (for the site's configured front page).

## Route & permission

- Route `external.admin_settings` → path `/admin/config/content/external`, form
  `ExternalAdminSettings`, requirement `_permission: 'administer external'`
  (`external.routing.yml`).
- Permission `administer external` is declared with `restrict access: TRUE`
  (`external.permissions.yml`).
- Admin menu link `external.admin_settings` under `system.admin_config_content`
  (`external.links.menu.yml`).

## When the behaviour runs (server side)

`external_page_attachments(&$page)` (`external.module`) attaches library `external/external` and
`drupalSettings.external.externalpdf` **only if** `external_enabled` is true **and**
`external_active()` returns true.

`external_active()` compiles `external_disabled_patterns` into a regexp: it `preg_quote()`s the raw
string, then turns `*` into `.*` and `<front>` into the configured `system.site` front-page path, and
matches it against the current path (`path.current`) and, separately, the alias
(`path_alias.manager`). A match means the module is *inactive* on that page.

## How the JS picks links (`js/external.js`)

`Drupal.behaviors.external.attach()` binds `window.open(this.href); return false;` to:

1. Every `a[href*=.pdf]` — only when `settings.external.externalpdf` is on.
2. Every `a.newtab` link (opt a single link into new-tab behaviour by adding `class="newtab"`).
3. Every `a[href^=http://]` / `a[href^=https://]` whose href does not appear to belong to the current
   host (a string-index check against `location.hostname`).

Each processed anchor gets the `external-processed` class so re-running behaviours (AJAX, dynamically
inserted content) does not double-bind the handler. The library depends on `core/jquery`,
`core/drupal`, `core/drupalSettings`.

## Operating notes

- The module never modifies the DOM's anchor attributes and issues no server-side HTTP request; all
  navigation is performed by the visitor's browser.
- To limit the behaviour to hand-picked links, leave `external_enabled` on and rely on `a.newtab`, or
  use `external_disabled_patterns` to carve out sections.
- The library is attached on every non-excluded page, so keep the exclude list current for admin/edit
  routes (the defaults already cover `admin*`, `node/add/*`, `node/*/edit`).
