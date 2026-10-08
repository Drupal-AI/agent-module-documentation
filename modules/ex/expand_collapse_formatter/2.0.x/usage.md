<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Expand Collapse Formatter provides a single field formatter (`expand_collapse_formatter`) that renders a long text field trimmed to a configurable length with a JavaScript "Show more / Show less" toggle link, so visitors can expand or collapse the full value in place.

---

The module adds one `@FieldFormatter` plugin, `expand_collapse_formatter` (label "Expand collapse formatter"), that you select on an entity's **Manage display** screen for any multi-line text field — `text_long`, `string_long`, `text_with_summary`, or `text_long_with_summary`. It has no admin settings page of its own (`configure` is null); every option lives in the per-field formatter settings and is stored in the display config entity under `field.formatter.settings.expand_collapse_formatter`. The formatter renders the field value inside a `div.expand-collapse` wrapper (theme hook `expand_collapse_formatter`, template `expand-collapse-formatter.html.twig`) carrying the settings as `data-*` attributes and attaches the `expand_collapse_formatter/expand_collapse_formatter` library. Client-side JavaScript (`Drupal.behaviors.expandCollapseFormatter`, built on `core/once`) measures the field's plain-text length and, only when it exceeds the trim length, inserts a toggle link that swaps between the trimmed text and the full HTML. Configurable settings are `trim_length` (default 300), `default_state` (`collapsed` or `expanded`, default `collapsed`), `link_text_open` ("Show more"), `link_text_close` ("Show less"), `link_class_open` (`ecf-open`), and `link_class_close` (`ecf-close`). Trimming is done in the browser at word boundaries with a trailing " ...", so the full markup is still delivered to the page and remains crawlable. No PHP dependencies and no external libraries are required.

---

- Collapse long article bodies to a preview with a "Show more" link on teaser or full node displays.
- Truncate verbose product descriptions on commerce or catalog pages.
- Keep event or venue descriptions short until a visitor expands them.
- Shorten user/profile "About me" biography fields.
- Trim long comment bodies so a thread stays scannable.
- Collapse lengthy FAQ answers behind an expand toggle.
- Preview blog post summaries with a per-field trim length.
- Hide the bulk of a "Terms and conditions" text field until expanded.
- Truncate long testimonial or review text on listing pages.
- Collapse detailed job or role descriptions in a careers listing.
- Show a short excerpt of case-study content with an inline expand.
- Trim long taxonomy-term descriptions on term pages.
- Preview marketing copy in cards or tiles that reference a long text field.
- Collapse release notes or changelog text fields.
- Shorten long biographies on a team/staff directory.
- Truncate multi-paragraph course or lesson descriptions.
- Collapse property/real-estate listing descriptions.
- Provide a "read more" experience without splitting the field into summary + body.
- Customize the toggle wording per field (e.g. "Read more"/"Read less") via the link-text settings.
- Style the open/close toggle differently by setting distinct CSS classes per state.
- Start a field expanded but still offer a "Show less" collapse control by setting the default state to expanded.
- Keep full field content in the DOM (SEO-friendly) while only visually trimming it client-side.
- Apply consistent preview truncation across many bundles by reusing the same formatter settings.
