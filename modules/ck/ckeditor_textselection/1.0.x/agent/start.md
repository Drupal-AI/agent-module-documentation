<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor Text Selection (ckeditor_textselection) — agent index

A **CKEditor 5 plugin** that **preserves the text selection / cursor position when toggling
Source Editing mode** on and off, and scrolls the selection back into view. It is the CKEditor 5
equivalent of the CKEditor 4 "textselection" addon. Purely behavioural: **no toolbar button, no
extra HTML elements, no server component, no configuration.** Package `CKEditor`. Core
`^10 || ^11 || ^12`. License GPL-2.0-or-later. Installed as **1.0.1** (version dir `1.0.x`).

## Dependencies

- Drupal module: **`ckeditor5`** (core) — from `.info.yml`.
- npm/asset library: **`levmyshkin/ckeditor5-textselection` `^1.0`** — from `composer.json`, a
  drupal-library package installed to `/libraries/ckeditor5-textselection/`. This is where the
  actual plugin logic lives (`build/textSelection.js`).

## What it provides (from source)

The whole module is one PHP shim plus asset wiring; all behaviour is in the JavaScript library.

- **CKEditor 5 plugin** `ckeditor_textselection_text_selection` (`ckeditor_textselection.ckeditor5.yml`):
  loads the CKEditor plugin `textSelection.TextSelection` and the Drupal library
  `ckeditor_textselection/textSelection`. `elements: false` (adds no allowed HTML tags, so it
  does **not** widen the text format's GHS/allowed-tags set). No toolbar item.
- **Auto-enable condition**: the plugin declares `conditions: plugins: [ ckeditor5_sourceEditing ]`,
  so it is **automatically active whenever the core Source Editing plugin is enabled** in a text
  format — there is no separate toolbar item to add. (The README's step "enable the Text Selection
  plugin" is effectively satisfied by enabling Source Editing.)
- **PHP class** `src/Plugin/CKEditor5Plugin/TextSelection.php` — an empty subclass of
  `CKEditor5PluginDefault`. It holds no logic and no config (no `getDefaultConfiguration`, no
  form); it exists only so Drupal's CKEditor 5 plugin system can register the plugin.
- **Asset library** `textSelection` (`ckeditor_textselection.libraries.yml`): the single minified
  file `/libraries/ckeditor5-textselection/build/textSelection.js`, depending on `core/ckeditor5`.

## How the JavaScript works (library, `src/textselection.js`)

Client-side only. On `init()` it bails if the CKEditor `SourceEditing` plugin is absent.
It tracks the model selection on every change, and on the `change:isSourceEditingMode` event
(HIGH priority, before the textarea is torn down) it maps offsets between the editor model's plain
text and the raw HTML source by walking both strings character-by-character (skipping tags,
decoding entities). Entering source mode it applies the mapped offsets with
`textarea.setSelectionRange` (or the CodeMirror instance's `setSelection` when
`ckeditor_codemirror`'s `SourceEditingCodeMirror` plugin is present) and scrolls to the caret via a
hidden mirror `<div>`. Leaving source mode it reads the textarea/CodeMirror cursor and restores the
model selection via `writer.setSelection`, deferred with `setTimeout(0)`. All failures are caught
silently. Selection restore uses selection-range APIs and `textContent` for measurement — it never
writes source content back through `innerHTML`.

## Not present

No routes, controllers, services, permissions, config schema, config entities, hooks, install/update
hooks, templates, submodules, or Drush commands. No admin settings page (`configure: null`).

## Install / use

Enable the module, then enable **Source Editing** on a CKEditor 5 text format at
*Admin > Configuration > Content authoring > Text formats and editors*. Selection preservation then
works automatically. The asset library `levmyshkin/ckeditor5-textselection` must be present under
`/libraries` (Composer installs it via the module's `composer.json` require).

This module is trivial enough to be fully covered by this single page; there are no subdocuments.
