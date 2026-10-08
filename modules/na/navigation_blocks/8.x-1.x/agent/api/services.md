<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Services & helper API

Defined in `navigation_blocks.services.yml`. All are plain PHP helpers with no routes/permissions; reusable from custom code.

## `navigation_blocks.back_button_manager` → `BackButtonManager` (`src/BackButtonManager.php`)
Args: `@current_route_match`, `@request_stack`, `@navigation_blocks.path_matcher`, `@entity_type.manager`. Implements `BackButtonManagerInterface`.
- `getPreferredLink(string $preferredPaths, string $preferredLinkText='Back', $useJavascript=FALSE, $usePreferredPageTitle=TRUE): array` — returns a render array only if a same-origin referer exists and matches `$preferredPaths`; else `[]`. Uses `PathMatcher::matchPath()` + `validateCurrentPath()`. When `$usePreferredPageTitle`, text is the matched route's entity label (`getBackButtonText()`).
- `getLink(Url $url, string $text, $useJavascript=FALSE): array` — builds `Link::fromTextAndUrl()` render array; returns `[]` if there is no current route or the target equals the current path.
- `getRefererPath(): string` — reads the `referer` header; returns `''` unless it starts with `http(s)://` **and** the site's own scheme+host (same-origin guard), then strips the base URL.
- `isCanonicalPath(): bool` — true when the current route name contains `.canonical`.
- `addLinkAttributes(array &$link, $useJavascript=FALSE): void` — adds class `back-button`, `rel="nofollow"`; when JS, class `js-history-back` + attaches `navigation_blocks/history-back`.

## `navigation_blocks.path_matcher` → `PathMatcher` (`src/PathMatcher.php`)
Args: `@path.current`, `@path.matcher`, `@path_alias.manager`. Implements `PathMatcherInterface`.
- `matchPath(string $path, string $preferredPaths): bool` — normalises trailing slash, resolves alias↔system path, lower-cases, and delegates to core `path.matcher` (wildcard support) against both alias and system path.
- `validateCurrentPath(Url $url): bool` — false when the current page's alias equals the candidate URL's internal path (avoids linking back to the same page).

## `navigation_blocks.entity_button_manager` → `EntityButtonManager` (`src/EntityButtonManager.php`)
Args: `@entity_type.manager`, `@entity_type.bundle.info`, `@entity_field.manager`. Implements `EntityButtonManagerInterface`.
- `getEntityReferenceFieldOptions(EntityTypeInterface): array` — all `entity_reference` fields across the type's bundles, keyed by field name.
- `getEntityType($id): EntityTypeInterface`.
- `getReferencedEntity(ContentEntityInterface $entity, string $fieldName): EntityInterface` — first referenced entity of the field; throws `EntityMalformedException` if none.
- `getReversedEntityReferenceEntity(EntityInterface $entity, string $reversedEntityTypeId, string $reversedBundle, string $reversedFieldName): EntityInterface` — `loadByProperties()` on the reversed type where `<field>.entity.<idKey> = $entity->id()` (+ optional bundle); throws if none/id null.
- `getReversedEntityReferenceFieldOptions(EntityTypeInterface): array` — scans `field_storage_config` for `entity_reference` fields targeting this type, expands to `field_config` instances, keyed `targetType:bundle:field`.

## `navigation_blocks.toc_builder` → `TocBuilder` (`src/TocBuilder.php`)
No constructor args. Fluent builder for the TOC render array — see plugins/toc.md.

## Hooks (`navigation_blocks.module`)
Only `hook_help()` for `help.page.navigation_blocks`. No install/schema/update hooks; the module ships no `config/` directory.
