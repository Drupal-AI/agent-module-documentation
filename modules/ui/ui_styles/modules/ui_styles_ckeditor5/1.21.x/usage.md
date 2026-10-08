<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
UI Styles CKEditor 5 adds two CKEditor 5 toolbar buttons — "UI Styles (block)" and "UI Styles (inline)" — that let content authors apply curated UI Styles CSS classes to block-level elements or to inline spans directly inside the rich-text editor.

---

This submodule provides two CKEditor 5 plugins (`ui_styles_ckeditor5_uiStylesBlock` and
`ui_styles_ckeditor5_uiStylesInline`, both extending `UiStylesBase`) declared in
`ui_styles_ckeditor5.ckeditor5.yml`. Each adds a toolbar item (`UiStylesBlock` / `UiStylesInline`)
whose dropdown lists the UI Styles you have enabled for that button. Which styles are offered is
configured per text format on the CKEditor 5 toolbar configuration: the plugin's
`buildConfigurationForm` shows the available styles grouped by category, and the chosen style
plugin ids are stored in the editor config `editor.editor.<format>` under
`settings.plugins.ui_styles_ckeditor5_uiStylesBlock.enabled_styles` (and the inline equivalent),
schema `ui_styles_ckeditor5_ckeditor5_plugin` (a non-empty sequence of style ids). At runtime the
JavaScript plugins apply the selected style's CSS class to the current block element (any HTML5
element via `<$any-html5-element class>`) or wrap the selection in a styled `<span>`. Admin/editor
preview CSS comes from the UI Styles stylesheet generator. No route, permission or settings page of
its own — configuration lives on each text format.

---

- Let authors add a "lead paragraph" or "callout" class to a block in the editor.
- Wrap selected inline text in a highlighted or badge span.
- Offer editors a curated set of text-colour classes inside CKEditor.
- Apply a background utility to a paragraph from the toolbar.
- Add an inline "code" or "kbd"-style class to selected words.
- Give a blockquote a styled treatment via the block button.
- Restrict which styles are available per text format (basic vs full HTML).
- Provide authors a consistent design-system palette in rich text.
- Apply alignment or spacing classes to a block element in content.
- Add an emphasis/inline utility class to a phrase.
- Keep author styling governed instead of raw class entry in source view.
- Style a lead image caption inline.
- Add a "text-muted" class to secondary inline text.
- Offer a "button-like" inline style for links.
- Apply a rounded/shadow block class to an embedded element.
- Configure block and inline style buttons independently per format.
- Preview styles in the editor iframe using the generated stylesheet.
- Enable only brand-approved classes for editors.
- Let editors mark up warnings/notes as styled blocks.
- Standardise inline emphasis across content authors.
- Apply utility classes without leaving the WYSIWYG editor.
