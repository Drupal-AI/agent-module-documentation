<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring async/defer and how the aggregation works

## Install & enable

```bash
drush en agg_jscss_asyncdefer -y
drush cr   # required: the ServiceProvider swap only takes effect after a container rebuild
```

No module dependencies, no composer requirements, no permissions of its own. The module ships **no
default config**; until you save the form, `js_all`/`css_all` are absent (treated as `none`) and no
library is altered.

## The settings form

- Route **`agg_jscss_asyncdefer.settings`** →
  `/admin/config/development/performance/agg-jscss-asyncdefer`, permission **`administer site
  configuration`**. Menu link + local task both point here (parent/base
  `system.performance_settings`).
- Form class `Drupal\agg_jscss_asyncdefer\Form\SettingsForm` (`ConfigFormBase`). It uses
  `library.discovery`, `module_handler` and `theme_handler` to enumerate **every** library of core,
  each enabled module, the default theme, and (if any) its base theme, rendering a **None / Async /
  Defer** radio per library, plus two top-level **Force all JS** / **Force all CSS** radios.
- `submitForm()` keeps only libraries set to `async` or `defer` and stores them grouped by
  attribute; radios left on `none` are dropped. Library names round-trip through a `.`↔`_lib_`
  substitution so they survive as form-element keys.

## Config object `agg_jscss_asyncdefer.settings`

Schema: `config/schema/agg_jscss_asyncdefer.settings.schema.yml`.

| Key | Type | Meaning |
|---|---|---|
| `js_all` | string `none\|async\|defer` | Force this attribute on **every** JS asset. |
| `css_all` | string `none\|async\|defer` | Force this attribute on **every** CSS asset. |
| `libraries` | `{async: [...], defer: [...]}` | Per-library opt-in by full `extension/library` name. |

Example:

```yaml
# agg_jscss_asyncdefer.settings
js_all: none
css_all: none
libraries:
  defer:
    - 'core/drupal.ajax'
    - 'my_module/widget'
  async:
    - 'google_analytics/google_analytics'
```

## How attributes are injected (`AssetResolverAggJscssAsyncdefer`)

`getCssAssets()` / `getJsAssets()` override core `AssetResolver`. For each asset of each library to
load:

- If `css_all`/`js_all` is not `none`, `$options['attributes'][$*_all] = TRUE` is set on every
  asset.
- If the library is listed under `libraries['async']` **and** the global force is not `defer`,
  `attributes['async'] = TRUE`; likewise `defer` unless the global force is `async`. So a global
  force wins over its opposite per-library choice.
- `preprocess` (aggregation eligibility) is left on **only** when the asset's attribute set is empty
  or contains **only** `async`/`defer`; any other attribute forces `preprocess = FALSE` (that asset
  drops out of aggregation). JS additionally keeps its original `cache` flag as a precondition.

## Per-attribute aggregates (`Js/CssCollectionGrouperAggJscssAsyncdefer`)

`group()` extends core's grouper: when a file asset carries attributes, it appends `async`/`defer`
to the aggregation **group key** (and refuses to group any asset carrying a non-async/defer
attribute). Because the group key now differs by attribute, core's collection optimizer builds a
**separate combined file per attribute** — one deferred bundle, one async bundle — rather than one
mixed aggregate. This is the "different compressed files based on the attribute" behavior.

## Operating it safely

- **`async` reorders execution.** A script that depends on another not-yet-run script fails
  **intermittently** — it hinges on network timing and will not reproduce on a fast/local
  connection. `defer` preserves document order and is the safe default; reserve `async` for
  genuinely independent scripts (e.g. analytics).
- Core's own JS has dependencies (`drupalSettings`, `once`, behaviours on `DOMContentLoaded`), so
  forcing an attribute across **all** libraries is the usual source of breakage. Prefer per-library
  selection; measure and test on a throttled connection.
- `defer`/`async` on stylesheet `<link>` elements is non-standard for CSS — treat `css_all` and CSS
  per-library choices as experimental and verify rendering.
- After changing the config, clear caches (`drush cr`) so the asset caches rebuild.
