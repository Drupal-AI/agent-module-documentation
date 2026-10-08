<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure a "Not" block visibility condition

The module has **no admin settings page** (`configure: null`). Conditions are configured per block.

## Via the UI
1. Enable the parent module plus the submodule(s) providing the conditions you need
   (`drush en block_visibility_conditions block_visibility_conditions_node -y`).
2. Go to **Admin → Structure → Block layout** (`/admin/structure/block`), then **Configure** an
   existing block or **Place block** in a region. (For Layout Builder, use the block's **Configure**
   form in the layout.)
3. In the **Visibility** tab, open the condition tab for e.g. **Not Node Type** and check the
   bundles the block should be hidden on. The condition has **no "Negate the condition" checkbox**
   (it is removed by the base class).
4. Save the block.

Behavior: with bundles checked, the block is hidden **only** on those bundles' pages and shown on
all other pages. With **no** bundles checked, the condition always passes (block shown).

## Config storage
Selections are stored in the block config entity under `visibility.<condition_id>`, e.g. for a
block config `block.block.<id>.yml`:

```yaml
visibility:
  not_node_type:
    id: not_node_type
    bundles:
      article: article
      page: page
    negate: false
```

Condition ids: `not_node_type`, `not_taxonomy_vocabulary`, `not_product_type`. The `bundles` key
holds the machine names to hide on; `negate` is always false. Export with the standard config
workflow (`drush config:export`) to deploy across environments.
