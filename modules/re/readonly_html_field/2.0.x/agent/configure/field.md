<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Add and configure a Readonly Html field

## Add the field
1. Go to the bundle's **Manage fields** (Field UI), **Add field**.
2. Choose **Readonly Html field** (category *formatted_text*).
3. Save — there is no storage cardinality to worry about; the field stores no per-entity value (`isEmpty()` returns TRUE).

## Configure the content (this is the whole point)
The HTML shown is set in the field **settings** form, not per entity:
- One **Readonly Html** `text_format` (WYSIWYG) element **per site language**, rendered in a details group; the default language's group is open and required.
- Each element has a value + a text format (default `basic_html`).

At render time the widget/formatter call `check_markup($value, $format)` for the **current** language and fall back to the **default** language's text when the current-language value is empty.

## Where it shows
- **Widget** (`readonly_html_field_widget`): renders the HTML as `#markup` on the entity **add/edit form** — an inline, non-editable note.
- **Formatter** (`readonly_html_field_formatter`): renders the same HTML on the entity's **display** view mode.

## Use cases
- Webmaster/editor notes on node add/edit forms.
- Terms-of-service text on the account registration form.

## Security note
Output is always filtered via `check_markup()` with the selected text format, so it is not raw HTML injection. The format is chosen by whoever has Field-UI access; if that includes less-trusted roles, restrict them to a safe format like `basic_html` (avoid `full_html`).
