<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings, permission & status block

## Settings form

Form `\Drupal\mobile_detect\Form\MobileDetectSettingsForm`, route `mobile_detect.settings`
→ `/admin/config/user-interface/mobile-detect` (menu under *Configuration → User interface*).
Config object **`mobile_detect.settings`** (schema type `config_object`):

| Key | Type | Meaning |
|---|---|---|
| `mobile_detect_is_mobile` | boolean | **Experimental.** When TRUE, adds the `mobile_detect_is_mobile` page cache context site-wide so every page is cached per is-mobile state. Off by default. |

Set with drush:
```bash
drush config:set mobile_detect.settings mobile_detect_is_mobile true -y
drush config:get mobile_detect.settings
```

## Permission

`administer mobile_detect configuration` — gates the settings form (`_permission` on the
route). Only permission the module defines.

## Status block

Block plugin id **`mobile_detect_status_block`** (`admin_label` "Mobile Detect Status"),
rendered via theme hook `mobile_detect_status_block` (template
`templates/mobile-detect-status-block.html.twig`, variable `version`). Place it from
*Block layout* to confirm detection / see the active Mobile_Detect library version. It has no
settings of its own; scope it with the visibility conditions in
[../plugins/conditions.md](../plugins/conditions.md).
