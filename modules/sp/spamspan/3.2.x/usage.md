SpamSpan obfuscates email addresses in rendered content so spambots cannot harvest them, while keeping addresses accessible: with JavaScript enabled they become clickable `mailto:` links, and without it they degrade to a readable form like `me [at] example.com`.

---

SpamSpan ships as a text-format filter plugin (`filter_spamspan`, TYPE_TRANSFORM_IRREVERSIBLE) that you enable and order on any Drupal text format at Admin > Configuration > Content authoring > Text formats and editors. When the filter runs it splits bare email addresses, existing `mailto:` links, and optionally `address[url|displaytext]` syntax into obfuscated `<span class="spamspan">` markup, attaching the `spamspan/obfuscate` JavaScript library that reassembles them into real links in the browser. Per-format settings control the "@" replacement text, an optional graphic "@" (adds the `spamspan/atsign` CSS library), optional "." replacement, and a "use a contact form instead of a link" mode with configurable URL/display-text patterns. Besides the filter it provides an `email_spamspan` field formatter for core Email fields, a `spamspan` Twig filter for use in templates, and a `spamspan` service for obfuscating arbitrary strings in code. It depends only on core's Filter module, defines no permissions of its own (gated by core's "administer filters"), and adds no Drush commands. A test/preview form lives at `/admin/config/content/formats/spamspan`.

---

- Hide author email addresses in node bodies and comments from harvesting spambots.
- Turn plain-text email addresses typed by editors into obfuscated clickable links automatically.
- Keep email links accessible to screen readers and no-JavaScript browsers via the `me [at] example.com` fallback.
- Obfuscate pre-existing `<a href="mailto:...">` links pasted into WYSIWYG content.
- Add the SpamSpan filter to the Full HTML or Basic HTML text format for site-wide coverage.
- Configure a custom "@" replacement string (e.g. ` (at) `) per text format.
- Use a graphic image in place of "@" when JavaScript is disabled by enabling "Use a graphical replacement".
- Also replace dots in the domain (`example [dot] com`) for stronger obfuscation.
- Route obfuscated addresses to a site contact form instead of exposing `mailto:` at all (use-form mode).
- Provide per-address contact-form overrides with `me@example.com[custom_url|Contact me]` syntax in content.
- Display core Email field values as obfuscated links using the `email_spamspan` field formatter in Manage display.
- Obfuscate email addresses emitted from a custom Twig template with the `{{ text|spamspan }}` filter.
- Obfuscate email strings programmatically in a module via the `spamspan` service.
- Protect webform/contact confirmation text that echoes an email address by running it through the filter.
- Prevent address harvesting from RSS/feed output while keeping human-readable addresses.
- Preview and test obfuscation output on the built-in test page before enabling on production formats.
- Apply different obfuscation settings per text format (e.g. stricter for anonymous-facing formats).
- Avoid CAPTCHAs for email exposure by hiding the address rather than gating the page.
- Safely handle bodies containing inline base64 images (the filter swaps them out before the email regex to stay fast).
- Migrate away from a legacy 7.x SpamSpan setup while keeping the same obfuscation technique on Drupal 10/11.
- Combine with other filters in a format, ordered so SpamSpan runs after HTML-producing filters.
