# Permissions

Defined in `layout_builder_quick_add.permissions.yml`.

| Permission | Title | `restrict access` | Gates |
|------------|-------|-------------------|-------|
| `administer layout_builder_quick_add configuration` | Administer layout_builder_quick_add configuration | `true` | The settings form route `layout_builder_quick_add.quick_add_config_form` (`/admin/config/content/layout_builder_quick_add`). |

The permission is marked `restrict access: true`, and its description warns to give it to trusted
roles only.

The block-listing AJAX routes (`layout_builder_quick_add.add_blocks`,
`layout_builder_quick_add.cancel_add_blocks`) do NOT use this permission — they are gated by
`_layout_builder_access: 'view'` (Layout Builder's own access check on the section storage), the
same requirement core uses for its add-block/choose-block routes. Grant/check example:

```php
$account->hasPermission('administer layout_builder_quick_add configuration');
```
