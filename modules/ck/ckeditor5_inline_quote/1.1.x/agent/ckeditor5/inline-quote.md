<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Inline quote button (CKEditor 5)

Give editors a toolbar button that marks a text selection as an **inline quotation** — an HTML
**`<q>`** element — for quoting a phrase inside a sentence rather than pulling a whole paragraph out
as a block quote. The button is a **toggle**: click it on an unquoted selection to wrap it, click it
again on a quoted selection to unwrap it.

## Install & enable

```
composer require drupal/ckeditor5_inline_quote
drush en ckeditor5_inline_quote -y
```

`ckeditor5_inline_quote.info.yml` declares **no** `dependencies:`, so nothing else is auto-enabled;
in practice you use it with the core **CKEditor 5** editor on a text format.

## Add the button to a text format

The plugin is defined in `ckeditor5_inline_quote.ckeditor5.yml` as
`ckeditor5_inline_quote_inline_quote`, exposing one `toolbar_items` entry, `toggleInlineQuote`
(label **"Inline quote"**).

1. *Structure → Text formats and editors* (`/admin/config/content/formats`) → edit a
   **CKEditor 5** format (permission `administer filters`).
2. Drag the **Inline quote** button from *Available buttons* into the **Active toolbar**.
3. Save. In that editor, select some text and click the button to toggle a `<q>` around it.

Per-format: repeat for each format that should offer the button. Only the toolbars you edit get it.

## What markup it produces

- **In the content**: the selection is wrapped in a bare `<q>…</q>` — **no** attributes (no
  `class`, no `cite`, no `style`).
- CKEditor 5 works on a model, not the DOM. `inline_quote-editing.js` extends the `$text` schema
  with an **`inline_quote`** attribute (`isFormatting: true`, `copyOnEnter: true`) and registers a
  converter: `conversion.attributeToElement({ model: 'inline_quote', view: 'q' })`. So the model
  attribute `inline_quote` is downcast to (and upcast from) the view element `<q>` in both the
  editing and data pipelines.
- The toggle logic is `attributecommand.js` — a generic CKSource `AttributeCommand` registered as
  the `toggleInlineQuote` command via `new AttributeCommand(this.editor, 'inline_quote')`. Its
  `execute()` sets the attribute when off and removes it when on, over the valid ranges of the
  selection.
- The button itself (`inline_quote-ui.js`) is a `ButtonView` with `isToggleable: true`, its `isOn`
  bound to the command's `value`; the icon is `icons/quote.svg`.

## How `<q>` survives `filter_html`

The `.ckeditor5.yml` declares:

```yaml
elements:
  - <q>
```

This is the standard CKEditor 5 mechanism (`elements`) by which a plugin advertises the HTML it
produces. When an admin adds the **Inline quote** toolbar button to a format that uses the
*Limit allowed HTML tags* (`filter_html`) filter, core's CKEditor 5 integration adds **`<q>`** to
that format's allowed-HTML list automatically, so the produced markup is not stripped on save.

- The declared element is exactly `<q>` — a single, benign inline tag with **no attributes** and
  **no wildcard**. It does not add `style`, `class`, or any other attribute to the format.
- If a format's `filter_html` does not allow `<q>` and the button is not enabled (e.g. a restricted
  format where an admin has not added the button), a manually typed `<q>` is stripped. Enabling the
  button is what grants the tag.
- A fully unrestricted format (no `filter_html`) needs no whitelisting.

## Gotchas

- **Add the button, or the tag is stripped.** On a restricted format, only enabling the toolbar
  button teaches `filter_html` to keep `<q>`.
- The button is a **toggle** — clicking on an already-quoted selection removes the quote.
- Style the quotation from your theme/CSS (e.g. locale-appropriate quotation marks via the `<q>`
  pseudo-elements); the module ships no front-end CSS for `<q>`, only admin CSS for the toolbar icon
  (`admin.inline_quote` → `css/inline_quote.admin.css`).
- No settings form, no config object, no permissions of its own — nothing to configure beyond the
  toolbar.
- Cite points: `ckeditor5_inline_quote.ckeditor5.yml`, `ckeditor5_inline_quote.libraries.yml`,
  `.info.yml`, and JS `index.js` / `inline_quote.js` / `inline_quote-ui.js` /
  `inline_quote-editing.js` / `attributecommand.js`.
