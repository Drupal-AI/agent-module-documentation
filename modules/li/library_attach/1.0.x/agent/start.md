<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Library attach (library_attach) — agent index

A single text-format **filter** plugin, id `library_attach`, title **"Library scanner"**. When the
filter runs on a piece of content, it loads the HTML and checks it against a set of
selectors, and for every selector that matches an element it **attaches the corresponding asset
library** to the page (`FilterProcessResult::addAttachments(['library' => [$name]])`). The text
itself is never modified — the filter's only effect is which CSS/JS libraries the render carries.

The set of attachable libraries is **not named by the content**. Any module or theme opts a library
in by adding a `filter-selector-css` or `filter-selector-xpath` key to its definition in a
`*.libraries.yml` file; the filter discovers those keys across `core`, every enabled module, and the
**active theme**, builds a map of `extension/library → XPath`, and matches content against it
(`getLibrarySelectors()` in `src/Plugin/Filter/LibraryAttach.php`). CSS selectors are converted to
XPath with Symfony's `CssSelectorConverter`; `filter-selector-xpath` takes precedence over
`filter-selector-css` when both are present. The map is cached in `cache.data` under the
`library_info` cache tag, so a selector change needs a cache rebuild (`drush cr`) to take effect.
Content can therefore only *trigger* one of these developer-declared libraries, never load an
arbitrary one.

- Depends on: core `filter`. No non-core module dependencies.
- Core: `^10 || ^11`. Package: none declared. Version **1.0.1**.
- Composer requires the `ext-dom` PHP extension and `symfony/css-selector` (`^6.4 || ^7.0`).
- **No settings page / `configure` route**, no permissions, no services of its own, no routes, no
  hooks, no drush, no config schema, no plugin *types*. The entire surface is: one Filter plugin +
  the `filter-selector-css` / `filter-selector-xpath` library-definition convention.

## What you'd do → where

- **Turn the filter on for a text format so libraries auto-attach** →
  [configure/filter.md](configure/filter.md)
- **Make one of your own libraries attachable (declare a CSS/XPath selector in `*.libraries.yml`)** →
  [api/library-selectors.md](api/library-selectors.md)

## Key facts (real machine names)

- Filter plugin: id `library_attach`, title "Library scanner", type
  `Drupal\filter\Plugin\FilterInterface::TYPE_TRANSFORM_IRREVERSIBLE`, provider `library_attach`,
  class `Drupal\library_attach\Plugin\Filter\LibraryAttach`.
- Library-definition keys read from `*.libraries.yml`: `filter-selector-xpath` (used verbatim),
  `filter-selector-css` (converted to XPath). Map key format: `"{extension}/{library_name}"`.
- Core services consumed (via `create()`): `library.discovery`, `module_handler`, `theme.manager`,
  `cache.data`.
- Cache: entry key `Drupal\library_attach\Plugin\Filter\LibraryAttach::getLibrarySelectors`,
  bin `cache.data`, `Cache::PERMANENT`, invalidation tag `library_info`.
- Public methods: `process($text, $langcode)`, `getLibrarySelectors()`, `tips($long)`.
- Extensions scanned: `['core'] + array_keys(module_handler->getModuleList()) + [active theme name]`
  — base themes and non-active themes are NOT scanned.
