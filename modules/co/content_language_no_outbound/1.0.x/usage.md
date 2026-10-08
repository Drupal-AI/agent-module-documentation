<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content language (no outbound) reads the content-language query param but never adds it to generated URLs.

---

Content language detection (no outbound) is a replacement for Drupal's core content-language negotiator: it determines the content language from the `language_content_entity` query parameter but, unlike core, by default does not add that parameter to outbound/generated URLs (an optional config textarea can re-enable appending it for named entity link-template paths). This keeps content-language switching working while producing cleaner links.

It's a language-negotiation utility with no content or access role of its own. Supports Drupal 10 and 11.

---

- Detect content language from a query param.
- Read `language_content_entity`.
- Avoid adding the param to URLs.
- Replace core's content-language negotiator.
- Produce cleaner outbound links.
- Keep language switching working.
- Support Drupal 10 and 11.
- Carry no content/access role.
- Act as a negotiation utility.
- Configure via language settings.
- Improve URL cleanliness.
- Negotiate content language.
- Avoid outbound parameter leakage.
- Support multilingual sites.
- Complement core negotiation.
- Handle entity language.
- Keep links tidy.
- Detect without emitting.
