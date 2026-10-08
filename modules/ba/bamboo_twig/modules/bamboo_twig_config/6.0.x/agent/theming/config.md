<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config / Settings / State getters

Class `Config`, service `bamboo_twig_config.twig.config`.

- `bamboo_config_get(name, key)` → `\Drupal::config(name)->get(key)`. Reads Config API.
  ```twig
  {{ bamboo_config_get('system.site', 'name') }}      {# site name #}
  {{ bamboo_config_get('system.site', 'slogan') }}
  {{ bamboo_config_get('user.settings', 'register') }}
  ```
- `bamboo_settings_get(key)` → `Settings::get(key)` from `settings.php` (e.g. `hash_salt`, custom keys).
  ```twig
  {{ bamboo_settings_get('my_custom_setting') }}
  ```
- `bamboo_state_get(key)` → `\Drupal::state()->get(key)`. Reads the State API (mutable runtime values).
  ```twig
  {{ bamboo_state_get('system.cron_last') }}
  ```

Each returns `null` when the value is absent. `config_get` takes **two** arguments (object name,
then key); the other two take a single key.
