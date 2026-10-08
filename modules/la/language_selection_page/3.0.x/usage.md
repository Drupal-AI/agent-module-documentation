<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Language Selection Page adds a language negotiation method that shows the visitor a page to choose from, when no other method has decided.

---

Drupal negotiates language from the URL, the session, the account, the browser's `Accept-Language` header and a site default, in a configured order. Every one of those can be wrong: a URL with no prefix, a browser advertising a language the site does not have, a shared computer whose previous user chose differently, a visitor in one country reading another country's language. Where getting it wrong matters — a site whose languages are not translations of each other, a regulated market where the language carries legal content, an organisation whose audiences genuinely differ — asking is better than guessing. This module supplies the asking as a **negotiation method**, which is the right shape: it slots into the existing chain at `/admin/config/regional/language/detection`, so it runs only when the methods above it have not decided, rather than being a redirect bolted on top. Version **3.0.0** on core `^10 || ^11`, depending on core `locale` and `path_alias`. Two things to weigh. **An interstitial costs visitors**: a page between the click and the content increases bounce and dilutes the referral, and it is worst for the people it is meant to help, who arrive from a search result already in their language and are asked to confirm it — so place it below the URL and account methods, never above. And **search engines must not be given it**: a crawler that hits the selection page indexes it instead of the content, so the page needs to stay out of the sitemap, and the URL-prefixed language pages must remain directly reachable without passing through it.

---

- Ask visitors to choose a language.
- Add a language splash page.
- Handle an ambiguous browser language.
- Support genuinely different audiences.
- Provide a fallback when negotiation fails.
- Support a regulated multilingual market.
- Let visitors correct a wrong language.
- Add a language chooser for a homepage.
- Support a bilingual country's site.
- Handle visitors from many regions.
- Provide an explicit language choice.
- Support a site whose languages differ in content.
- Add a landing choice for a campaign.
- Handle a shared-computer scenario.
- Offer a clear language entry point.
- Support an institutional multilingual site.
- Provide a fallback below URL negotiation.
- Let a visitor set their preference.
