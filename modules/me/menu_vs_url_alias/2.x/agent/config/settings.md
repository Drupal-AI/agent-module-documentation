<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — menu_vs_url_alias.settings

## Install / enable
- `composer require drupal/menu_vs_url_alias` then `drush en menu_vs_url_alias -y`.
- Requires `pathauto` (declared in `menu_vs_url_alias.info.yml` as `pathauto:pathauto`); Pathauto is enabled as a dependency.
- No settings route or menu link is provided (`configure` is unset). There is no admin form of the module's own — configuration happens on the core content-type edit form.

## The config object
- Object name: `menu_vs_url_alias.settings`.
- Shipped default (`config/install/menu_vs_url_alias.settings.yml`):
  ```yaml
  enabled_content_types:
    - page
  ```
- `enabled_content_types` is an array of content-type machine names for which the either/or menu-vs-alias behavior is active. On a fresh install `page` is governed by default.
- **No config schema is shipped** (`config/schema/` does not exist), so this object is not validated by core's typed-config and won't appear in schema-checked config tooling. `data.json` reflects `provides_config_schema: false`.
- `menu_vs_url_alias_uninstall()` (`menu_vs_url_alias.install`) deletes this object on uninstall.

## How the enable list is populated
There is no direct settings form. The list is edited through the content-type edit form (`/admin/structure/types/manage/{type}`), which requires the core `administer content types` permission:
- `menu_vs_url_alias_form_alter()` adds a `details` element "Menu vs. URL Alias Settings" (group `additional_settings`) containing a single checkbox "Enable Menu vs. URL Alias functionality". Its default value is `in_array($content_type, $enabled_content_types)`.
- The custom submit handler `_menu_vs_url_alias_submit()` reads the current `enabled_content_types`, then adds the content type when the box is ticked and it is not already present, or removes it (`unset`) when unticked and present, and saves via `\Drupal::service('config.factory')->getEditable('menu_vs_url_alias.settings')`.

## Operate it via config
- Programmatically: `\Drupal::configFactory()->getEditable('menu_vs_url_alias.settings')->set('enabled_content_types', ['page','landing_page'])->save();`
- Via Drush: `drush config:set menu_vs_url_alias.settings enabled_content_types.1 landing_page -y` (append), or edit with `drush config:edit menu_vs_url_alias.settings`.
- Removing a content type from the array turns the feature off for that bundle without uninstalling the module.
