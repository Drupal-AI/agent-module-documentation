<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Styles Combo Plus (stylescomboplus) — agent index

**CKEditor 4** Styles dropdown plugin with reliable image-class support. Version **1.0.1**, core `^9.3 || ^10`. Depends on core `ckeditor` (CKEditor 4 — not CKEditor 5).

**Shape:** `CKEditorPlugin` `StylesComboPlus` (button `StylesPlus`), JS at `js/plugins/ckeditor/stylescomboplus/plugin.js`. Admin enters `element.class|Label` lines; `generateStylesSetSetting()` builds CKEditor `stylesSet`, and for `img` rules also emits a `type:widget,widget:image` variant (CKEditor4 #1674 workaround). `validateStylesValue()` regex-validates syntax + unique labels. Ships `css/stylescomboplus.css`, attached on all pages via `hook_preprocess_html`.

**Surface:** admin-only editor settings; no routes/permissions/untrusted input.
