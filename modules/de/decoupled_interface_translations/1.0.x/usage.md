<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Decoupled Interface Translations exposes two JSON HTTP endpoints for reading translated interface strings and registering new source strings from a decoupled front-end.

---

Decoupled Interface Translations builds on core **Locale** to let a headless/decoupled application manage its own set of user-interface strings inside Drupal's translation system. It reserves a dedicated string context, `Decoupled Translation`, and provides two routes: a **GET** endpoint (`/decoupled-interface-translations`) that returns every translated string in that context, grouped by enabled language and mapping source text to its translation; and a **POST** endpoint (`/decoupled-interface-translations/add`) that accepts a JSON array of source strings and registers any that don't yet exist as Locale source strings tagged with the `Decoupled Translation` context. Both routes require an authenticated user holding the `access interface translation endpoint` permission and accept `basic_auth` or `cookie` authentication. Once source strings are registered, translators use Drupal's ordinary interface-translation UI (or imports) to supply the actual translations, which then flow back out through the GET endpoint. The module ships no configuration UI, no config entities, and no schema — it is purely the two endpoints plus one permission.

---

- Serve a decoupled/headless front-end its UI string translations as JSON from Drupal.
- Fetch all `Decoupled Translation`-context translations grouped by enabled language in one GET call.
- Keep a JavaScript SPA's interface strings in sync with Drupal's Locale system.
- Register new UI source strings from a front-end via the POST `/add` endpoint.
- Let translators use Drupal's normal interface-translation workflow for decoupled app strings.
- Centralize front-end and back-end UI translations in a single Locale store.
- Expose translations to a mobile app backend over `basic_auth`.
- Restrict endpoint access to trusted service accounts via the `access interface translation endpoint` permission.
- Return a per-language map of source string to translation for client-side i18n libraries.
- Seed Drupal's translation store with the strings a headless app needs translated.
- Avoid duplicating source strings — POST reports created vs. already-existing strings.
- Integrate with a GraphQL/JSON:API decoupled architecture as a translations feed.
- Provide a machine-readable translations file endpoint for build-time fetching.
- Namespace decoupled strings away from Drupal's own UI strings using the dedicated context.
- Drive per-language content in a Next.js/Nuxt/React front-end from Drupal translations.
- Feed a translation-management pipeline that pushes source strings into Drupal.
- Retrieve only translated strings (untranslated ones are omitted from the GET response).
- Support cookie-authenticated in-browser fetches for a progressively decoupled page region.
- Bulk-submit an array of source strings in a single POST request.
- Use as the translation backbone for a decoupled editorial or campaign microsite.
