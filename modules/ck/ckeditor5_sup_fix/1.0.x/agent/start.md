<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor5 Sup Fix (ckeditor5_sup_fix) — agent index

A lightweight **CKEditor 5** plugin that stops CKEditor 5 from mangling `<sup>` (superscript)
markup — the classic problem where a footnote reference such as a superscripted link survives
CKEditor 4 but is stripped or restructured by CKEditor 5's General HTML Support (GHS). The plugin
takes ownership of the `<sup>` element in the editor's model so it round-trips intact, preserving
`id`, `class`, `name`, and `style` attributes and inline children. Package `CKEditor 5`. Core
`^10 || ^11 || ^12`. Depends on core `ckeditor5`. License GPL-2.0-or-later. Installed as **1.0.0**
(version dir `1.0.x`). No composer.json, no README, no config schema, no routes, no permissions.

## How it is enabled

There is **no configuration page** and no real toolbar button. The module registers a *dummy*
toolbar item (`cke5_sup_fix_dummy`, whose UI component factory returns `null`). To turn the fix on
for a text format, an editor drags the "Sup Fix Dummy" button into that format's CKEditor 5 toolbar
and saves — this is the standard Drupal mechanism for loading a CKEditor 5 plugin per format. Nothing
visible appears in the editor; the plugin loads silently. As a belt-and-braces fallback,
`hook_form_alter` also attaches the plugin library to any form that contains a `text_format` widget
(see below), so the JS is present even before the dummy button is added.

## What it provides (from source)

- **CKEditor 5 plugin definition** `ckeditor5_sup_fix.ckeditor5.yml` — declares plugin
  `ckeditor5_sup_fix_plugin` that loads core `htmlSupport.GeneralHtmlSupport` plus the module's own
  `ckeditor5_sup_fix.CKEditor5SupFixPlugin`. Its GHS `config` allows element `sup` with
  `attributes: true`, `classes: true`, `styles: true`, `children: true` (client-side widening). The
  `drupal:` section declares `elements: - <sup id name class style>` (the server-side allowed-tag
  string added to `filter_html`), `library`/`admin_library` `ckeditor5_sup_fix/htmlsupport`, and the
  dummy `toolbar_items` entry.
- **JS plugin** `js/sup-fix-plugin.js` — class `CKEditor5SupFixPlugin`. On `init()` it: registers the
  null `cke5_sup_fix_dummy` UI component; calls `DataFilter.disallowElement('sup')` to "own" `<sup>`,
  then `allowAttributes` for `id/class/name/style`; registers a model element `htmlSup`
  (`allowWhere: '$text'`, `isInline`, `allowContentOf: '$inline'`); adds upcast (view `sup` →
  `htmlSup`) and downcast (`htmlSup` → container `sup`) converters copying `id/class/name/style`; and
  registers the inline element with `DataSchema` when present. Also assigns `window.__supEditor` and
  emits `console.log` debug lines.
- **Hook** `src/Hook/Ckeditor5SupFixHooks.php` (`Hook('form_alter')`, wired via
  `ckeditor5_sup_fix.services.yml` autowire + a `#[LegacyHook]` shim in `ckeditor5_sup_fix.module`) —
  when `ckeditor5` is enabled, iterates top-level `$form` elements and, if any has a
  `['widget'][0]['#type'] === 'text_format'`, attaches library `ckeditor5_sup_fix/htmlsupport`.
- **Filter plugin** `src/Plugin/Filter/SupLinkFixFilter.php` — id `sup_link_fix_filter`, type
  `TYPE_TRANSFORM_IRREVERSIBLE`, weight 101, **disabled by default** and explicitly marked
  *experimental and not needed when using the dummy fix* in its own title. A single
  `preg_replace_callback` merges a split `<sup>…</sup> <a…>…</a> <sup…>…</sup>` sequence back into one
  `<sup>` wrapper. It only re-wraps markup already present in the text; it introduces no new content.
- **Library** `ckeditor5_sup_fix.libraries.yml` → `htmlsupport` (the JS plus `css/cke5.admin.css`,
  which only sets the dummy toolbar-button icon; depends on `core/ckeditor5`).
- Assets: `icons/sup-fix-icon.svg`, `logo.png`, `LICENSE.txt`. No install/update/schema/routing/
  permissions files.

## Usage notes

- The intended path is the **dummy button + GHS plugin** (client-side preservation). The
  `sup_link_fix_filter` is a legacy/experimental server-side regex repair for content already mangled
  before the plugin was in use — leave it off unless specifically needed, and enable it only on a text
  format where you understand the transform.
- `attributes: true` in the `.ckeditor5.yml` GHS config is client-side only; the server-side allowed
  attributes are constrained to `id name class style` by the `elements` declaration and the text
  format's own `filter_html` settings.

No further subdocs — the module's entire surface is covered above.
