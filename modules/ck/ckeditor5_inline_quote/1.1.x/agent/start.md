<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CKEditor 5 Inline Quote (ckeditor5_inline_quote) — agent index

A CKEditor 5 plugin that adds a **toolbar button** which toggles an **inline quotation** around the
selected text. The produced markup is a plain HTML **`<q>…</q>`** (no class, no `cite`, no `style`).
PHP-free module — no `.module`, no `src/`, no services, no config. Package `CKEditor`. Core
requirement `^9.3 || ^10 || ^11`. License GPL-2.0-or-later. Version 1.1.0.

- **Install/enable, adding the button to a format, the exact markup, and how `<q>` survives
  `filter_html`** → [ckeditor5/inline-quote.md](ckeditor5/inline-quote.md)

## What it actually is

- A CKEditor 5 plugin registered in `ckeditor5_inline_quote.ckeditor5.yml` as
  `ckeditor5_inline_quote_inline_quote`: CKEditor5 plugin **`inlineQuote.InlineQuote`**, Drupal
  label **"CKEditor 5 Inline Quote"**, editor library `ckeditor5_inline_quote/inline_quote`,
  admin library `ckeditor5_inline_quote/admin.inline_quote`.
- **One toolbar item**: `toggleInlineQuote` (label **"Inline quote"**) — a toggle button an admin
  drags into a format's *Active toolbar*.
- `elements: [<q>]` — the plugin declares it provides the `<q>` tag, so enabling the button also
  adds `<q>` to that format's allowed HTML (no attributes, no wildcard).
- **No** `dependencies:` line in `.info.yml` (it does not declare a hard dep on the `ckeditor5`
  module, though it only functions with a CKEditor 5 format). No permissions, no routes, no Drush,
  no config object/schema, no submodules.

## JS plugin (`js/ckeditor5_plugins/inlineQuote/src/`)

Built to `js/build/inlineQuote.js` (webpack; `library: ckeditor5_inline_quote/inline_quote`).

- `index.js` exports `{ InlineQuote }`.
- `inline_quote.js` — the glue `InlineQuote` plugin; `requires` `InlineQuoteEditing` and
  `InlineQuoteUI`.
- `inline_quote-ui.js` — `InlineQuoteUI` registers the `toggleInlineQuote` button
  (`ButtonView`, `isToggleable`, icon `icons/quote.svg`), bound to the `toggleInlineQuote` command;
  clicking executes the command.
- `inline_quote-editing.js` — `InlineQuoteEditing` extends `$text` schema with the `inline_quote`
  attribute (`isFormatting: true`, `copyOnEnter: true`) and registers the
  **`attributeToElement` converter `model: 'inline_quote'` → `view: 'q'`**. It adds the
  `toggleInlineQuote` command as `new AttributeCommand(editor, 'inline_quote')`.
- `attributecommand.js` — a generic CKEditor `AttributeCommand` (from CKSource) that toggles a
  single text attribute on the selection.

## Assets

- `ckeditor5_inline_quote.libraries.yml` — `inline_quote` (the JS bundle; depends on
  `ckeditor5/ckeditor5` + `core/ckeditor5.translations`) and `admin.inline_quote` (admin CSS
  `css/inline_quote.admin.css` styling the toolbar icon).
- `icons/quote.svg`, translations under `js/build/translations/` (de, en, fr).

## Notes

- No settings form: the module has nothing to configure per site beyond the toolbar/text-format
  settings. `configure` is `null`.
- Despite the drupal.org description mentioning "custom class and cite attributes", the shipped
  1.1.0 source produces only a bare `<q>` (the converter maps to `view: 'q'` with no attributes).
