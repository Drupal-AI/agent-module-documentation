<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Plain Text Formatter renders a link field as plain text — the title, or the URL when there is no title — instead of as a clickable anchor.

---

Core's link-field formatters all render an `<a>` element, which is right on a web page but wrong in the many places a field value gets reused as text: a plain-text email, a CSV cell, a print stylesheet, an SMS, a QR-code source, an `alt` attribute. This module adds one extra formatter — id `link_plain_text_formatter`, label **Plain text** — that outputs the link's title when it has one, or the URL string when it does not, run through `Html::escape()` so the result is safe plain text rather than markup. To use it, install the module as usual (`ddev composer require drupal/link_plain_text_formatter` then enable it), create or edit a **Link** field, go to *Manage display* for the entity/bundle, and choose the **Plain text** format for that field; there are no formatter settings to configure. Without this module the usual workaround is a Views field rewrite or a per-case template override, which is a lot of ceremony for "show the text". It depends only on core `link`, spans core `^8` through `^11`, and is version **8.x-1.3**.

---

- Show a link as text in a plain-text email.
- Export link fields to CSV.
- Render a URL for a print stylesheet.
- Include a link in an SMS body.
- Show a URL as the source for a QR code.
- Display a link field without an anchor element.
- Feed a URL into a Views rewrite.
- Show the link title only, as text.
- Render a link into a data attribute.
- Build a plain-text newsletter from content.
- Include URLs in a data export.
- Show a URL in a tooltip.
- Avoid writing a template override just to strip the anchor.
- Render a link into JSON output built from rendered fields.
- Show a URL that should not be clickable.
- Display a link in a plain-text log or notification.
- Support a text-only view mode.
- Include a URL in an image alt attribute.
