<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Back button blocks

Four block plugins under `src/Plugin/Block/`, all extending `BackButton`. Placed via core Block UI (`/admin/structure/block`); no custom routes. Requires core `block` + `link`.

## `back_button` — `BackButton`
Generic/referer back button. `defaultConfiguration()`:
- `preferred_paths` (textarea, one path per line; wildcards `*` allowed, lower-cased before match)
- `link` = `{url, text}` — fallback internal link (URL element is `entity_autocomplete`, `#target_type => 'node'`, validated by `LinkWidget::validateUriElement`)
- `use_preferred_page_title` (bool, default TRUE) — use the matched page's entity label as link text
- `preferred_link_text` (string, default `Back`) — text when no title available
- `use_javascript` (bool, default FALSE) — render `javascript:history.back(-1)` handler instead

`build()` calls `backButtonManager->getPreferredLink(...)`; if that returns empty (no matching referer), falls back to `getLink($this->getLinkUrl(), $this->getLinkText())`. `getCacheContexts()` adds `route` and `headers:referer`.

Referer handling (`BackButtonManager`, see api/services.md): the referer is accepted only if it starts with the site's own scheme+host (same-origin), then the base URL is stripped and the path matched against `preferred_paths` via `PathMatcher::matchPath()` (alias-aware). Link text/URL are built with core `Link::fromTextAndUrl()` (auto-escaped). `addLinkAttributes()` adds class `back-button`, `rel="nofollow"`, and (when JS) class `js-history-back` + attaches library `navigation_blocks/history-back`.

## Entity-context back buttons (deriver-driven)
All three are derived **per entity type that has a view builder** by `EntityBackButtonDeriverBase::getDerivativeDefinitions()`, which attaches an `entity` context (`EntityContextDefinition::fromEntityTypeId()`) and a per-type admin label. Base `EntityBackButtonBase::build()`: loads the context entity via `getEntity()`; if it exists and is not new, returns `$entity->toLink()->toRenderable()` with back-button attributes; otherwise falls back to `BackButton::build()`.

- **`entity_canonical_back_button`** — `EntityCanonicalBackButton`, deriver `EntityCanonicalBackButtonDeriver`. `getEntity()` = `getContextValue('entity')`. `build()` returns empty when `backButtonManager->isCanonicalPath()` is true (route name contains `.canonical`), so the button only shows off the canonical page.
- **`entity_reference_back_button`** — `EntityReferenceBackButton`, deriver `EntityReferenceBackButtonDeriver`. Extends `EntityReferenceBackButtonBase`, adding a required `entity_reference_field` select. Options from `EntityButtonManager::getEntityReferenceFieldOptions()` (all `entity_reference` fields on the type's bundles). `getReferencedEntity()` → `EntityButtonManager::getReferencedEntity($contextEntity, $field)` (first referenced entity; throws `EntityMalformedException` → empty build if none).
- **`reversed_entity_reference_back_button`** — `ReversedEntityReferenceBackButton`, deriver `ReversedEntityBackButtonDeriver`. Options from `getReversedEntityReferenceFieldOptions()` keyed `type:bundle:field`. `getReferencedEntity()` splits that key and calls `EntityButtonManager::getReversedEntityReferenceEntity()` (loads the entity whose reference field points at the current entity).

`EntityReferenceBackButtonBase` inherits all `BackButton` config keys plus `entity_reference_field`; `blockForm()` reads the context's `EntityType` constraint to scope the field select.

## Notes for agents
- Config lives in the block config entity (`block.block.*`); no dedicated schema ships in this module.
- To show an entity back button you must place the *derived* block for the specific entity type (e.g. "Entity Canonical Back Button (Content)") in a region on the entity's pages.
- Link text is rendered through core Link/`toLink()` render arrays — output is auto-escaped.
