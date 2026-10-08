<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Create Content with Category (createcontentwithcategory) — agent index
**Block of links that open the node-add form with a taxonomy term pre-populated.**

- **Version:** 1.0.x (1.0.0-alpha3)  •  **Core:** ^8 || ^9 || ^10 || ^11  •  **Package:** Taxonomy
- **Requires:** `prepopulate:prepopulate` (contrib) — seeds the field value from the URL query
- **Config route:** `createcontentwithcategory.config` at `/admin/config/content/createcontentwithcategory` (permission `administer taxonomy`), form `Form\CcwcSettings`
- **Config object:** `createcontentwithcategory.settings` key `target_nodes_fields` = list of `content_type__field_name` ids (no config schema shipped)
- **Block:** `createcontentwithcategory_block` (`Plugin\Block\CreateContentWithCategoryBlock`) with deriver `Plugin\Derivative\CreateContentWithCategoryBlock` — one derivative per configured target
- **Class:** `Ccwc` (`src/Ccwc.php`) — parses the id, loads the field's target-bundle terms, builds a themed `menu__…` render array whose links point to `node.add` with Prepopulate query key `edit[<field>][widget]=<tid>`
- **Hook:** `createcontentwithcategory_target_nodes_fields()` in `.module` reads config and returns one `Ccwc` per id

## Solution docs
- **Configuration, the block/deriver, the `Ccwc` build pipeline, and how the Prepopulate link is formed** → [config/settings.md](config/settings.md)

## What it is (from source)
Editors pick "content type + taxonomy-reference field" combinations on the settings form. For each combination the module exposes a block of links — one per term in the referenced vocabularies — and each link opens the standard node-add form for that content type with the chosen term pre-selected in the reference field. No custom content-creation endpoint: the links use core `node.add`, so normal `create <content_type>` access applies at click time. Configuration is gated by `administer taxonomy`.
