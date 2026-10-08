<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
JSON:API Multilingual extends JSON:API with language-aware translation handling.

---

JSON:API Multilingual adds multilingual and translation support to the JSON:API module — letting decoupled clients request and receive content in specific languages and work with entity translations through JSON:API, which core JSON:API handles only partially.

Translation access still follows entity/field access via JSON:API's access layer, so it exposes only what the requesting client is allowed to see. Depends on core `content_translation` and `jsonapi`; requires Drupal 11.

---

- Add multilingual support to JSON:API.
- Handle entity translations.
- Request content per language.
- Serve translated content.
- Extend core JSON:API's partial support.
- Respect entity/field access.
- Expose only permitted content.
- Depend on core `content_translation` and `jsonapi`.
- Require Drupal 11.
- Support decoupled multilingual sites.
- Return language-specific data.
- Work with translations.
- Support headless i18n
- Serve per-language responses.
- Integrate translations.
- Follow JSON:API access.
- Handle language negotiation.
- Expose translations safely
