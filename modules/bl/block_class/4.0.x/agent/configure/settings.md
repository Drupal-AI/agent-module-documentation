# Block Class — settings

![Block Class settings form](../../../../../../../screenshots/block_class/4.0.x/settings.png)

Form: `Drupal\block_class\Form\BlockClassSettingsForm` at
`/admin/config/content/block-class/settings` (route `block_class.settings`).
Config object: `block_class.settings` (schema in `config/schema/block_class.schema.yml`).

Keys (defaults from `config/install/block_class.settings.yml`):

| Key | Default | Purpose |
|---|---|---|
| `field_type` | `multiple_textfields` | Single field vs. multiple textfields for entering classes |
| `default_case` | `standard` | Case handling for identifiers (e.g. lowercase) |
| `enable_attributes` | `TRUE` | Allow arbitrary HTML attributes on blocks |
| `enable_auto_complete` | `TRUE` | Autocomplete previously used class/attribute names |
| `enable_id_replacement` | `TRUE` | Allow replacing the block's default HTML `id` |
| `enable_special_chars` | `FALSE` | Permit special characters in class names |
| `filter_html_clean_css_identifier` | `''` | Characters passed to CSS identifier cleaning |
| `qty_classes_per_block` | `10` | Max classes per block |
| `qty_attributes_per_block` | `10` | Max attributes per block |
| `items_per_page` | `50` | Pagination on admin list pages |
| `maxlength_block_class_field` | `255` | Max length of the class field |
| `maxlength_attributes` | `255` | Max length of attribute values |
| `maxlength_id` | `255` | Max length of the ID field |
| `weight_class` / `weight_id` / `weight_attributes` | `0` | Field weights on the block form |
| `block_classes_stored` | `{}` | Internal store of known classes (feeds autocomplete) |

Per-block: the class/ID/attribute fields are injected into the standard block config
form (`hook_form_block_form_alter`) and saved on block presave.
