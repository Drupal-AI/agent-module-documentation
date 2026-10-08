<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Language Access denies the canonical view of a translatable content entity when the current content language is neither the entity's original language nor an available translation.

---

Entity Language Access adds one extra access check to the canonical route (`entity.<type>.canonical`) of every content entity type that is translatable and has a canonical link template. On such a route it compares the current content language against the language of the entity that the route loaded: if they differ (i.e. the entity has no translation in the requested language, so core loaded its original/fallback translation instead), the check returns forbidden, producing a 403 instead of showing the untranslated content under the wrong language. It only guards the canonical *view* — edit, delete and other routes, and any listing (Views, EntityQuery, JSON:API collections), are untouched, so untranslated entities are hidden only on their canonical page. A `bypass entity_language_access` permission lets chosen roles see every language regardless. Optionally, instead of a plain 403 page you can point the module at a node to render as fallback content for the missing translation. The module depends only on core `language`, requires no external services, and works out of the box once enabled — no per-entity or per-bundle configuration is needed.

---

- Hide a node on its canonical URL in any language it has not yet been translated into, returning a 403.
- Prevent untranslated content from appearing in its original language when a visitor browses in another language.
- Roll out a multilingual site incrementally without exposing half-translated content.
- Keep an English-only article invisible under the `/fr/` or `/de/` prefix until a translation is published.
- Automatically cover every translatable content entity type (nodes, custom content entities, media, taxonomy terms if translatable, etc.) with one module, no per-type setup.
- Only affect entity types that are actually marked translatable — non-translatable types stay fully accessible in every language.
- Only affect canonical routes that follow the `entity.<type>.canonical` naming convention.
- Leave edit/delete/other entity operations working normally regardless of language.
- Grant a `bypass entity_language_access` permission to translators or editors so they can view any entity in any language while working.
- Grant the bypass permission to administrators so back-office access is never blocked by language rules.
- Show a friendly "content not available in your language" page by pointing the module at a fallback node instead of the default 403 page.
- Route missing-translation 403s to a single, fully translated fallback node accessible to all users.
- Combine with the Language module's content language negotiation to enforce per-language visibility.
- Add a language filter to Views listings alongside this module so untranslated rows are also hidden in lists.
- Enforce that anonymous visitors only ever see canonical pages that exist in their current language.
- Support editorial workflows where translations are published one language at a time.
- Turn a missing translation into a 403 rather than silently serving stale original-language content.
- Configure fallback content once at Configuration > Regional and language > Entity Language Access.
- Disable fallback content to fall back to Drupal's standard 403 access-denied page.
- Provide an `administer entity_language_access` permission to control who can change the module's settings.
- Apply the same language rule uniformly across all translatable content entity types without writing code.
- Use with content_translation to complement translation management with language-scoped canonical access.
- Keep untranslated content reachable to editors (via the bypass permission) while hidden from the public.
- Serve as a lightweight alternative to custom hook_entity_access code for language-based canonical visibility.
