<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inspire Tree (inspire_tree) — agent index

**What it is.** A pure asset-library provider. It registers the [Inspire Tree](https://github.com/helion3/inspire-tree)
client-side tree/hierarchy UI (lazy nodes, in-tree search, multi-select with parent/child
propagation, file-browser expand/collapse) as Drupal asset libraries so other code can attach it.
It ships **no** field, widget, render element, form element, or plugin type — it does nothing on
its own. Version **1.0.6**, core `^8.8 || ^9 || ^10 || ^11`. Package `Other`. No composer
dependencies; no drush commands; no permissions of its own.

## What it actually provides

Three asset libraries (see `inspire_tree.libraries.yml`):

| Library | Wraps | Version | Depends on |
|---|---|---|---|
| `inspire_tree/inspire_tree` | inspire-tree (helion3) | 6.0.1 | `core/underscore`, `inspire_tree/lodash` |
| `inspire_tree/inspire_tree_dom` | inspire-tree-dom (DOM renderer) | 4.0.6 | `core/underscore`, `inspire_tree/lodash`, `inspire_tree/inspire_tree` |
| `inspire_tree/lodash` | lodash | 4.17.21 (url pins 4.17.20) | — |

Attach them yourself, e.g.:

```php
$build['#attached']['library'][] = 'inspire_tree/inspire_tree_dom';
```

## CDN vs. local (the one interesting mechanism)

By default all three JS files load from the **jsDelivr CDN** (`//cdn.jsdelivr.net/gh/helion3/...`,
`//cdn.jsdelivr.net/npm/lodash@...`), declared `{ type: external }`. `inspire_tree.module`'s
`hook_library_info_alter()` swaps each library to a **local** file when the matching filename
(`inspire-tree.min.js`, `inspire-tree-dom.min.js`, `lodash.min.js`) is found in a `libraries/`
directory via the `library.libraries_directory_file_finder` service. Drop local copies in to
self-host. See <https://www.drupal.org/node/3099614>.

## Config

- Route `inspire_tree.settings` → `/admin/config/services/system/inspire-tree`, permission
  `administer site configuration` (`src/Form/InspireTreeSettingsForm.php`).
- One setting: **Mode** = `none` (default) | `light` | `dark`. When not `none`, the alter hook
  attaches `inspire-tree-<mode>.css` to the DOM library (local if present, else from the CDN).
- Config object `inspire_tree.settings` (schema in `config/schema/inspire_tree.schema.yml`;
  install default `mode: none`).
- Menu link `inspire_tree.delete_orphans` (title "Inspire tree") under
  `system.admin_config_system` — note the machine name is a misnomer; it just links to the
  settings form.

## Site-wide reach — flag before installing

`inspire_tree.info.yml` contains:

```yaml
libraries-override:
  core/underscore: inspire_tree/lodash
```

Installing this module **replaces core's Underscore with Lodash for the entire site**, not only on
pages using the tree. Lodash and Underscore are broadly API-compatible and this is a common
substitution, but it is a global change from a module whose stated purpose is a tree widget. Verify
it against any custom JavaScript that depends on `core/underscore` before enabling.

## Files

- `inspire_tree.libraries.yml` — the three library definitions (CDN URLs, versions, MIT licenses).
- `inspire_tree.module` — `hook_library_info_alter()`: local-file fallback + light/dark CSS.
- `inspire_tree.info.yml` — the `libraries-override` of `core/underscore`.
- `inspire_tree.routing.yml`, `inspire_tree.links.menu.yml`, `src/Form/InspireTreeSettingsForm.php`
  — the admin settings form.
- `config/install/inspire_tree.settings.yml`, `config/schema/inspire_tree.schema.yml` — config.
- No `composer.json`, no `README`, no `.install`.

See `../usage.md` for use cases. There is no elements/ or api/ subdir because the module exposes no
render/form element or PHP API — only the asset libraries above.
