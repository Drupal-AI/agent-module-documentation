<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings and enabling the resource

## Config object `rest_menu_items.config`

Plain config (read/written through `\Drupal::configFactory()`), edited at
`/admin/config/services/rest_menu_items` (route `rest_menu_items.config_form`, permission
`administer rest menu items`). Keys:

| Key | Type | Meaning |
|---|---|---|
| `output_values` | map | Which fields appear per menu item. Shipped default enables `key`, `title`, `description`, `uri`, `alias`, `external`, `absolute`, `relative`, `existing`, `weight`, `expanded`, `enabled`, `uuid`, `options`. A checkbox map: value == field name means "output it", `0` means omit. |
| `allowed_menus` | map | Menus exposable over REST. **Empty = all menus allowed.** Checkbox map; a menu whose value is its machine name is allowed, a menu present but set to `0` returns **403**. Access test: `!array_key_exists($menu, $allowed) || in_array($menu, $allowed)`. |
| `base_url` | string | Overrides the domain for `absolute` URL output (decoupled setups). Empty = use the site's own base URL. |
| `add_fragment` | int (bool) | When truthy, append `#fragment` from link options to `alias`/`absolute`/`relative`. Default `1`. |

Read/write examples:

```bash
drush config:get rest_menu_items.config
drush config:set rest_menu_items.config base_url 'https://api.example.com' -y
```

```php
\Drupal::configFactory()->getEditable('rest_menu_items.config')
  ->set('base_url', 'https://api.example.com')
  ->set('allowed_menus', ['footer' => 'footer'])
  ->save();
```

## Enabling the REST resource

The module ships the resource but, like any core REST resource, it must be **enabled** before
it responds:

- Easiest: install **REST UI** (`drupal/restui`) and enable "Menu items per menu" at
  `/admin/config/services/rest`, choosing formats and auth.
- Or via config (a `rest.resource.rest_menu_item` config entity) / programmatically.

Then grant the permission **`restful get rest_menu_item`** to the relevant role
(e.g. anonymous) at `/admin/people/permissions`.
