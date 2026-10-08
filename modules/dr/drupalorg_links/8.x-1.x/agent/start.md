<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drupal.org Links (drupalorg_links) — agent index

Three field **formatters** that render a numeric field value as a link to a drupal.org page
(`/user/N`, `/node/N`, `/comment/N`). Package `fields`. **No dependencies** beyond Drupal core,
no permissions, no routes, no services, no config schema, no submodules. Core requirement
`^8 || ^9 || ^10 || ^11`. License GPL-2.0-or-later. Installed version 8.x-1.2 (version dir 8.x-1.x).

- **The three formatters, the field types they apply to, the URL each builds, and how to enable
  one on a field display** → [fields/formatters.md](fields/formatters.md)

## What it actually is

Three `@FieldFormatter` plugins in `src/Plugin/Field/FieldFormatter/`, each extending core
`FormatterBase` and implementing `ContainerFactoryPluginInterface`:

| Class | Plugin id | Label | URL built | Applies to |
|---|---|---|---|---|
| `DrupalUidLink` | `drupal_uid_link` | Drupal.org user link | `https://www.drupal.org/user/N` | integer, decimal, string |
| `DrupalNidLink` | `drupal_nid_link` | Drupal.org node link | `https://www.drupal.org/node/N` | integer, decimal, string |
| `DrupalCidLink` | `drupal_cid_link` | Drupal.org comment link | `https://www.drupal.org/comment/N` | integer, decimal, string |

- Each `viewElements()` loops the field items, casts `$item->value` with `intval()`, skips empty /
  zero values, and emits a `#type => 'link'` render element with title `#N` and
  `#url => Url::fromUri('https://www.drupal.org/<path>/' . N)`.
- No `defaultSettings()`, no `settingsForm()`, no `settingsSummary()` — the formatters have **no
  configuration options**. Selected per view-display on *Manage display*.
- Each class injects `link_generator` in its constructor/`create()`, but the current code path uses
  the `#type => 'link'` render element and does not call the injected service.

## Install / operate

- `composer require drupal/drupalorg_links` then `drush en drupalorg_links -y`. Nothing to
  configure afterward; assign a formatter to a field on *Manage display* (see the solution doc).
