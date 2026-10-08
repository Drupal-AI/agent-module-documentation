<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Tooltip (ckeditor_tooltip) — agent index

A **CKEditor 5 plugin** that lets an editor wrap selected text in an accessible, richly-styled
**tooltip**. The editor selects text, clicks the **Tooltip** toolbar button, and fills a
PHP-rendered settings dialog (loaded over AJAX into a `Drupal.dialog`). On save the selection
becomes a `<span class="ckeditor-tooltip" data-tooltip-*="…">` widget; on the front end a small
behaviour reads those `data-tooltip-*` attributes and builds a positioned popup shown on hover /
click / keyboard focus. Version **1.0.0** (version dir `1.0.x`). Core `^10 || ^11`. License
GPL-2.0-or-later. Depends only on core **`ckeditor5`**.

No external libraries, no content entities, no custom fields, no shortcodes. All tooltip data is
stored inline in the field's HTML as `data-tooltip-*` attributes on the anchor span.

## What it provides (from source)

- **CKEditor 5 plugin** `ckeditor_tooltip_tooltip` (`ckeditor_tooltip.ckeditor5.yml`), PHP class
  `Plugin/CKEditor5Plugin/TooltipPlugin` (extends `CKEditor5PluginDefault`). All static config
  (label, libraries, toolbar item `tooltipButton`, allowed `<span>` elements) lives in the YAML;
  the PHP class only overrides `getDynamicPluginConfig()` to inject the settings-form URL
  (`tooltip.formUrl`) into the editor config. The plugin is gated by
  `conditions: filter: filter_ckeditor_tooltip` — the toolbar button is only available on text
  formats where the module's filter is enabled.
- **JS CKEditor plugin** `js/ckeditor5_plugins/tooltip.js` — defines the `tooltipSpan` model schema
  (`isInline` + `isObject`), data/editing/upcast converters, the toolbar button, a client-side HTML
  sanitizer (`Tooltip._sanitizeHtml`), and `_openModal()` which `$.get`s the PHP form and wires all
  handlers (save / remove / cancel / live preview / colour pickers / char counter).
- **Settings form** `Form/TooltipSettingsForm` (a `FormBase`) — builds the full field structure
  (content textarea, theme swatches, appearance, behaviour, advanced, live-preview markup). It has
  **empty `validateForm()`/`submitForm()`** — the form is never submitted to the server; all reads
  happen client-side in JS. `buildForm()` pre-fills `#default_value`s from GET query params (edit
  mode).
- **Controller** `Controller/TooltipController::settingsForm` — renders the form to an HTML fragment
  via `renderInIsolation()` and returns it as a raw `Response` (not a page). Adds security headers
  (`X-Content-Type-Options: nosniff`, `X-Frame-Options: SAMEORIGIN`, `Cache-Control: no-store`,
  `X-Robots-Tag: noindex`).
- **Route** `ckeditor_tooltip.settings_form` → `/ckeditor-tooltip/form`
  (`ckeditor_tooltip.routing.yml`), guarded by **`_user_is_logged_in: 'TRUE'`** and
  `options: no_cache: 'TRUE'`. Anonymous users get 403.
- **Text filter** `filter_ckeditor_tooltip` ("Tooltip Asset Loader",
  `Plugin/Filter/FilterTooltipAssets`, `TYPE_TRANSFORM_REVERSIBLE`) — on render it (a) attaches the
  `ckeditor_tooltip/frontend` library when a `class="…ckeditor-tooltip"` is present, and (b)
  re-sanitizes four attributes server-side (defense in depth): `data-tooltip-content` via
  `Xss::filter()` with the allowed-tag list, `data-tooltip-title` via `strip_tags()`,
  `data-tooltip-custom-id` to `[a-zA-Z][a-zA-Z0-9_-]*`, `data-tooltip-extra-class` to
  `[a-zA-Z0-9 _-]`.
- **Frontend behaviour** `js/tooltip_frontend.js` (`Drupal.behaviors.ckeditorTooltipFrontend`) —
  reads all `data-tooltip-*` attributes, builds the popup DOM, does viewport-aware auto-flip
  positioning, hover/click/focus triggers, mobile-tap, and injects the content HTML through a
  third-layer sanitizer `sanitizeForDisplay()` before `innerHTML`. Title goes to `textContent`.
- **Standalone form behaviour** `js/tooltip_form.js` — mirror of the in-editor form handling
  (a `Drupal.behaviors` variant). (Note: shipped in the `tooltip` library alongside `tooltip.js`.)
- **Libraries** (`ckeditor_tooltip.libraries.yml`): `tooltip` (editor plugin JS + admin CSS, deps
  `core/drupal`, `core/jquery`, `core/drupal.dialog`, `core/ckeditor5.internal`), `admin` (admin
  CSS only), `frontend` (front CSS + `tooltip_frontend.js`, dep `core/drupal`).
- **Hooks** (`ckeditor_tooltip.module`): `hook_help()` (a large help page + a note on
  `filter.admin_overview`) and **`hook_preprocess_node()`** which attaches
  `ckeditor_tooltip/frontend` on **every** node page unconditionally.
- **CSS** `css/tooltip.admin.css`, `css/tooltip_frontend.css`, `css/tooltip.css`; icon
  `icons/tooltip.svg`; `logo.png`.
- **Tests** under `tests/src/Unit` and `tests/src/Kernel` (filter, controller, routing, form,
  library definitions). (README references a `tests/phpunit.xml` that is **not** present in the
  packaged source.)

## No permissions / config / install (correcting the stub)

There is **no `*.permissions.yml`**, **no `config/` (no schema, no default config)**, **no
`*.install`**, and **no `composer.json`** in the source. Access to creating tooltips is governed
entirely by **text-format permissions** (whoever can use the format that carries the Tooltip
button). `data.json` has been corrected: `provides_permissions` and `provides_config_schema` are
`false`.

## Attributes (the data model)

Stored on the anchor `<span class="ckeditor-tooltip">`: `data-tooltip-content` (HTML),
`-trigger` (hover|click), `-position` (top|bottom|left|right), `-width`, `-theme` (none/dark/light/
info/success/warning/danger/glass/bordered/custom), `-bg-color`, `-border-color`, `-font-size`,
`-text-align`, `-animation`, `-delay`, `-close-btn`, `-title`, `-padding`, `-radius`, `-shadow`,
`-arrow`, `-opacity`, `-hide-delay`, `-focus-trigger`, `-interactive`, `-max-height`, `-custom-id`,
`-extra-class`. Defaults are applied in the JS dataDowncast/upcast and the frontend reader.

## Setup (from README / hook_help)

1. Enable the module (`drush en ckeditor_tooltip -y && drush cr`).
2. On the target text format (`/admin/config/content/formats`), enable the **Tooltip Asset Loader**
   filter and drag the **Tooltip** button into the CKEditor 5 toolbar.
3. If using *Limit allowed HTML tags*, add `<span class="ckeditor-tooltip" data-tooltip-content …>`
   with the full `data-tooltip-*` attribute list (README lists it) or the markup is stripped on
   save.

## Source discrepancies worth knowing

- **`ckeditor5.yml` `elements` under-declares attributes.** The `<span>` in
  `ckeditor_tooltip.ckeditor5.yml` only lists `data-tooltip-content trigger position width theme
  bg-color border-color font-size text-align animation delay close-btn`. The many *advanced*
  attributes the JS actually emits (`-title -padding -radius -shadow -arrow -opacity -hide-delay
  -focus-trigger -interactive -max-height -custom-id -extra-class`) are **not** in that
  declaration, so on formats without a permissive *Limit allowed HTML* list they can be dropped on
  the CKEditor round-trip. The README's suggested allowed-tags string is the intended workaround.
- **"Font colour" is a partial/dead feature.** `TooltipSettingsForm` renders a font-colour
  mode + picker and a `tooltip_font_color` hidden field, and `hook_help` documents
  `data-tooltip-font-color` / `--tooltip-font-color`, **but** `tooltip.js` never adds
  `tooltipFontColor` to the schema, dataDowncast, upcast, or the save `attrs`, and
  `tooltip_frontend.js` never reads it. So a chosen font colour is not persisted or rendered.
- `hook_preprocess_node()` attaches the frontend library on **every** node page regardless of
  whether a tooltip is present; the filter attaches it conditionally. README documents how to strip
  the unconditional attachment from a theme preprocess.

## Security

Reviewed in full (see the local-only review file in this directory). Verdict: **clean, no
findings**. The tooltip content is sanitized at three independent layers (client-side
`_sanitizeHtml` at save, server-side `Xss::filter()` in the filter, frontend `sanitizeForDisplay()`
before `innerHTML`); the title is rendered via `textContent`; custom-id/extra-class are regex-
whitelisted; colour inputs are hex-validated (`/^#[0-9a-fA-F]{6}$/`) before use; the form route
requires an authenticated user and carries hardening headers. No PHP write/upload/SQL/SSRF/TLS
surface exists (the only route returns a rendered form fragment).
