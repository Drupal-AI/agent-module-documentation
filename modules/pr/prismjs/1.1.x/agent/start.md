<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Prism Js syntax highlighter (prismjs) — agent index

**A self-contained CKEditor 5 code-block integration**: a toolbar button + dialog let editors insert
code and pick a language, a custom `<prism-js>` element stores it, and a reversible text-format
filter rewrites that into PrismJS `<pre><code class="language-X">` markup. Depends on core
`ckeditor5`. Settings at `/admin/config/content/prism-js`. Version **1.1.4**, core `^9 || ^10 || ^11`,
PHP `^7.3 || ^8.0 || ^8.1`. License GPL-2.0-or-later. Not security-advisory covered.

**Distinguish it from `prism` (a different project).** This module owns *both* the editor side and
the display side, and the language is **chosen explicitly in the dialog** — not detected from
content — so the two halves always agree. All PrismJS CSS/JS ships **locally** (eight bundled
themes); there is **no CDN option, no copy-to-clipboard, no line-numbers config** in this version.

## What it actually provides
- **CKEditor 5 plugin** `Drupal\prismjs\Plugin\CKEditor5Plugin\PrismJs` — adds the `prismJs` toolbar
  button; its JS (`js/build/prismJs.js`) registers a `prismJs` model element downcast to a
  `<prism-js>` view element carrying `data-plugin-id` and `data-plugin-config`. Dynamic config injects
  the dialog and preview URLs.
- **Dialog form** `src/Form/PrismJsDialogForm.php` (route `prismjs.dialog`, `_access: TRUE`) — a
  language `<select>` (restricted to the site-configured language list) plus a "Source Code" textarea
  from the `language_select` plugin. On submit returns an `EditorDialogSave` command with
  `data-plugin-id` and `data-plugin-config = Json::encode({language, text})`. Persists nothing
  server-side.
- **Preview controller** `src/Controller/PrismJsPreview.php` (route `prismjs.preview`, custom access =
  `use text format {format}`) — renders the `language_select` plugin's `build()` for the in-editor
  live preview. Inputs run through `Xss::filter` + `Json::decode`.
- **Text-format filter** `src/Plugin/Filter/PrismJs.php` (`id: prismjs`, `TYPE_TRANSFORM_REVERSIBLE`,
  weight 100) — the load-bearing renderer. See `filters/mechanism.md`.
- **Settings form** `src/Form/PrismJsSettingsForm.php` (route `prismjs.settings`, permission
  `administer prismjs configuration`, `restrict access: TRUE`) — chooses available languages
  (checkboxes over ~297 grammars from `prismjs_available_languages()`) and default theme. Config
  object `prismjs.settings` (keys `languages`, `theme`). See `config/settings.md`.
- **Custom plugin type** `prismjs` (`plugin.manager.ckedito5_prismjs`, annotation
  `Drupal\prismjs\Annotation\PrismJs`, base `PrismJsPluginBase`, interface `PrismJsInterface`). The
  only bundled plugin is `language_select` (`src/Plugin/PrismJs/LanguageSelect.php`).
- **Libraries** (`prismjs.libraries.yml`): `prismjs` (the CKEditor build), `admin.prismjs`, one
  `prismjs.{theme}` per bundled theme (default/dark/funky/okaidia/twilight/coy/solarized-light/
  tomorrow-night), and `prismjs.custom`. All assets are local. NOTE a stray unused `twitter` library
  pointing at `platform.twitter.com/widgets.js` — dead code, attached nowhere.
- **Theme hook** `prismjs_language_select` → `templates/prism-js/prismjs-language-select.html.twig`
  (`<pre><code class="language-{{ language }}">` — Twig-autoescaped, safe).

## Index
- `filters/mechanism.md` — the `prismjs` filter: regex match, `data-plugin-config` extraction,
  JSON decode, escaping behaviour, exact output markup, attached libraries.
- `config/settings.md` — settings form, config schema, the CKEditor 5 dialog/preview flow, routes,
  permission, and how to wire the format up (allowed tags, filter enablement).

## Quick facts for agents
- The dialog's language `<select>` is populated from the site-configured `languages` list; the stored
  block keeps the chosen language in its `data-plugin-config` JSON, which the filter reads back at
  render time.
- Filter runs at **weight 100** (late) and rebuilds its markup after `html_entity_decode`.
- Enabling: turn on CKEditor 5 for a format, drag the Prism Js button to the toolbar, enable the
  "Prism Js" filter, and (unless Full HTML) allow `<pre>`, `<code>`, and the `class` attribute.
