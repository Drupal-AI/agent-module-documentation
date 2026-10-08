<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Reference Deck (entity_reference_deck) — agent index

Pluggable toolbar actions and **erdeck-card** chrome for entity reference fields. It is **not a
field widget**: the core module renders referenced entities as cards and assembles a discoverable
toolbar around them; host submodules bind that card builder to Entity Browser and Paragraphs
widgets. Package `Entity Reference Deck`. Core `^11.4 || ^12`, PHP `>=8.3`. License
GPL-2.0-or-later. Installed release **1.0.0-beta5** (version-dir 1.0.x).

- Core dependency: **`drupal:field`** only. Configure route: `entity_reference_deck.settings`
  (`/admin/config/content/entity-reference-deck`), permission **`administer entity reference deck`**.

## What it actually is

- Three plugin types (managers in `entity_reference_deck.services.yml`, all extend
  `DefaultPluginManager`):
  - **Actions** — `Plugin/EntityReferenceDeckAction`, attribute
    `Attribute/EntityReferenceDeckAction`, interface `EntityReferenceDeckActionInterface`,
    manager `EntityReferenceDeckActionManager`. Render a button/tag beside a card.
  - **Groups** — `Plugin/EntityReferenceDeckGroup`, attribute `Attribute/EntityReferenceDeckGroup`,
    interface `EntityReferenceDeckGroupInterface`, manager `EntityReferenceDeckGroupManager`.
    Optionally wrap a toolbar group in a custom (Lit) element.
  - **Meta items** — `Plugin/EntityReferenceDeckMetaItem`, attribute
    `Attribute/EntityReferenceDeckMetaItem`, interface `EntityReferenceDeckMetaItemInterface`,
    manager `EntityReferenceDeckMetaItemManager`. Muted card meta lines.
- Core plugins: action `moderation` (`ModerationEntityReferenceDeckAction`); meta items
  `timestamps` (`TimestampsEntityReferenceDeckMetaItem`) and `editor`
  (`EditorEntityReferenceDeckMetaItem`).
- Rendering services: `EntityReferenceDeckCardBuilder` (single entry point, builds the
  `entity_reference_deck:erdeck-card` component), `EntityReferenceDeckBuilder` (toolbar),
  `EntityReferenceDeckMetaBuilder`, `EntityReferenceDeckSettingsResolver`,
  `EntityReferenceDeckModerationStyle`, `EntityReferenceDeckPendingRevisionResolver`,
  `EntityReferenceDeckRelativeTimestampFormatter`, and the decoratable
  `EntityReferenceDeckCardTypePresentationInterface` (Null default).
- SDCs under `components/`: erdeck-card, status-tag, usage-badge, type-icon, meta-text,
  action-link. Libraries `entity_reference_deck/card` and `entity_reference_deck/deck_dialog`.
- Also defines the **PreviewProvider API** base classes/DTOs in core `src/` (Attribute
  `PreviewProvider`, `PreviewProviderInterface`, `PreviewProviderBase`, `PreviewRequest`,
  `PreviewSnapshotEnvelope`, `PreviewBuild`, …); the plugin *manager* lives in the Preview submodule.
- Hooks: `hook_entity_reference_deck_action_info_alter`, `_group_info_alter`,
  `_meta_item_info_alter`, `_actions_alter`, `_meta_items_alter`, `_card_alter` (see
  `entity_reference_deck.api.php`).

## Solution docs

- **Plugin system (actions / groups / meta items) + the card & toolbar builders** →
  [plugins/plugin-system.md](plugins/plugin-system.md)
- **Global settings form, config object & schema** → [config/settings.md](config/settings.md)
- **erdeck-card SDCs, card builder slots and card_alter hook** →
  [components/cards.md](components/cards.md)
- **Submodules (EB, Paragraphs, Diff, Usage, Moderation, Paragraphs Library, Preview, Gin)** →
  [submodules/overview.md](submodules/overview.md)

## Install / operate

- Enable `entity_reference_deck`, then the host you need (`entity_reference_deck_eb` and/or
  `entity_reference_deck_paragraphs`) plus any feature submodules. Set the reference field's
  form-display widget to a Deck host widget under *Manage form display*. Tune actions/meta at the
  settings route. There is no new content/config entity type.
