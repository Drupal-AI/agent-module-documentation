<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Advanced Shortcodes (advanced_shortcodes) — agent index

Adds nine **Bootstrap-style shortcode plugins** to the Shortcode module's text-format filter.
Editors write `[tag]...[/tag]` codes that expand to Bootstrap markup at render time.

- **Version dir:** 2.0.x (project release 2.0.4)
- **Core:** `^9 || ^10 || ^11`  ·  **License:** GPL-2.0-or-later  ·  **Package:** Input filters
- **Requires:** `shortcode` (info.yml `dependencies: [shortcode:shortcode]`) — provides the
  `shortcode` filter plugin, `ShortcodeBase`, and the `ShortcodeService`/`ShortcodePluginManager`.
- **Provides:** no routes, permissions, services, config objects, Drush commands or config schema
  of its own. Activated purely by enabling the "Shortcodes" filter on a text format and ticking
  these shortcodes.

## What it actually is

- **Nine `@Shortcode` plugins** in `src/Plugin/Shortcode/*Shortcode.php`, each extending
  `Drupal\shortcode\Plugin\ShortcodeBase` and implementing `process($attributes, $text, $langcode)`
  + `tips()`. Each `process()` builds a `#theme` render array and returns
  `$this->render($output)` (which calls `renderer->renderInIsolation()`).
- **Theme hooks** declared in `advanced_shortcodes_theme()` (`advanced_shortcodes.module`), one per
  shortcode, each backed by a Twig template in `templates/shortcode-*.html.twig`.
- **Libraries** (`advanced_shortcodes.libraries.yml`): `bootstrap` (css/fix.css, css/pure_css.css)
  and `accordion-a11y` (js/accordion-a11y.js), attached on every **non-admin** page by
  `advanced_shortcodes_page_attachments()` (skips the configured admin theme).

## The shortcodes (id → template → key attributes)

| id | class | template | notable attributes |
|----|-------|----------|--------------------|
| `alerts` | `AlertsShortcode` | `shortcode-alerts.html.twig` | `type` (1/2/3/4 or bootstrap name), `class`; body = message |
| `column` | `ColumnShortcode` | `shortcode-column.html.twig` | `cols`, `xs`/`sm`/`md`/`lg`, `begin`, `end`, `class` |
| `row` | `RowShortcode` | `shortcode-row.html.twig` | body only; class forced to `row` |
| `accordions` | `AccordionsShortcode` | `shortcode-accordions.html.twig` | `class`; wraps `[accordion]` children |
| `accordion` | `AccordionShortcode` | `shortcode-accordion.html.twig` | `title`, `icon`, `class`; body = panel content |
| `icon` | `IconShortcode` | `shortcode-icon.html.twig` | `class`; body = label |
| `jumbotron` | `JumbotronShortcode` | `shortcode-jumbotron.html.twig` | `title`, `class`; body = text |
| `progress` | `ProgressShortcode` | `shortcode-progress.html.twig` | `percent`, `class` |
| `hr` | `HrShortcode` | `shortcode-hr.html.twig` | `class` |

## Solution docs

- **All nine shortcodes, their attributes, templates, libraries, and how to enable them** →
  [plugins/shortcodes.md](plugins/shortcodes.md)
