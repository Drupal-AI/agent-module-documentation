<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prism (prism) — agent index

Integrates the **Prism.js** syntax highlighter with Drupal. Version **2.2.3** (`2.2.x`).
Core: `^9 || ^10 || ^11`. License GPL-2.0-or-later. Package: Other. No composer/module dependencies.

## What it actually provides

Two independent mechanisms, plus a settings form:

1. **Text-format filter** — `prism_filter`, "Highlight code using prism.js"
   (`src/Plugin/Filter/PrismFilter.php`, `TYPE_TRANSFORM_REVERSIBLE`).
   - Rewrites `[prism:LANGUAGE]...[/prism:LANGUAGE]` blocks into
     `<div class="prism-wrapper" rel="LANGUAGE"><pre><code class="language-LANGUAGE">…escaped…</code></pre></div>`.
     The code **content** is passed through `Html::escape()`.
   - Also attaches the Prism library whenever the text already contains a `<code` tag (e.g. a
     Markdown filter's ```` ``` ```` fences rendered to `<pre><code class="language-*">`). Run the
     Markdown/code-producing filter **before** this one.
   - Filter setting `always_include_prism_library` (bool, default FALSE): attach assets on every
     rendered page even with no code block, so raw `<pre><code class="language-*">` HTML highlights.

2. **Code field** — field type `text_long_prism` (`src/Plugin/Field/FieldType/TextPrismItem.php`,
   extends core `TextItemBase`) with:
   - Widget `text_prism` (`…/FieldWidget/TextPrismWidget.php`) — a textarea (`rows`, `placeholder`
     settings) plus a language `<select>` whose options come from the site settings (below).
   - Formatter `prism_default` (`…/FieldFormatter/TextPrismFormatter.php`) — wraps the stored value
     in `<pre><code class="language-*">` (value escaped via `Html::escape()` + `nl2br`) and attaches
     the library.
   - Stores two columns: `value` (big text/blob) and `languages` (varchar 255).

3. **Settings form** — `/admin/config/content/prism/settings`
   (`src/Form/PrismConfigForm.php`, route `prism.prism_config_form`). A checkboxes list of the ~110
   Prism languages (defined in `src/PrismConfig.php`) saved to `prism.settings:languages`; this set
   filters which languages the field widget's select offers. **Route is gated by the core
   `access administration pages` permission** — NOT by the module's own
   `administer prism languages` permission, which is declared in `prism.permissions.yml` but never
   referenced by any route (dead permission).

## The library is NOT bundled

`prism.js` + `prism.css` must be downloaded from <https://prismjs.com/download.html> and placed at
`/libraries/prism/prism.js` and `/libraries/prism/prism.css`. `hook_requirements`
(`prism.install`) reports "Not installed" until both exist. Libraries
(`prism.libraries.yml`): `prism/prism` = the two local `/libraries/prism/*` files;
`prism/drupal.prism` = the module's own `js/prism.js` + `css/prism.wrapper.css`, depends on
`prism/prism` and `core/drupal`. **Assets are always local — no CDN path exists.** The module's
`js/prism.js` re-runs `Prism.highlightAll()` on Drupal behaviour attach (AJAX re-highlighting).

## Files

- `prism.module` — `hook_help`; `hook_field_info_alter` (legacy category shim for core < 10.2).
- `src/PrismConfig.php` — static `getLanguages()` map (machine name → label) of all supported languages.
- `config/install/prism.settings.yml` — default enabled languages (markup, css, clike, javascript).
- `config/schema/prism.schema.yml` — `prism.settings` + `filter_settings.prism_filter` schema.
- `prism.field_type_categories.yml`, `prism.links.menu.yml` — field-category + admin menu link.

## Notes for agents

- To highlight Markdown code: enable Markdown filter, then Prism filter, in that filter order.
- `[prism:X]` tags only render a wrapper when a matching `[/prism:X]` close tag is present.
- The `<code>`-detection path highlights any existing `<code class="language-*">`; a bare `<code>`
  with no `language-*` class will not be highlighted by Prism.
- No submodules, no Drush commands, no services, no new plugin *types*.

Solution-type detail: see `filters/` and `fields/`.
