<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Obfuscate Email hides email addresses from spam harvesters by rendering them scrambled (ROT13 with `@`/`.` replaced by `/at/`/`/dot/`) on the server and reassembling them in the browser with a small vanilla-JS behaviour, either as a text filter for rich-text output or as a field template for `field_email` fields.

---

The module obfuscates emails two ways that share one JavaScript library (`obfuscate_email/default`, attached to every page via `hook_page_attachments_alter`). **(1) A text-format filter** — the `obfuscate_email` filter plugin (`TYPE_TRANSFORM_REVERSIBLE`) scans processed text for `mailto:` anchors, ROT13-encodes the address with `.`→`/dot/` and `@`→`/at/`, stores it in a `data-mail-to` attribute, blanks the visible address (`href="#"`, inner text replaced with `@email`), and can optionally require a click to reveal (settings `click` and `click_label`). **(2) A field template** — `hook_theme()` registers `field__email` (template `field--email.html.twig`, base hook `field`), which applies the same `/at//dot/` + ROT13 transform (using a Twig `rot13` filter provided by the `Rot13Extension` Twig extension service) to any field named `field_email`, emitting `data-mail-to`/`data-replace-inner` markup. On the client, `Drupal.behaviors.obfuscateEmailField` finds every `[data-mail-to]` element, reverses ROT13 and the `/at//dot/` substitutions, restores the `mailto:` href on anchors, and swaps the placeholder text back to the real address — with a click-to-reveal variant for `[data-mail-click-link]` elements. There is **no admin settings page** (the only configuration is per-text-format filter settings), no permissions, and no Drush. **Note:** because reassembly is JavaScript-only, there is no non-JS fallback — users without JavaScript never see the address.

---

- Stop spam bots from harvesting `mailto:` links in body/rich-text content via the text filter.
- Obfuscate every `field_email` field on the site by enabling the module's field template.
- Require visitors to click a "Click here to show mail address" link before the email appears.
- Customise that reveal link's label per text format (the `click_label` setting).
- Protect a "Contact" email printed in a node body without hand-writing obfuscation markup.
- Add the Obfuscate Email filter to a CKEditor text format so editor-entered addresses are scrambled on output.
- Keep email addresses clickable for real users (JS restores the `mailto:` href) while hiding them from crawlers.
- Reuse the `rot13` Twig filter in a custom template to scramble other sensitive strings.
- Override `field--email.html.twig` via Drupal's theme suggestion system to customise the obfuscated markup.
- Present a plain-text email field as an obfuscated `<span>` that reassembles on load.
- Present a linked email field as an obfuscated anchor that becomes a real `mailto:` link client-side.
- Reduce spam to a staff mailbox listed on a public team page.
- Apply consistent email hiding across many content types by using the shared field template.
- Combine the filter with an existing text format's other filters (it is transform-reversible, so it composes safely).
- Encode the `@` and `.` characters so pattern-based scrapers cannot regex out the address.
- Provide a lightweight, dependency-free (vanilla JS, no jQuery) email-hiding solution.
- Hide author contact emails rendered through Views field output that passes through a filtered text format.
- Obfuscate emails in webform confirmation text or block content that uses a filtered format.
- Keep addresses out of the raw HTML source so "view source" harvesting is defeated.
- Gate email disclosure behind a user interaction for a bit of extra bot resistance (click mode).
- Standardise anti-spam email handling site-wide with a single module enable.
- Swap only the address portion of link text (`data-replace-inner`) while keeping surrounding copy.
- Migrate legacy hand-obfuscated emails to a maintained, template-driven approach.
