<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Administration Language Negotiation adds an interface-language detection method that forces administration pages into each user's preferred admin language, so you can serve the front end in one language while keeping the back office in another.

---

The module registers a core language negotiation method, "Administration language" (id `administration-language-negotiation`, weight -4, for the **interface** language type). You enable and order it on *Configuration → Regional and language → Languages → Detection and selection* (it must be placed **before** other interface methods). When active, for any user holding the `use administration language negotiation` permission it checks a set of pluggable conditions and, on matching admin locations, returns that user's `preferred_admin_langcode` (optionally falling back to the site default). Which locations count as "admin" is configured on the module's settings form and stored in `administration_language_negotiation.negotiation`: a list of `paths` (glob patterns, default `/admin`, `/admin/*`, `/node/add/*`, `/node/*/edit`, …), an `admin_routes` boolean (treat every admin route as admin), and a `use_default_lang` fallback boolean. The conditions are a small plugin type (`administration_language_negotiation_condition`) with two shipped plugins, `paths` and `admin_routes`, so other modules can add their own matching rules. The module also unhides the core "Administration pages language" (`preferred_admin_langcode`) field on the user edit form for permitted users.

---

- Keep the admin/back-office UI in English while the public site is in another language.
- Let each editor pick their own preferred administration language (per-user).
- Force `/admin/*` pages into a chosen interface language regardless of the front-end language.
- Apply the admin language to node add/edit/translation forms (default path list).
- Treat every admin route as an admin page via the `admin_routes` setting instead of listing paths.
- Add custom paths (e.g. a custom dashboard) to the admin-language path list.
- Fall back to the site default language when a user has no preferred admin language (`use_default_lang`).
- Grant non-administrator roles the ability to choose an admin language via the permission.
- Expose the core `preferred_admin_langcode` field on user profiles for permitted users.
- Order the "Administration language" method above URL/browser detection so it wins on admin pages.
- Provide a multilingual editorial team a consistent back-office language.
- Localize only the editing experience without translating public content.
- Combine path patterns and admin-route detection for flexible admin-language coverage.
- Add a custom condition plugin to define bespoke "is this an admin location" logic.
- Support wildcard paths (e.g. `/blog/*`) and `<front>` in the path configuration.
- Prefix-aware matching so language-prefixed admin URLs still trigger the admin language.
- Restrict the admin-language behavior to users you trust via the dedicated permission.
- Keep translators in their working language on the back end while previewing content in its own language.
- Deploy the admin-language path list as exported config for consistent environments.
- Roll out a uniform admin language across a large multisite editorial team.
