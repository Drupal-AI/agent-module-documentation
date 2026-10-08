<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Title HTML Element (block_title_html_element) — agent index

Adds a per-block **third-party setting** letting an admin choose the HTML element that wraps a
block's title (e.g. `h2`–`h6`, `span`, `p`, `em`, `b`, `i`). The chosen tag is exposed to the
block template as a `title_element` Twig variable; the theme's `block.html.twig` renders the
title inside `<{{ title_element }}>`. No selection defaults to `strong`. Package `Other`.
Depends only on core **`block`**. Core requirement `^9 || ^10 || ^11`, PHP `>=8.1`.
License GPL-2.0-or-later. Version 1.0.0-beta1 (version-dir 1.0.x).

- **Enable, permission, the allowed-element list, the block-form setting, the required Twig
  change, and the alter hook** → [config/block-title-element.md](config/block-title-element.md)

## What it actually is (from source)

- **One service** `block_title_html_element.validator` → `ElementValidator`
  (`src/Service/ElementValidator.php`), constructed with `@module_handler`.
  - `getAllowedElements(): array` returns the fixed allowlist keyed by tag →
    `h2, h3, h4, h5, h6, span, p, em, b, i`, then runs
    `hook_block_title_html_element_allowed_elements_alter($elements)` so other modules can extend
    it. Note: `h1` is intentionally excluded.
  - `validateElement(string): bool` → `in_array($element, array_keys(getAllowedElements()), TRUE)`
    (strict allowlist check).
- **No routes, no config forms, no plugins, no entities, no Drush.** All UI is grafted onto the
  core block form.
- **One permission** `administer block title element` (`*.permissions.yml`) — gates whether the
  extra form section appears.
- **Config schema** `block.block.*.third_party.block_title_html_element` with one key
  `title_element` (string, `Length max: 10`) — stored as a block third-party setting, not a
  standalone config object.

## Hooks (in `block_title_html_element.module`)

- `hook_help` — help page text.
- `hook_form_block_form_alter` — if the current user has `administer block title element`, adds a
  `details` group `third_party_settings[block_title_html_element]` with a **`select`**
  `title_element` (options = `'' => - Default (strong) -` plus the allowlist) and registers a
  `#validate` handler that rejects any value failing `validateElement()`.
- `hook_ENTITY_TYPE_presave` (`_block_presave`) — empties the setting when blank; if a non-empty
  value fails validation it is unset (falls back to default) and a warning is shown.
- `hook_preprocess_block` — loads the block, reads the `title_element` third-party setting, and
  sets `$variables['title_element']` to it **only if it passes `validateElement()`**, otherwise
  to `strong`. Blocks with no id (e.g. page-manager widgets) also get `strong`.

## Helper functions

`block_title_html_element_get_validator()`, `_get_allowed_elements()`,
`_validate_element($element)` — thin wrappers over the service.

## Operating it

1. `drush en block_title_html_element -y`, grant the permission.
2. Copy `examples/block.html.twig` into your theme and clear cache (the module only supplies the
   variable — the theme must actually use `<{{ title_element | default('strong') }}>`).
3. Configure a block at *Structure → Block layout → Configure* and pick the element.
