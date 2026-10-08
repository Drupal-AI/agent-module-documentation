<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Language Access — agent index

Gates each configured language behind a dynamic permission `access language <langcode>`.
Roles without a language's permission get HTTP 403 on its pages and never see it in
switchers, hreflang tags, sitemaps, or language selects. No settings form, no config
(`configure` is `null`); everything is driven from the permissions page.

- **The permission, its name format, install defaults, and how to grant it** →
  [permissions/language-access.md](permissions/language-access.md)
- **How access is enforced and where the language is pruned (403 subscriber, switch links, hreflang, sitemap, negotiation, content-translation overview)** →
  [extend/enforcement.md](extend/enforcement.md)

Key facts: permission id = `access language <langcode>` (built by
`LanguageAccessPermissions::permissions()` from `language_manager`). Install grants
`access language <default>` to the anonymous + authenticated roles. Depends on the core
`language` and `user` modules; no permissions of its own beyond the dynamic set.
