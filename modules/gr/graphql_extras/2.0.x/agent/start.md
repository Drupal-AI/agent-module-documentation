<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GraphQL Extras (graphql_extras) — agent index
**Read-only GraphQL v3 field plugins: current URL/language, front-page flag, arbitrary context, relative file/image URLs.**

- **Version:** 2.0.x
- **Core:** ^9.3 || ^10 || ^11
- **Depends on:** graphql (v3)
- **Fields:** `currentUrl`, `currentLanguage`, `isFrontPage`, `pathWithQueryString`, `context` (Entity), `entityTranslationFromContext`, `entityHasTranslation`, File/ImageResource `relativeUrl`
- No routes, mutations, or permissions of its own.

**Security:** all field plugins declared `secure = true` and resolve only non-sensitive, already-derivable values (URLs, language, relative paths, GraphQL-governed context); no mutations, no data-exposure sinks; access governed by the GraphQL v3 server config and resolved objects' own access.
