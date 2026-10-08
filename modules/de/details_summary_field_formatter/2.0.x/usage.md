<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Details Summary Field Formatter

Renders text/text_long/text_with_summary field values inside a native `<details>` element so the content is collapsible, with a summary line you can customise.

- Choose whether the disclosure starts expanded or collapsed.
- Provide a custom summary label, or fall back to the field label.
- Content is rendered through Drupal's text-format pipeline (safe).

---

## Installation & configuration

- Enable; on a text field's **Manage display**, select the "Details with Summary" formatter.
- Set **Expanded** (default on) to control the initial open state.
- Set **Custom Summary** text, or leave blank to use the field label.
- Applies to `text`, `text_long`, and `text_with_summary` field types.
- No permissions or routes are provided.
- Optional `markdown` module is used only to render the module's own README in help.

---

## Usage & behaviour / security

- Formatter class: `src/Plugin/Field/FieldFormatter/DetailsSummaryFormatter.php`.
- `viewElements()` builds a `#type => details` with `#open` from the expanded setting.
- The field content is output via `#type => processed_text` using the item's own text format — so text-format filtering/XSS protection applies.
- The custom summary is sanitised with `Xss::filterAdmin()` before display.
- The settings summary also runs the custom summary through `Xss::filterAdmin()`.
- No raw, unfiltered user markup is emitted — no stored-XSS surface introduced by this formatter.
- Great for FAQs, long descriptions, terms, or any content that benefits from collapsing.
- Multiple field values each get their own `<details>` block.
- Works with multi-value fields (one disclosure per delta).
- No external calls, DB access, or permissions.
- Combine with a text format that restricts allowed HTML for untrusted authors.
- The `config/` directory holds formatter schema.
- Display settings are stored in the entity view display config.
- Uninstall reverts affected displays to a default formatter.
- Read: `src/Plugin/Field/FieldFormatter/DetailsSummaryFormatter.php`.
