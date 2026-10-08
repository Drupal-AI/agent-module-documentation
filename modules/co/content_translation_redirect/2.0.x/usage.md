<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Content Translation Redirect redirects visitors who request a content entity in a language it has **not** been translated into — sending them to the original content (or a path you choose) with an HTTP status code you configure, instead of showing an untranslated page.

---

The module defines a `content_translation_redirect` **config entity** (managed at
`/admin/config/regional/content-translation-redirect`, permission "administer content
translation redirects"). Each redirect targets either all entity types (the locked **Default**
redirect), a whole entity type (id `<entity_type>`), or a specific bundle
(id `<entity_type>__<bundle>`), and carries a **status code** (300, 301, 302, 303, 304, 305 or
307; blank = disabled), an optional **redirect path** (blank = redirect to the original
untranslated content), and a **translation mode** (`translatable`, `untranslatable`, or `all`).
A request-event subscriber runs on every request: if the site is multilingual, the current
route resolves to a content entity with a canonical link, the entity's language differs from the
current content language, and a matching redirect with a status code exists, it issues a
`TrustedRedirectResponse` to the target. Matching is most-specific-first (bundle → entity type →
Default) via a custom storage handler's `loadByEntity()`. Only content entity types that are
translatable and expose a canonical route are supported (block_content, comment,
contact_message, menu_link_content and shortcut are excluded). A dispatched
`ContentTranslationRedirectEvent` lets other code inspect or alter the response before it is
returned.

---

- Redirect a visitor requesting an untranslated article to its original-language version.
- Return a proper 301/302 instead of rendering a page in the wrong language.
- Send missing translations of a specific bundle (e.g. Article) to a custom landing path.
- Configure a site-wide Default redirect covering every supported entity type at once.
- Give different entity types different redirect behaviour (e.g. nodes 302, taxonomy terms 301).
- Redirect only translatable entities, leaving untranslatable ones alone (mode: translatable).
- Redirect only untranslatable entities to a chosen page (mode: untranslatable).
- Apply a redirect to all entities regardless of translatability (mode: all).
- Point missing-translation requests to a "content not available in your language" page.
- Improve SEO by returning canonical redirects rather than duplicate/untranslated content.
- Disable a redirect temporarily by clearing its status code without deleting it.
- Redirect missing product translations to the default-language product page.
- Keep users on a coherent language experience across a multilingual site.
- Handle partially-translated content gracefully during a phased translation rollout.
- Avoid 404s or fallback-language confusion for content lacking a requested translation.
- Override the Default behaviour for one entity type while keeping it for the rest.
- Use event subscribers to log or customise translation redirects site-wide.
- Send untranslated taxonomy term pages to the term in its original language.
- Ensure editors' unfinished translations don't expose half-translated pages publicly.
- Centrally manage all missing-translation redirect rules from one admin screen.
