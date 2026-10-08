<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Dynamic Placeholder — configuration & operation

## Install / enable
`drush en dynamic_placeholder` (or Extend UI). No dependencies beyond core. After enabling, configure at `/admin/config/user-interface/dynamic-placeholder` (link appears under Configuration → User Interface). The effect is OFF until you check "Enable" and provide a selector + items.

## Config object: `dynamic_placeholder.settings`
Simple site-wide config. There is **no `config/install` default file and no `config/schema/*.schema.yml`** — every key is created/written only by the settings form, and code reads them with inline defaults. Keys (as written in `DynamicPlaceholderSettingsForm::submitForm()` and read in `dynamic_placeholder_page_attachments()`):

| Key | Type | Default (code) | Meaning |
|-----|------|----------------|---------|
| `enabled` | bool | FALSE | Master on/off. When false the hook returns early and nothing is attached. |
| `target_selector` | string | '' | CSS selector for the input(s) to enhance (trimmed on save). |
| `placeholder_prefix` | string | 'Search' | Text prepended to each item; stored raw (trailing spaces preserved on purpose). |
| `placeholder_items` | string | '' | Newline-separated list; one placeholder per line (trimmed on save). |
| `rotation_interval` | int | 2000 | Milliseconds between changes (cast to int on save). |
| `randomize_order` | bool | FALSE | Random vs. sequential cycling. |
| `pause_on_focus` | bool | FALSE | Pause rotation while the input is focused. |
| `fade_effect` | string | 'none' | One of `none`, `fade`, `fade-fast`, `fade-slow`, `slide`. |

## Settings form: `DynamicPlaceholderSettingsForm`
`src/Form/DynamicPlaceholderSettingsForm.php`, extends `ConfigFormBase`; `getFormId()` = `dynamic_placeholder_settings_form`; `getEditableConfigNames()` = `['dynamic_placeholder.settings']`.

- Fields map 1:1 to the config keys above (`checkbox`, `textfield`, `textarea`, `number`, `select`).
- `target_selector` and `placeholder_items` are marked `#required` only via `#states` when `enabled` is checked; server-side `validateForm()` enforces both are non-empty when `enabled`.
- `rotation_interval` is a `number` element with `#min 500`, `#max 60000`, `#step 100`; `validateForm()` also rejects values `< 500`.
- `placeholder_prefix` uses a custom `#element_validate` callback `validatePrefix()` that re-sets the raw value so **trailing spaces are not trimmed** (so "Search " keeps its space). `submitForm()` likewise stores the prefix untrimmed (NULL coerced to '').
- `fade_effect` is a required `select`; `#options` are the five values listed above.

## Runtime: `dynamic_placeholder_page_attachments()`
In `dynamic_placeholder.module`. On every response it:
1. Loads `dynamic_placeholder.settings`; returns immediately if `enabled` is falsy.
2. Reads all keys, parses `placeholder_items` into an array via `array_filter(array_map('trim', explode("\n", $items)))`.
3. Returns without attaching if the item array or `target_selector` is empty.
4. Attaches library `dynamic_placeholder/dynamic_placeholder` and sets `drupalSettings.dynamicPlaceholder` = `{selector, prefix, items, interval:(int), randomize:(bool), pauseOnFocus:(bool), fadeEffect}`.
5. Adds cache tag `config:dynamic_placeholder.settings` so pages re-render when the config changes.

Because settings are global page attachments, the effect applies on any page where a matching input exists (including admin pages) once enabled.

## Client behavior: `js/dynamic-placeholder.js`
`Drupal.behaviors.dynamicPlaceholder.attach()`:
- Bails if `settings.dynamicPlaceholder`, `items`, or `selector` is missing.
- Re-adds a trailing space to a non-empty prefix if one was stripped.
- Selects inputs with `once('dynamic-placeholder', selector, context)` (idempotent).
- If `randomize`, shuffles the items once with Fisher–Yates; in the interval it also picks a random index each tick.
- Per input, `setInterval(updatePlaceholder, interval)` assigns `input.placeholder = prefix + currentItem`. Assignment is to the DOM `placeholder` property (plain text, not parsed as HTML).
- Skips updates while `input.value` is non-empty (user typing) or while paused.
- With a fade effect, toggles `dynamic-placeholder-<effect>` / `-out` classes (opacity/transform transitions defined in `css/dynamic-placeholder.css`) around the text swap.
- Listens for `focus` (pause if `pauseOnFocus`), `blur` (resume if empty), and `input` (resume when cleared).

## Library: `dynamic_placeholder.libraries.yml`
`dynamic_placeholder` → `js/dynamic-placeholder.js`, `css/dynamic-placeholder.css`; dependencies `core/drupal`, `core/drupalSettings`, `core/once`. No external/CDN libraries.

## Targeting an input (selector cheatsheet)
- Core search block: `#edit-keys` or `input[name="keys"]`.
- Search API fulltext: `input[name="search_api_fulltext"]`.
- Views exposed filter: `.views-exposed-form input[type="search"]`.
- Any custom input: ID (`#my-search`), class (`.header-search input`), or attribute selector.
Verify in the browser console with `document.querySelector('YOUR_SELECTOR')`, then `drush cr` after saving config.

## Operating notes
- Turning off is a single "Enable" uncheck; the item list is retained in config.
- No permissions of its own — access to the form is the core `administer site configuration` permission.
- Export/import `dynamic_placeholder.settings` via configuration management to move settings between environments.
