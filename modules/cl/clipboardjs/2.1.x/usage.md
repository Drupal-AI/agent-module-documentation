<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Clipboard.js integrates the zenorocha clipboard.js JavaScript library with Drupal, adding "copy to clipboard" field formatters and theme hooks so any text value can be copied with one click.

---

The module provides four field **formatters** — `clipboard_button`, `clipboard_snippet`,
`clipboard_textfield`, and `clipboard_textarea` — selectable on an entity's *Manage display* page
for `string`, `email`, `link`, `integer`, `decimal`, `float`, `slug`, and `slug_path` fields.
Each formatter renders the field value together with a copy control and shares three settings:
`label` (the button/hovertip text, default "Click to copy"), `alert_style`
(`tooltip` | `alert` | `none`, default `tooltip`), and `alert_text` (the confirmation shown after
copying, default "Copied!"). For custom code, four matching **theme hooks** —
`clipboardjs_button`, `clipboardjs_snippet`, `clipboardjs_textarea`, `clipboardjs_textfield` —
let you drop a copy control into any render array or Form API build with `#value`, `#label`,
`#alert_style`, and `#alert_text` variables (each element gets a unique auto-generated id). The
front-end behavior is a small Drupal library (`clipboardjs/drupal`) that initializes the
clipboard.js library and shows the tooltip/alert. The actual **clipboard.js library is an
external dependency** you must download (v2.0.11) into `DRUPAL_ROOT/libraries/clipboard/dist/`
— `hook_requirements()` flags it on the status report if missing (it also detects the
Wikimedia composer-merge install path). The module has no settings page, no permissions, and no
Drush commands; its only config is the per-formatter display settings.

---

- Add a "copy" button next to a phone number, SKU, or reference code field.
- Let visitors copy an email address field with one click via the button formatter.
- Copy a link field's URL to the clipboard without selecting text.
- Show a code snippet with a copy control using the snippet formatter.
- Render a read-only textfield with an attached copy button.
- Provide a copyable textarea for multi-line values.
- Customize the button label per field (e.g. "Copy code").
- Show a tooltip confirmation ("Copied!") after a successful copy.
- Switch the confirmation to a JS alert, or disable it entirely, via `alert_style`.
- Add a copy control to a custom form element using the `clipboardjs_button` theme hook.
- Drop a copy button into a render array with `#theme => 'clipboardjs_textfield'`.
- Copy an integer/decimal/float field value (e.g. an order number).
- Copy a slug or path value for reuse elsewhere.
- Give documentation pages copyable command snippets.
- Offer one-click copy of an API key or token shown in a field.
- Standardize copy UX across many content types using one formatter.
- Provide accessible copy buttons with configurable labels.
- Copy a coupon/voucher code from a product page.
- Add copy-to-clipboard to a Views field output (via the field formatter).
- Localize the copy label and confirmation text through the settings.
- Reuse the shared `clipboardjs/drupal` library to init clipboard behavior on custom markup.
- Detect a missing clipboard.js library via the status report requirement check.
