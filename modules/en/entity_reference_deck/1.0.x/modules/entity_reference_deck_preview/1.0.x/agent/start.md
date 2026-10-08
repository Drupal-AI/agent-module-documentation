<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck Preview (entity_reference_deck_preview) — agent index

Optional soft-dep submodule of **Entity Reference Deck**. Live front-end preview of referenced
entities in cards (sandboxed iframe + Lit shell). Depends on `entity_reference_deck` only. Core
`^11.4 || ^12`. Version 1.0.0-beta5. Configure route `entity_reference_deck_preview.settings`.

## What it provides
- Plugin manager **PreviewProvider** (`plugin.manager.entity_reference_deck_preview.provider` /
  `PreviewProviderManager`); the plugin Attribute/Interface/Base/DTOs live in core `entity_reference_deck`.
- Preview actions **`preview_refresh`** / **`preview_toggle`**
  (`src/Plugin/EntityReferenceDeckAction/`) and preview toolbar group
  (`src/Plugin/EntityReferenceDeckGroup/PreviewEntityReferenceDeckGroup.php`).
- Routes (`entity_reference_deck_preview.routing.yml`): **`.preview`**
  (`/entity-reference-deck/preview/{entity_type}/{entity}`; `_permission` + `_entity_access` +
  `_custom_access accessPersisted`), **`.preview_draft`**
  (`/entity-reference-deck/preview/{entity_type}/draft/{token}`; `_permission` +
  `_custom_access accessDraft`), and **`.settings`**
  (`/admin/config/content/entity-reference-deck-preview`, `administer site configuration`).
- Controller `PreviewController` (renders `#type => page`, no-referrer header, uncacheable drafts),
  access `Access/PreviewAccessCheck` (permission, entity/provider access, draft overlay), draft
  storage `PreviewDraftStorage` (expirable KV, SHA-256 key, `hash_equals` redeem, uid/entity bind),
  token helper `PreviewDraftToken` (≥128-bit `random_bytes`), and `PreviewSecurityPolicy`
  (no AccountSwitcher, referrer-policy, uncacheable drafts).
- Permission **`use entity reference deck preview`** (restrict access). Config
  `entity_reference_deck_preview.settings` (draft_ttl 3600, responsive/device toolbar flags,
  full_preview_width 1320) + schema.
- Libraries: `iframe_resizer_parent`, `iframe_resizer_child`, `preview_lit`, `preview_admin`,
  `preview_document`.

## Operate
Enable after `entity_reference_deck` (pair with a host for default providers). Install **iframe-resizer
v5 on the site** under `/libraries` (not shipped). Turn on `show_preview` in the host widget's field
widget display settings. Grant *Use Entity Reference Deck preview*. Tune at the settings route. See
the module's own EXTENSION.md / HOST_ADAPTER.md for the PreviewProvider API.
