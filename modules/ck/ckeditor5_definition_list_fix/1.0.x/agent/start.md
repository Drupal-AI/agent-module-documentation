<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Definition List Fix (ckeditor5_definition_list_fix) — agent index

**JavaScript-only CKEditor 5 plugin that preserves semantic `<dl>`/`<dt>`/`<dd>` markup (and inline `<i>`), stopping unwanted `<p>` and `<em>` wrappers.**

- **Version:** 1.0.x (1.0.2)
- **Core:** `^10 || ^11 || ^12`
- **Depends:** core `ckeditor5` (module) / `core/ckeditor5` (library)
- **No PHP:** no `.module`/`.install`, routes, permissions, services, config, or config schema. Editor assets only (JS + admin CSS + SVG icon).

## What it provides
- **CKEditor 5 plugin:** `definitionListFix.CKEditor5DefinitionListFixPlugin` in `js/definition-list-fix.js`, declared in `ckeditor5_definition_list_fix.ckeditor5.yml`.
- **Model elements + converters:** registers `definitionList`/`definitionTerm`/`definitionDescription` and upcast + data/editing downcast converters mapping them to `<dl>`/`<dt>`/`<dd>` (carrying `id`/`class`/`style`).
- **Inline `<i>` preservation:** wraps `editor.data.processor.toData` to remove a redundant `<em>` around a lone `<i>` (`cleanRedundantEmAroundI`).
- **Allowed source elements (added when the plugin is on a format):** `<dl id class style>`, `<dt id class style>`, `<dd id class style>`, `<i lang dir class id title style>`.
- **Toolbar item:** `cke5_definition_list_fix_dummy` (label "Definition List Fix Plugin") + `icons/definition-list-fix.svg`; the button's `execute` handler is a no-op — the fix is passive.
- **Libraries:** `definition-list-fix` (JS) and `admin.definition-list-fix` (admin CSS) in `ckeditor5_definition_list_fix.libraries.yml`.

## Docs
- [Plugin & setup](plugins/definition-list-fix.md) — enable, add to a toolbar, model/converters, `<i>` cleanup.

## Security
Editor-only module: no server request surface, no routes, no permissions, no PHP. Output sanitization and access remain governed by the text format's filters and the `use text format` permissions.
