<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Submodules

Each ships in `modules/<name>/` inside the project and is documented in its own nested tree under
`modules/en/entity_reference_deck/1.0.x/modules/<name>/`. All are `1.0.0-beta5`, core `^11.4 || ^12`.

## Hosts (bind the card builder to a widget)

- **entity_reference_deck_eb** — Entity Browser host. Deps: `entity_reference_deck`,
  `entity_browser`. Provides the `entity_reference_deck` Entity Browser `FieldWidgetDisplay`
  (`Plugin/EntityBrowser/FieldWidgetDisplay/EntityReferenceDeckDisplay`) — renders each referenced
  entity through `EntityReferenceDeckCardBuilder`, honouring `$entity->access('view')` (falls back to
  a restricted label). Library `widget`. Optional pairing with `entity_browser_multi`.
- **entity_reference_deck_paragraphs** — Paragraphs host. Deps: `entity_reference_deck`,
  `entity_reference_revisions`, `paragraphs`. Provides `EntityReferenceDeckParagraphsWidget`
  (field widget), a `ParagraphsCardTypePresentation` decorator (type/icon via
  `ParagraphsType::getIconUrl()`), a `ParagraphPreviewProvider`, and the
  `ParagraphPreviewSnapshot` service. Library `widget`.

## Feature submodules (add actions / surfaces)

- **entity_reference_deck_diff** — Deps add `diff`. Action `diff`
  (`DiffEntityReferenceDeckAction`), a Diff `Layout` plugin `ErdeckSplitFieldsDiffLayout`, and an
  AJAX modal route `entity_reference_deck_diff.dialog` (custom access check
  `EntityReferenceDeckDiffDialogAccess` verifying entity + both revisions view access).
- **entity_reference_deck_usage** — Deps add `entity_usage`. Action `usage`
  (`UsageEntityReferenceDeckAction`) + `EntityReferenceDeckUsageCounter` service.
- **entity_reference_deck_moderation** — Deps add `content_moderation`, `workflows`. Service
  `EntityReferenceDeckContentModerationStyle` supplying CM-aware card tint/labels.
- **entity_reference_deck_paragraphs_library** — Deps `entity_reference_deck_paragraphs`,
  `paragraphs_library`. Library-item theme + `LibraryItemCardTypePresentation` /
  `LibraryItemParagraphUnwrapper` + a preview provider.

## Optional

- **entity_reference_deck_preview** — Live front-end preview of referenced entities inside cards
  (iframe + Lit shell). Soft-dep on `entity_reference_deck` only. Provides the PreviewProvider
  plugin *manager*, hardened preview routes (persisted + draft-token), preview actions
  (`preview_refresh`, `preview_toggle`), a preview group, a settings form
  (`/admin/config/content/entity-reference-deck-preview`), permission
  **`use entity reference deck preview`**, and the draft-token storage. Does **not** ship
  iframe-resizer — install it on the site. See its nested tree for details.
- **entity_reference_deck_gin** — Gin admin theme skin. Dep `entity_reference_deck`. Remaps
  `--erdeck-*` tokens via `Hook/LibraryHooks::libraryInfoAlter()` (library `gin_skin`); no PHP
  logic beyond the library alter.
