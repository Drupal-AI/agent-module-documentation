<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Hook classes

Both are OOP hook implementations using core's `#[Hook]` attribute (no `.module` file;
`drulma_companion.services.yml` sets `drulma_companion.hooks_converted: true`). They are
auto-discovered services.

## AddFontawesomeFiveSuggestions — `hook_theme_suggestions_alter`

`src/Hook/AddFontawesomeFiveSuggestions.php`. Injects `library.discovery` and `module_handler`.
Adds `__fa5` template suggestions so a Drulma (sub)theme can override input/button/icon markup when
Font Awesome 5 is present.

`addSuggestions()` only acts when the base hook is one of `feed_icon`, `input`, `select`,
`file_link` **and** `isFontawesomeFiveEnabled()` returns TRUE. It then appends
`<suggestion>__fa5` for every existing suggestion, plus `<hook>__fa5`, and — from
`$variables['element']` — more specific suggestions: by element `#type` (and an input's real
`#attributes[type]` subtype, e.g. `input__date_time__fa5`), by cleaned `#attributes[name]`, by
`<type>__<form_id>`, by a submit button's untranslated `#value` string, and by a file's MIME icon
class (`IconMimeTypes::getIconClass()`). Names/values are cleaned with `preg_replace('~[\W]~', '')`.

`isFontawesomeFiveEnabled()`: requires module `lp_fontawesome` to be installed, then checks its
`fontawesome` / `fontawesomesvg` libraries for an enabled libraries-provider at version ≥ 5.0.0.
Const `TEMPLATE_SUFFIX = '__fa5'`.

## AddContainerClass — `hook_themes_installed`

`src/Hook/AddContainerClass.php`. Injects `entity_type.manager` and `theme_handler`. When a theme
is installed that **is** `drulma` or has `drulma` among its base themes, it loops the block IDs
`<theme>_branding`, `<theme>_footer`, `<theme>_powered`, `<theme>_messages`. For each existing
block that has **no** `third_party_settings` yet, it sets
`third_party_settings.block_class.classes = 'container'` and adds `block_class` to the block's
module dependencies, then saves. This is why the module depends on **Block Class** — it uses that
module's third-party-settings mechanism to drop a Bulma `container` class onto Drulma's core blocks.
Blocks that already have third-party settings are left untouched.
