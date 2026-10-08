<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Alpha Numeric Glossary (alpha_numeric_glossary) — agent index

A **Views-only** module that renders an **A-Z / 0-9 glossary** (letter/number links) in a View's
**global header or footer area**. Each character links to a listing scoped to that first letter;
empty characters render as inactive `<span>`s. Package `Views`. Depends only on core **`views`**.
Core `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.0.5.

No routes, no permissions, no config entities, no admin settings form — everything is configured
in the Views handler's own options form. It does **not** filter results itself; a standard Views
**contextual filter in Glossary mode** (char limit 1) does the filtering, and this handler renders
the navigation + marks which characters have content.

## What it provides (from source)

- **Views area plugin** `AlphaNumericGlossaryArea` — id **`alpha_numeric_glossary`**, label
  *"Global: Alpha Numeric Glossary"* (`@ViewsArea`), in
  `src/Plugin/views/area/AlphaNumericGlossaryArea.php`. Holds all `defineOptions()` (30+ `glossary_*`
  keys) and `buildOptionsForm()`; `render()` builds the item list.
- **Views field plugin** `AlphaNumericGlossaryGroup` — id **`alpha_numeric_glossary_group`**
  (`@ViewsField`), in `src/Plugin/views/field/AlphaNumericGlossaryGroup.php`. Prints a row's
  first-character group value (for Views grouping); `query()` is a no-op.
- **Service** `alpha_numeric_glossary` → class `Drupal\alpha_numeric_glossary\AlphaNumericGlossary`
  (`*.services.yml`). The engine: builds characters, resolves the URL/link, and runs the
  prefix/count queries. Helper value object `AlphaNumericGlossaryCharacter` per character.
- **Views data** (`alpha_numeric_glossary.views.inc`): registers both handlers under the special
  `views` global table so they appear on every View.
- **Hooks** in `alpha_numeric_glossary.module`: `hook_help`, `hook_entity_presave` (cache
  invalidation), `hook_token_info` + `hook_tokens` (the `alpha_numeric_glossary:path` / `:value`
  tokens used to build link paths).
- **Alter hooks** (`alpha_numeric_glossary.api.php`): `hook_alpha_numeric_glossary_alphabet_alter`,
  `hook_alpha_numeric_glossary_numbers_alter`.
- **Asset**: CSS-only library `alpha_numeric_glossary/alpha_numeric_glossary` (attached by
  `render()`); ships English/Arabic/Russian alphabets.

## Solution docs

- **Place & configure the glossary area, every `glossary_*` option, how the A-Z filtering is wired,
  case/link/numeric/"All"/count settings** → [plugins/views-glossary-area.md](plugins/views-glossary-area.md)
- **The `alpha_numeric_glossary` service, the group field, tokens, alter hooks, cache invalidation,
  and the internals (`getCharacters`, `getEntityPrefixes`, `getUrl`)** →
  [api/service-and-hooks.md](api/service-and-hooks.md)
