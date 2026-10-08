<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Block Description Modifier (block_description_modifier) — agent index

Controls the **"Block description (info)"** field (`block_content.info`) of Custom Blocks. Per block
type you can **auto-fill and hide** that field — both when the block is a **Layout Builder inline
block** and on the **regular block_content add/edit form**. The stored value comes from one of three
pluggable strategies (fixed string / bundle label / a text field on the block), normalized to plain
text ≤ 60 chars. Package `Contrib`. Core `^11`. License GPL-2.0-or-later. Version 1.1.0.

Depends on core **`block_content`**, **`layout_builder`**, and contrib **`inline_entity_form`**
(hard dependency in info.yml; composer.json only *suggests* it).

- **Admin UI, routes, permission, the `bdm_bundle` config entity, config schema, the 1.1.0
  migration** → [config/settings.md](config/settings.md)
- **How the info value is computed and enforced: label-provider strategies, the applier/handler
  services, hooks, and the normalizer** → [api/label-providers.md](api/label-providers.md)

## What it actually is

- **One config entity type** `bdm_bundle` (`src/Entity/BundleConfig.php`, `config_prefix = "bundle"`,
  `admin_permission = "administer block description modifier"`). One entity per block_content bundle,
  holding two sub-arrays: `inline_bundle` and `content_bundle`, each `{enabled, provider,
  string_value, field_name}`. Read/written through `BundleConfigRepository`.
- **One permission**: `administer block description modifier` (gates all four routes).
- **Four routes** under `/admin/config/content/block-description-modifier` (overview controller +
  two config forms + a delete confirm form).
- **Nine services** (`*.services.yml`): a repository, a normalizer helper, a label-provider manager
  with three tagged providers (`string`, `content_block_label`, `field`), a text-field options
  provider, and four appliers/handlers that enforce the value across the different form/save paths.
- **No Drush, no Drupal plugin type** (label providers are plain tagged services, not annotated
  plugins), no external API, no library dependency beyond an admin CSS asset.

## Mechanism (from source, `.module`)

- `hook_form_layout_builder_add_block_alter` / `..._update_block_alter` → `LayoutBuilderFormAlter`
  hides admin label / title / display-title inputs and injects the enforced value; adds a validate
  handler.
- `hook_entity_presave` on `block_content` → `BlockContentInfoApplier` sets `info` on save (content
  rules take precedence, else inline rules).
- `hook_form_block_content_form_alter` hides the `info` element for content-configured bundles.
- `hook_inline_entity_form_entity_form_alter` → `InlineEntityFormContentInfoSyncer` applies content
  rules to block_content inside IEF subforms via an `#entity_builders` callback.

## Security-relevant facts (all benign)

- Every route requires `administer block description modifier`; the delete form is a
  `ConfirmFormBase`; config forms are token-protected `FormBase`. No `_access: TRUE`, no
  `access content`, no GET mutations.
- The computed `info` is run through `InfoValueNormalizer` (`strip_tags`, control-char strip,
  whitespace collapse, 60-char cap); overview/table summaries render through `t()` placeholders
  (auto-escaped). No external calls, no SSRF/SQLi surface.
