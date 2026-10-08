<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Domain Language Negotiation selects the site language from the Domain module's domain record, so each domain in a Domain Access installation serves its own language.

---

Drupal negotiates language from a URL prefix, a domain, the session, the user or the browser, and its built-in domain negotiation matches on hostname configured in the language settings. On a Domain Access site the domains are already modelled as entities with their own configuration, and duplicating the hostname list in the language settings means two places to update and one to forget. This module negotiates from the **domain record itself**, so adding a domain and setting its language is one operation and the language settings stay in step automatically. It depends on core `language` and `domain`, with core `^9 || ^10 || ^11`; the release is **3.0.0-alpha7**. The thing that decides whether this works well is negotiation **order**: Drupal applies negotiation methods in a configured sequence and the first that resolves wins, so this needs to sit above session and browser detection for domain to be authoritative — otherwise a returning visitor's session language overrides the domain and a French domain serves English. Interaction with `domain_language` (documented earlier in this collection) is worth checking too, since both operate on the same axis.

---

- Serve a different language per domain.
- Avoid duplicating hostnames in language settings.
- Set a domain's language on the domain record.
- Run market-specific domains from one site.
- Keep language settings in step with domains.
- Support a multi-brand multilingual estate.
- Negotiate language before session detection.
- Add a domain and its language together.
- Support country-specific sites.
- Serve a Belgian and a Dutch domain distinctly.
- Reduce configuration duplication.
- Support a franchise site structure.
- Keep language authoritative per hostname.
- Simplify multilingual domain setup.
- Support an affiliate network.
- Avoid URL prefixes for language.
- Serve clean per-market URLs.
- Manage languages alongside domains.
