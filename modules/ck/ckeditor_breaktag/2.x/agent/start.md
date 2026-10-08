<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Break Tag (ckeditor_breaktag) — agent index

Adds one CKEditor 5 toolbar button, **Line Break**, that inserts a `<br>` at the cursor.
Version **2.1.0**, `core_version_requirement: ^10 || ^11 || ^12`, depends only on core
`drupal:ckeditor5`. Authoring-only convenience; no PHP routes, no permissions, no config
form, no config schema. Not covered by a security advisory policy.

## What it actually does
- `.ckeditor5.yml` registers CKEditor 5 plugin `drupalBreakTag.DrupalBreakTag` with one
  `toolbar_items` entry `linebreak` (label "Line Break") and declares `elements: - <br>`
  so text formats using the button also allow `<br>`.
- The JS plugin (`js/ckeditor5_plugins/drupalBreakTag/src/drupalbreaktag.js`, built to
  `js/build/drupalBreakTag.js`) registers a `linebreak` `ButtonView` bound to CKEditor 5
  core's **`shiftEnter`** command. Clicking the button runs `editor.execute('shiftEnter')`.
  The button label reads "Insert Line Break (Shift+Enter)".
- Keyboard shortcut: line breaks are produced by core's ShiftEnter plugin, i.e. **Shift+Enter**
  (the button just exposes the same command). The project page/README's mention of
  "Ctrl+Enter" is inaccurate relative to the shipped code.
- PHP surface is a single `hook_help()` implemented as an OOP hook class
  (`src/Hook/CkeditorBreaktagHooks.php`, wired via `.services.yml` autowire + `.module`
  `#[LegacyHook]` shim) returning a static help string. Nothing processes user input.

## Enabling it (per text format)
1. `/admin/config/content/formats` → Configure a CKEditor 5 format.
2. Drag the **Line Break** / BreakTag button into the active toolbar.
3. Ensure the format's "Allowed HTML tags" permit `<br>` (the plugin's declared element
   covers this when the button is enabled) or the filter strips the break on save.

## Files
- Info/config: `ckeditor_breaktag.info.yml`, `ckeditor_breaktag.ckeditor5.yml`,
  `ckeditor_breaktag.libraries.yml`, `ckeditor_breaktag.services.yml`
- PHP: `ckeditor_breaktag.module`, `src/Hook/CkeditorBreaktagHooks.php`
- JS: `js/ckeditor5_plugins/drupalBreakTag/src/{index,drupalbreaktag}.js`, `js/build/drupalBreakTag.js`
- Assets: `icons/linebreak.svg`, `css/breaktag.admin.css`

## Security
No server-side or markup-manipulation attack surface: no routes/controllers/forms/permissions,
no filter plugin (does not rewrite stored HTML), and the sole declared element `<br>` is an
inert void tag that carries no attributes. Authoring convenience only.

See also: [`../usage.md`](../usage.md), [`../human-docs/index.md`](../human-docs/index.md).
