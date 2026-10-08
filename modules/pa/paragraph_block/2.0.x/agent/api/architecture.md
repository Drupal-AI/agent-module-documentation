<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Internal mechanism

The trick: one real block-content bundle (`paragraph_block`) provides storage, and each opted-in
paragraph type is projected as a synthetic "fake" bundle so editors pick a paragraph type but get an
ordinary block. Constants live in `ParagraphBlockServiceInterface`:
`BLOCK_TYPE = 'paragraph_block'`, `FIELD_NAME = 'field_paragraph_block_paragraph'`.

## Service — `paragraph_block.service`

`ParagraphBlockService` (`src/ParagraphBlockService.php`), constructed with the block manager and
entity type manager:

- `getParagraphBlockTypes()` — loads all `paragraphs_type` entities, returns those whose
  `getThirdPartySetting('paragraph_block', 'status')` is truthy, keyed by bundle.
- `getParagraphBlockTypeKeys()` — `array_keys()` of the above; the canonical "which paragraph types
  are blocks" list used everywhere.
- `static elementAfterBuild()` — widget `#after_build` that unsets remove/collapse buttons, the type
  label and header actions on the embedded paragraph widget.

## Hooks — `Hook/ParagraphBlockHooks`

Registered as a hook object (`.module` uses `#[LegacyHook]` shims; the class uses `#[Hook(...)]`).

- **`entity_type_alter`**: when `block_content` exists, swaps handlers —
  `block_content_type` storage → `CustomBlockContentTypeStorage`,
  `block_content` storage → `CustomBlockContentStorage`,
  `block_content` access → `ParagraphBlockContentAccessControlHandler`.
- **`block_type_form_alter`** (bundle `paragraph_block`): appends
  `ParagraphBlockService::elementAfterBuild` to the field widget's `#after_build`.
- **`form_language_content_settings_form_alter`** (`Order::Last`): unsets each fake bundle from
  `$form['settings']['block_content'][…]` so they can't get independent content-translation settings.
- **`entity_duplicate`**: when a `BlockContentInterface` with `FIELD_NAME` is duplicated, calls
  `createDuplicate()->save()` on each referenced paragraph and re-sets the field, so a duplicated
  block gets its **own** paragraphs rather than sharing them.

## Custom bundle storage — `CustomBlockContentTypeStorage`

Extends `ConfigEntityStorage` (`src/Entity/Storage/CustomBlockContentTypeStorage.php`).

- `loadMultiple()` augments the real bundles with **fake bundles** from `getFakeBundles()` — one per
  opted-in paragraph type, `create()`d in memory (id = paragraph type key, label = its label,
  a "dynamically generated bundle" description, status TRUE). Gated by `$this->overrideFree` (so the
  synthetic bundles surface in listings/UI but stay out of raw override-free config reads) or when a
  requested id is itself a paragraph-block key.
- These fake bundles are what make each paragraph type show up as its own choice in `/block/add` and
  the Layout Builder chooser, without any real `block_content.type.*` config existing for them.

## Custom content storage — `CustomBlockContentStorage`

Extends `SqlContentEntityStorage` (`src/Entity/Storage/CustomBlockContentStorage.php`).

- `doCreate()`: if `$values['type']` is one of the paragraph-block keys, it remembers it as
  `$paragraph_type` and **rewrites `$values['type']` to the real `paragraph_block` bundle** before
  `parent::doCreate()`. After creation, if the entity's `FIELD_NAME` is empty it creates a fresh
  `paragraph` of the chosen type and appends it — so a new paragraph block opens with an empty
  paragraph of the right type ready to edit.

Net effect: editors and Layout Builder think they created a "My component" block; on disk it is a
`paragraph_block` block whose one paragraph is a "My component" paragraph.

## Access — `ParagraphBlockContentAccessControlHandler`

Extends core `BlockContentAccessControlHandler` (`src/Access/…`). Overrides only
`checkCreateAccess()`: returns `AccessResult::forbidden()` when `$entity_bundle` is the base
`paragraph_block` bundle ("not meant to be used outside a paragraph block context"); everything else
defers to `parent`. It only **tightens** access — view/update/delete keep core block-content
semantics, and the paragraph is a composite child of the block, so viewing the block is the gate for
its paragraph.

## Event subscribers

- **`ControllerAlterSubscriber`** (`KernelEvents::VIEW`, priority 50, needs `layout_builder`):
  on route `layout_builder.choose_inline_block`, walks `$build['links']['#links']` and unsets any
  whose plugin id contains `paragraph_block`, hiding the **internal** bundle from the raw inline-block
  chooser (the fake per-type bundles still appear).
- **`ConfigSubscriber`** (`ConfigEvents::SAVE`, priority 300): on every config save, scans the
  config's `dependencies.config`; any `block_content.type.<bundle>` where `<bundle>` is a
  paragraph-block key is **rewritten to `paragraphs.paragraphs_type.<bundle>`**, and the module
  dependencies are deduped to include `paragraph_block` + `paragraphs`. This stops the synthetic
  bundles from leaking into exported config as non-existent block-content-type dependencies.

## Storage config

The bundle/field are shipped in `config/optional/` (see `config/settings.md`): a single
`entity_reference_revisions` field to one `paragraph`, cardinality 1, rendered on the default view
display via `entity_reference_revisions_entity_view`. No config schema is defined by the module.
