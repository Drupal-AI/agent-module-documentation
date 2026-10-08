<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# erdeck-card SDCs, card builder slots, and the card_alter hook

## Single Directory Components (`components/`)

Six experimental SDCs in group *Entity Reference Deck* (each `<name>.component.yml` +
`.twig` + `.css`):

- **`erdeck-card`** — the row shell. Props: `attributes` (Attribute), `moderation_modifier`
  (string: draft|has-draft|new). Slots: `icon`, `type`, `label`, `meta`, `toolbar`, `attachment`.
  `libraryOverrides` depends on `entity_reference_deck/card`.
- **`status-tag`** — moderation/status pill (used by the `moderation` action).
- **`usage-badge`** — usage count badge (used by the Usage submodule action).
- **`type-icon`** — entity/paragraph type icon (props `src`, `alt`, `is_default`, `attributes`).
- **`meta-text`** — a muted meta / type line.
- **`action-link`** — a toolbar link/button.

## How the card render array is built

`EntityReferenceDeckCardBuilder::build()` returns:

```
#type      => component
#component => entity_reference_deck:erdeck-card
#props     => { attributes, moderation_modifier? }
#slots     => { label(#plain_text), icon?, type?, meta?, toolbar? }
#attached  => library: entity_reference_deck/card
```

- **Label** is always `#plain_text` (never raw markup). Type/moderation labels come from the
  entity type or `EntityReferenceDeckCardTypePresentationInterface`; the presentation service is a
  decoration root (Null default) so paragraphs / library submodules can enrich labels/icons.
- **Icon** always renders a `type-icon` component; when presentation resolves no URL it uses the
  shipped `images/type-icon-default.svg` (root-relative path via `ExtensionPathResolver`).
- **Moderation** tint/label comes from `EntityReferenceDeckModerationStyle::resolve()` and is added
  as `data-moderation-state` / `title` / `aria-label` attributes plus a `moderation_modifier` prop.
- Empty per-slot builds are filtered out (`array_filter`) because `Element::isRenderArray()` rejects
  `[]`; the Twig template falls back to empty `{% block %}` defs for any missing slot.
- Cache metadata: the referenced entity, the meta "tip" entity, and cache tag
  `config:entity_reference_deck.settings`.

## Twig / escaping

`erdeck-card.twig` captures each slot with `block(...)|trim` and prints with `|raw`. This is the
standard Drupal SDC slot pattern: the captured blocks are already-rendered (auto-escaped) render
arrays, and the label/type/meta content originates from `#plain_text`, escaped `@`-placeholder
`TranslatableMarkup`, or the render pipeline — not from unescaped user input.

## Extending the card

`hook_entity_reference_deck_card_alter(array &$build, EntityInterface $entity,
EntityReferenceDeckContext $context)` runs last in `build()`, for every host. It is the single
place to add content to a card regardless of host — e.g. the Preview submodule fills
`$build['#slots']['attachment']` when `$context->showPreview` is set. Shared modal-dialog options
for actions like Diff live in `EntityReferenceDeckModalDialog` (library
`entity_reference_deck/deck_dialog`, width `92%`, dialogClass `erdeck-toolbar-dialog`).
