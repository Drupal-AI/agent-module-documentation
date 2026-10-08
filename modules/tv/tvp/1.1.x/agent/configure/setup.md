<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Translate View Path

There is **no settings form and no config of its own** (`configure` is null; the module ships no
`config/` directory). All configuration is done with **core's URL Alias UI**; this module only makes
those per-language aliases take effect on Views page URLs.

## Prerequisites
- A multilingual site: `language` enabled with more than one language, and a language negotiation
  that produces language-specific URLs (typically the URL/prefix method). The processor only acts
  when the current/URL language differs from the default language.
- A Views **page display** with a real path (e.g. `/program`). Paths starting with `admin/` are
  ignored by design.

## Steps
1. Enable `tvp` (depends on core `path_alias` and `views`).
2. Note the view display's path, e.g. `/program`.
3. Go to **`/admin/config/search/path`** (URL aliases) → **Add alias**. Set:
   - **System path**: the view path, e.g. `/program`.
   - **Alias**: the localised path, e.g. `/programmes`.
   - **Language**: the target language (e.g. Norwegian `nb`). Create one alias per language you want
     localised.
4. **Clear caches** (`drush cr` or the admin cache-clear). The map of view-path → alias is cached for
   24 hours under the cache id `view_path_aliases_cid`, so a new or changed alias is not picked up
   until caches are cleared or the TTL expires.

## Result
- Outbound: links/URLs generated for the view in a language that has an alias emit the alias
  (`/programmes` for `nb`) instead of the route path.
- Inbound: a request to the aliased path resolves back to the view route.

## Facets Pretty Paths
This is the primary use case. Facets Pretty Paths builds the public URL from the **view path plus
facet segments** (`/products/colour/red/...`). Aliasing the base view path per language via the steps
above lets the localised base propagate to those generated faceted URLs. Facet **value** segments are
handled by the facets/pretty-paths configuration itself; verify round-tripping (every generated URL
resolves back to the same view state in the same language) after setup.

## Gotchas
- Forgetting the cache clear is the most common "it didn't work". 
- The processor runs on **every** non-admin request (inbound and outbound); keep aliases minimal and
  correct. There is no per-path opt-in — any view path that has a matching alias in the active
  language is subject to rewriting.
- No alias for a given language ⇒ no rewrite; the source-language path is used as-is.
