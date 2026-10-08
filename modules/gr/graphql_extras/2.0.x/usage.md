<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GraphQL Extras is a collection of GraphQL v3 field plugins that facilitate progressive decoupling — current URL/language, front-page detection, arbitrary context on entities, and relative file/image-style URLs.
---
The module registers `@GraphQLField` plugins on the GraphQL v3 schema: `currentUrl` and `currentLanguage` (Root fields), `isFrontPage`, `pathWithQueryString` (Url field), `entityTranslationFromContext` / `entityHasTranslation`, a `context` field that exposes arbitrary Drupal context objects on the Entity parent (extending graphql_core's Context deriver), and `relativeUrl` helpers for File and ImageResource that call the core `file_url_generator` `transformRelative()`. These are syntactic-sugar/read helpers for building language switchers that preserve query strings and for emitting root-relative asset URLs in decoupled front-ends.

Every field plugin is declared `secure = true` and resolves only already-derivable, non-sensitive values (a URL, a language, a relative path, or context objects the GraphQL layer already governs). The module adds no routes, no mutations, and no permissions of its own — access to the data is governed by the underlying GraphQL v3 server/schema configuration and the resolved objects' own access. Requires the `graphql` (v3) module.

Typical setup: install alongside GraphQL v3, then reference the new fields (`currentUrl`, `currentLanguage`, `relativeUrl`, `pathWithQueryString`, etc.) in your queries.
---
- Build a language switcher that preserves the current query string.
- Query the current page URL from a decoupled front-end.
- Get the current interface language and its localized links.
- Detect whether the current route is the front page.
- Emit root-relative file URLs for portable asset references.
- Emit relative URLs for a specific image style (ImageResource).
- Expose arbitrary Drupal context objects on an entity in GraphQL.
- Resolve an entity's translation from the current context.
- Check whether an entity has a translation in a language.
- Return a path including its query string as one field.
- Support progressive decoupling of an existing Drupal theme.
- Provide language-aware navigation data to a JS app.
- Avoid absolute-domain URLs in decoupled responses.
- Combine currentUrl + pathWithQueryString for canonical links.
- Feed relative image-style URLs into a headless image component.
- Query current user context via the arbitrary context field.
- Keep query strings intact across language links.
- Reduce custom resolver code for common URL/language needs.
- Use as reference implementations for GraphQL v3 field plugins.
- Layer on top of graphql_core's context deriver.
