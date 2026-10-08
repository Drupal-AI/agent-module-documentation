<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Shortcode (shortcode) — agent index

Text-format **filter framework + plugin API** for WordPress-style `[tag attr="value"]...[/tag]`
macros. The base module ships **no tags**; it provides the filter, the `shortcode` plugin type,
and a parser/expander service. Package `Input filters`. Depends only on core **`filter`**. Core
`^11.1 || ^12`, PHP 8.3+. License GPL-2.0-or-later. Version 3.0.0.

- **Enabling the filter on a text format + the HTML corrector + config schema** →
  [config/settings.md](config/settings.md)
- **Services: ShortcodeService, ShortcodePluginManager, MediaUrlResolver** →
  [api/service.md](api/service.md)
- **Writing a shortcode plugin (attribute/annotation, ShortcodeBase, the trait)** →
  [plugins/shortcode-plugin.md](plugins/shortcode-plugin.md)

Submodules (own doc trees):
- **Shortcode Basic Tags** (`shortcode_basic_tags`) — bundled starter tags →
  [../../modules/shortcode_basic_tags/3.0.x/agent/start.md](../../modules/shortcode_basic_tags/3.0.x/agent/start.md)
- **Shortcode Example** (`shortcode_example`) — reference `[col]` plugin →
  [../../modules/shortcode_example/3.0.x/agent/start.md](../../modules/shortcode_example/3.0.x/agent/start.md)

## What it actually is

- Two **Filter plugins** (`src/Plugin/Filter/`):
  - `Shortcode` (id **`shortcode`**, *"Shortcodes"*) — parses text and expands tags. Injects
    `ShortcodeService` + `ShortcodePluginManager`. `settingsForm()` renders a per-format
    enable checkbox for every registered tag, grouped by provider module.
  - `ShortcodeCorrector` (id **`shortcode_corrector`**, *"Shortcodes - HTML corrector"*) —
    strips WYSIWYG-added `<p>`/`<br>` around brackets via `ShortcodeService::postprocessText()`.
    Enable **before** `shortcode` on WYSIWYG formats only.
- A **plugin type** `shortcode` (`ShortcodePluginManager`, dir `Plugin/Shortcode`, service
  **`plugin.manager.shortcode`**). Discovers `#[Shortcode]` attributes **and** `@Shortcode`
  annotations; alter hook **`hook_shortcode_info_alter`**; cache key `shortcode_info_plugins`.
- **`ShortcodeService`** (service **`shortcode`**) — the parser/expander. See api/service.md.
- **`MediaUrlResolver`** (service **`shortcode.media_url_resolver`**, interface
  `MediaUrlResolverInterface`) — media/file/image-style URL lookups for plugins (new in 3.0.x).
- **`ShortcodeBase`** (`src/Plugin/ShortcodeBase.php`) — abstract base for tag plugins;
  `ShortcodeInterface` is the contract. `MediaUrlResolverTrait` adds path→URL helpers.
- No entities, **no permissions**, no routes of its own, no Drush. Config **schema only**
  (`filter_settings.shortcode`, a `sequence` of booleans — the per-format enabled-tag map).
- OOP hook: `src/Hook/ShortcodeHooks.php` implements `hook_migration_plugins_alter` to map the
  D7 `shortcode_text_corrector` filter id to `shortcode_corrector`.

## Parsing model (from `ShortcodeService`)

- `process()` splits text on `preg_split('!(\[{1,2}.*?\]{1,2})!', ...)`, then walks chunks onto a
  heap: opening tags pushed, closing tags pop-and-render the matching span, self-closing (`[x /]`)
  render immediately. `[[tag]]` double brackets = escaped → rendered literally.
- Only tokens of tags **enabled on the active filter** are expanded; unknown/disabled tags are
  returned verbatim (tokens stripped). Tag matching is by lowercase **token** (defaults to plugin id).
- Attributes parsed by `parseAttrs()` (quoted, unquoted, and positional forms). A plugin's
  `process($attributes, $text, $langcode)` returns the replacement string; the filter returns a
  `FilterProcessResult` with no further escaping, so **plugins own their output escaping**.

## 3.0.0 highlights (see CHANGELOG.md / UPGRADING.md)

- `#[Shortcode(...)]` / `#[Filter(...)]` attribute discovery added; annotations still work.
- `ShortcodeBase::__construct()` no longer takes a `FileUrlGeneratorInterface`; media helpers
  (`getMediaFileUrl`, `getImageProperties`, `getUrlFromPath`, `getMidFromPath`) moved to
  `MediaUrlResolver` / `MediaUrlResolverTrait`. Autowiring replaces hand-written `create()`.
- `strict_types`, full type hints, `#[\Override]`, instance-property caching (was `drupal_static`).
