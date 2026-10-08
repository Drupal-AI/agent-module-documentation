<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & install — asymmetric_menu_trees

## Enable
`drush en asymmetric_menu_trees -y`. No declared dependencies, but it is only useful on a
**multilingual** site (`language` + content translation) with **`menu_link_content`** menu links.

`hook_install()` (`asymmetric_menu_trees.install`) rewrites the `menu_tree` table: every row whose
`class` is core's `Drupal\menu_link_content\Plugin\Menu\MenuLinkContent` is set to
`Drupal\asymmetric_menu_trees\Plugin\Menu\AsymmetricMenuLinkContent`. `hook_update_8101()` does the
same on update. `hook_uninstall()` reverts the class column back to core's and deletes the config
object.

## Config form
- Route `asymmetric_menu_trees.asymmetric_menu_trees_config_form` →
  `/admin/config/asymmetric_menu_trees`, permission **`administer site configuration`**,
  `_admin_route: TRUE`. Menu link (`*.links.menu.yml`) sits under
  `system.admin_config_regional` (*Configuration → Regional and language*), weight 99.
- Form class `AsymmetricMenuTreesConfigForm` extends `ConfigFormBase`; form id
  `asymmetric_menu_trees_config_form`; editable config `asymmetric_menu_trees.settings`.

### The `multilingual` setting (a `checkboxes` element)
Config object **`asymmetric_menu_trees.settings`**, key `multilingual`. Install default
(`config/install/asymmetric_menu_trees.settings.yml`) enables all three:

```yaml
multilingual:
  link: link
  order: order
  enabled: enabled
```

Each ticked box tells `hook_entity_base_field_info_alter()` (in `.module`) to mark
`menu_link_content` base fields **translatable**:

| Box       | Label in form                                              | Fields made translatable |
|-----------|------------------------------------------------------------|--------------------------|
| `link`    | Different url for a link for different languages           | `link`                   |
| `order`   | Different ordering of links in menu tree for different languages | `weight`, `parent`  |
| `enabled` | Menu links enabled for some languages and disabled for others   | `enabled`           |

Note the `order` box governs **both** `weight` and `parent` (so re-parenting per language is part of
"ordering"). An unchecked/`0` value leaves that field non-translatable (a value is treated as off
when empty or `=== 0`).

`submitForm()` saves the value and calls `drupal_flush_all_caches()`, so field-translatability and
menu changes take effect immediately (a full cache flush on every save — expected, not incremental).

**No `config/schema/`** ships (`provides_config_schema: false`); the config is a simple map of
checkbox values.

## Operating notes
- After ticking boxes, make sure the affected menu-link fields are actually translated for each
  language (the module exposes translatability; editors must fill in the per-language values).
- The value is only realised if per-language structures are curated — an untranslated target is the
  failure this module exists to prevent.
