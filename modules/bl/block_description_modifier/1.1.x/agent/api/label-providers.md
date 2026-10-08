<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# How the info value is computed and enforced

The stored value for `block_content.info` is produced by a **label-provider strategy** and enforced
by several **applier/handler services**, each covering a different form or save path. All computed
values pass through `InfoValueNormalizer`.

## Label providers (strategy, tagged services)

Interface `Provider\LabelProvider\LabelProviderInterface`: `id()`, `label()`,
`provide(BlockContentInterface $block, string $bundle, array $bundleConfig): string`.
NOT a Drupal plugin type — providers are plain services tagged
`block_description_modifier.label_provider` and collected by `LabelProviderManager` (constructed with
a `!tagged_iterator`). To add a strategy, register a service with that tag.

`LabelProviderManager::provide($id, ...)` dispatches by id; an unknown id returns the literal
`'corrupted provider'` (defensive, never throws). `providerOptions()` gives `[id => label]` for the
forms.

Three shipped providers:

- **`string`** (`StringLabelProvider`) — returns `bundleConfig['string_value']`; empty → the fallback
  constant `'corrupted field'`.
- **`content_block_label`** (`ContentBlockLabelProvider`) — loads the `block_content_type` entity for
  the bundle and returns its label; missing type → `'corrupted field'`. This is the default provider
  whenever config has an empty provider string.
- **`field`** (`FieldLabelProvider`) — copies the first non-empty text value of the configured
  `field_name` from the block. Supported field types: `string`, `string_long`, `text`, `text_long`,
  `text_with_summary` (`FieldLabelProvider::supportedFieldTypes()`). Missing/empty field → the
  fallback. Reads `$item->value` (raw stored text) then `getString()`.

`FALLBACK_CORRUPTED_FIELD = 'corrupted field'` is defined on
`Service\InlineBlockLabelApplier` and reused everywhere.

## Which fields the "field" option offers (`Provider\TextFieldOptionsProvider`)

`getBlockContentTextFieldOptions($bundle)` walks `entity_field.manager` field definitions for
`block_content:<bundle>`, excludes `info`, `revision_log`, `revision_log_message`, keeps only the
supported text types, and drops read-only / computed fields. Empty result → the forms hide the
`field` provider option entirely.

## Normalizer (`Helper\InfoValueNormalizer`)

`normalize(string $value, int $maxLength = 60)`: `strip_tags()`, replace ASCII control chars with
spaces, trim, collapse runs of whitespace, then UTF-8-safe truncate to `maxLength`. Applied to every
value before it is written to `info` — plain-text, bounded output (defense-in-depth; the `info` field
is plain text and already escaped on render).

## Enforcement paths (services + `.module` hooks)

- **Regular save** — `hook_entity_presave(block_content)` → `BlockContentInfoApplier::apply()`:
  precedence is content-mode first (`ContentBlockInfoApplier::apply()` when
  `content_bundle.enabled`), otherwise inline-mode (`InlineBlockLabelApplier::apply()`). Both compute
  via the provider manager, normalize, and `->set('info', …)` (empty → fallback).
- **block_content add/edit form** — `hook_form_block_content_form_alter` hides `info`
  (`#type=hidden`, injects the fallback as value) for bundles whose content mode is enabled; presave
  then writes the real computed value.
- **Layout Builder add/update block dialog** —
  `hook_form_layout_builder_add_block_alter` / `..._update_block_alter` → `LayoutBuilderFormAlter`:
  resolves the inline bundle (from `settings[block_form][#block]`/`#entity`, or the
  `inline_block:<bundle>` plugin id on the route/form state), and for enabled inline bundles hides &
  force-values `settings[admin_label]`, the nested `block_form[info]`, `settings[label]/[title]`, and
  forces `label_display/display_title/title_display` off. Appends the module's validate handler.
- **Layout Builder submit/validate** — `..._inline_block_submit` / `..._inline_block_validate` →
  `LayoutBuilderInlineBlockSubmitHandler::handle()`: recomputes the label (for `provider=field` it
  reads submitted widget values via `extractSubmittedFieldText()` / a deep `value`-key search, since
  the entity may not yet reflect input), normalizes, and forces `settings[admin_label]`,
  `settings[label]`, `settings[label_display]=0`, plus the embedded block's `info`.
- **Inline Entity Form subforms** — `hook_inline_entity_form_entity_form_alter` →
  `InlineEntityFormContentInfoSyncer::alter()`: for content-enabled bundles it hides the `info`
  element and attaches an `#entity_builders` callback (`applyToEntity()`) so the computed value wins
  *after* IEF finishes building the entity. The `..._info_sync_validate` / `..._info_sync_submit`
  callbacks also delegate to the syncer.

## Notes for extenders

- The fill value is bounded to 60 chars everywhere; if you add a provider, still expect the
  normalizer to trim it.
- To force a label from submitted (not yet saved) field values you generally need the
  Layout-Builder submit handler pattern, not just presave — see `computeLabelFromSubmit()`.
- Deleting a source field or leaving it empty is safe: providers degrade to `'corrupted field'`
  rather than erroring.
