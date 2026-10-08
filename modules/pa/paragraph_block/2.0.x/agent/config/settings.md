<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Enabling and operating paragraph blocks

## Install & enable

```bash
composer require drupal/paragraph_block
drush en paragraph_block -y
```

Pulls in contrib **paragraphs**, **form_decorator**, **block_form_alter** and core
**block_content**. Enable **layout_builder** too if you want the blocks in Layout Builder.
`hook_install` (`paragraph_block.install`) sets the module weight to **20** so it always sorts
after `content_translation` (weight 10). There is **no settings route** (`configure: null`) and
**no permissions** — the module has no admin form of its own.

## Turn a paragraph type into a block

1. Go to **Structure → Paragraphs types** (`/admin/structure/paragraphs_type`), add or edit a type.
2. Open the **"Paragraph block settings"** details section and tick **Enable**.
3. Save. That paragraph type is now offered as a block at **`/block/add`** and in Layout Builder's
   *Add block* / inline-block chooser, labelled with the paragraph type's own label.

The checkbox is added by the Form Decorator plugin
`src/FormDecorator/ParagraphsTypeFormAlter.php`. Its `applies()` matches the
`paragraphs_type_edit_form`/`paragraphs_type_add_form`. `buildForm()` renders a `details` element
`paragraph_block_settings` (open when already enabled) containing the `status` checkbox bound to
`$paragraphs_type->getThirdPartySetting('paragraph_block', 'status')`. `save()` writes every
`paragraph_block_settings` value back with `setThirdPartySetting('paragraph_block', $key, …)` before
calling the inner form's `save()`.

So the on/off state lives as a **third-party setting on the paragraphs type config entity**, e.g.:

```yaml
# paragraphs.paragraphs_type.my_component
third_party_settings:
  paragraph_block:
    status: true
```

`ParagraphBlockService::getParagraphBlockTypes()` /
`getParagraphBlockTypeKeys()` (`src/ParagraphBlockService.php`) load all `paragraphs_type`
entities and return only those whose `paragraph_block.status` setting is truthy — this list drives
the whole feature.

## What ships as config

The bundle and field are installed once from `config/optional/` (created only if paragraphs is
present):

| Config object | Purpose |
|---|---|
| `block_content.type.paragraph_block` | The single storage bundle "Paragraph block". |
| `field.storage.block_content.field_paragraph_block_paragraph` | `entity_reference_revisions` storage, target_type `paragraph`, **cardinality 1**, translatable. |
| `field.field.block_content.paragraph_block.field_paragraph_block_paragraph` | Field instance, handler `default:paragraph`. |
| `core.entity_form_display.block_content.paragraph_block.default` | Paragraphs widget (edit_mode open, features collapse_edit_all + duplicate) + `info` + `langcode`. |
| `core.entity_view_display.block_content.paragraph_block.default` | Renders the field with `entity_reference_revisions_entity_view` (view_mode default, label hidden). |

You normally never edit these. Every opted-in paragraph type reuses this one bundle and field;
the paragraph type is chosen at block-creation time, not by adding more block bundles.

## Editor UX cleanups

- `block_type_form_alter` (in `Hook/ParagraphBlockHooks`) attaches
  `ParagraphBlockService::elementAfterBuild` as an `#after_build` on the paragraph widget for the
  `paragraph_block` bundle, stripping the widget's remove/collapse buttons, the type label and the
  header actions so an editor sees a single embedded paragraph, not the full multi-value UI.
- `form_language_content_settings_form_alter` removes the fake `block_content` bundles from the
  **content-language settings** form so their translation config follows the paragraph type instead
  of being set separately.
- Standalone creation of the base `paragraph_block` bundle is **forbidden** (access handler), so
  editors cannot add an "empty" paragraph block outside the paragraph-type flow.

## Layout Builder migration (update hooks)

`paragraph_block.install` provides batch update hooks for sites coming from an older release that
used a custom `paragraph_block` layout plugin:

- `paragraph_block_update_10000` rewrites layout-override components whose plugin id was
  `paragraph_block:*` to `inline_block:paragraph_block`.
- `paragraph_block_update_10001` backfills `inline_block.usage` records for those blocks.
- `paragraph_block_update_10002` re-asserts the module weight of 20.

Run `drush updatedb` after upgrading. (Note: the `hook_install` in the file is named
`paragraph_block_name_install`; the weight is also enforced by update 10002.)
