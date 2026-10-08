<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Blocks & per-node page-layout fields

## Block: `full_screen_search` (DXPR Theme Full Screen Search)

`@Block(id = "full_screen_search", admin_label = "DXPR Theme Full Screen Search", category = "Forms")`.
A toggle button that opens a full-screen search overlay.

Config keys (`defaultConfiguration()`):

| Key | Default | Meaning |
|---|---|---|
| `search_provider` | `core` | `core` (Core Search block form) or `search_api` (Search API Block form). |
| `search_url` | `/search` | Path of the search results page/view. |
| `search_parameter` | `search_api_fulltext` | Query parameter name the results page expects (e.g. `keys`, `search_api_fulltext`). |

- The `search_api` option only works when `search_api_block` is enabled; otherwise it is
  disabled in the form and the block falls back to Core Search at build time.
- If neither `search` nor `search_api_block` is available, `build()` shows an error and renders
  nothing.
- Config schema: `block.settings.full_screen_search` (`search_provider`, `search_url`,
  `search_parameter`, all strings).

Place it (scriptable):

```php
use Drupal\block\Entity\Block;
Block::create([
  'id' => 'mysite_fss', 'theme' => 'olivero', 'region' => 'content',
  'plugin' => 'full_screen_search',
  'settings' => [
    'id' => 'full_screen_search', 'label' => 'Search', 'label_display' => '0',
    'search_provider' => 'search_api', 'search_url' => '/search',
    'search_parameter' => 'search_api_fulltext',
  ],
])->save();
```

Read back: `drush cget block.block.mysite_fss settings`.

## Block: `dxpr_theme_helper_user_register` (User registration form)

`@Block(id = "dxpr_theme_helper_user_register", admin_label = "User registration form", category = "Forms")`.
Renders the user register form. `blockAccess()` allows it only for **anonymous** users and only
when `user.settings` `register` is not "administrators only". No settings of its own.

## Per-node page-layout fields (optional config)

The module ships these as **optional** `field.storage.node.*` config (installed only when
dependencies are met). They are **not attached to any bundle by default** — attach them to the
content types you want via *Manage fields* or `FieldConfig::create()`:

| Field | Type | Purpose / values |
|---|---|---|
| `field_dth_page_layout` | list_string | `fullwidth` or `boxed`. |
| `field_dth_main_content_width` | list_string | content column width (full, 1/3, 1/2, 2/3, 5/6). |
| `field_dth_hide_regions` | list_string (multi) | regions to hide (navigation, header, footer, sidebars, …). |
| `field_dth_body_background` | entity_reference → media (image) | per-node body background image. |
| `field_dth_page_title_backgrou` | entity_reference → media (image) | per-node page-title background image. |

Attach one to Article:

```php
use Drupal\field\Entity\FieldConfig;
FieldConfig::create([
  'field_name' => 'field_dth_page_layout', 'entity_type' => 'node',
  'bundle' => 'article', 'label' => 'Page layout',
])->save();
```

(The `field.storage.node.field_dth_page_layout` storage already exists; you only add the
per-bundle `FieldConfig`.) Set values on a node via `dxt:page:set` — see
[../drush/dxt-commands.md](../drush/dxt-commands.md).
