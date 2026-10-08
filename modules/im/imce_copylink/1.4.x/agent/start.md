<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# IMCE Copy Link (imce_copylink) — agent index

Adds a **Copy Link** toolbar button to the [IMCE](https://www.drupal.org/project/imce) file
manager. Clicking it copies the URL of the selected file (or, when nothing is selected, the current
folder) to the clipboard. The whole feature is one IMCE plugin: the PHP side
(`src/Plugin/ImcePlugin/Copylink.php`) does nothing but register an IMCE permission (`copylink`) and,
when the browsing user holds that permission, attach a JS library; all behaviour lives in
`imce_copylink.js`, which adds the toolbar button (`imce.addTbb`) and copies `item.getUrl()` — the URL
IMCE core already computed for the item — into the clipboard via a hidden input and
`document.execCommand('copy')`. There is no server-side path handling of its own.

The module builds no URLs itself and touches no file paths server-side: it copies whatever URL IMCE
assigned to the item, which for a **private://** file is IMCE's own access-controlled download URL, so
copying a link never bypasses file access. Note the button relies on the browser Clipboard API, which
requires a **secure context** — over plain HTTP the copy can fail silently (browser policy, not a
module bug).

- Depends on: `imce:imce` (only). No optional/soft dependencies.
- Core: `^8 || ^9 || ^10 || ^11`. Package: `Media`.
- **No settings page / `configure` route**, no Drupal routes, services, config schema, hooks, drush, or
  fields. No `*.permissions.yml` — the one permission (`copylink`) is an **IMCE profile permission**,
  set per-directory on an IMCE profile, not a Drupal role permission.
- Defines **no** plugin type; it *implements* IMCE core's `ImcePlugin` type.

## What you'd do → where

- **Understand/extend the IMCE plugin, the `copylink` permission, the JS toolbar button, and the icon** →
  [plugins/copylink.md](plugins/copylink.md)
- **Turn the button on for editors** → enable the module, then on each IMCE profile
  (`/admin/config/media/imce`, *Configuration profiles* → *Edit* → *Directories*) tick the **Copy link**
  checkbox for the directories that should allow it.

## Key facts (real machine names)

- IMCE plugin: id **`copylink`**, label `Copy Link`, class
  `Drupal\imce_copylink\Plugin\ImcePlugin\CopyLink` (annotation `@ImcePlugin`), extends
  `Drupal\imce\ImcePluginBase`. Implements `permissionInfo()` (returns `['copylink' => 'Copy link']`)
  and `buildPage()` (attaches the library iff `$fm->hasPermission('copylink')`).
- IMCE permission id: **`copylink`** (IMCE profile per-directory permission; checked in PHP via
  `ImceFM::hasPermission('copylink')` and in JS via `imce.hasPermission('copylink')` +
  `imce.validatePermissions([item], 'copylink', 'copylink')`).
- Library: **`imce_copylink/drupal.imce.copylink`** (`imce_copylink.libraries.yml`) → `imce_copylink.js`,
  `imce_copylink.css`; dependency `imce/drupal.imce`.
- JS toolbar button: `imce.addTbb('copylink', {title, permission:'copylink', shortcut:'Ctrl+Alt+C',
  icon:'copylink', handler})`; init hook `imce.bind('init', imce.copylinkInit)`.
- Icon: CSS class `.imce-ficon-copylink` → `imce_copylink.svg`.
- Plugin type it plugs into (owned by imce core): discovery dir `Plugin/ImcePlugin`, manager
  `Drupal\imce\ImcePluginManager`, interface `ImcePluginInterface`, base `ImcePluginBase`, annotation
  `Drupal\imce\Annotation\ImcePlugin`, alter hook `imce_plugin_info`.
