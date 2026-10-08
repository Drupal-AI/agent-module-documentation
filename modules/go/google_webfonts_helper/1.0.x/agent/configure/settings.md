<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings — where font files are written (`fonts_path`)

Config object `google_webfonts_helper.settings`, one key.

| Key | Type | Default | Meaning |
|---|---|---|---|
| `fonts_path` | string | `public://google-webfonts-helper` | Base stream-wrapper directory; each font goes in `<fonts_path>/<entity_id>/` |

- **Form:** `Drupal\google_webfonts_helper\Form\SettingsForm`
  (`ConfigFormBase`, form id `google_webfonts_helper_settings`).
- **Route:** `google_webfonts_herlper.settings` (id is misspelled `herlper` in the module) →
  `/admin/config/system/google-webfonts-helper/settings`, permission
  `administer google_webfonts_helper`. Reachable as the "Settings" secondary tab on the font
  collection page.
- **Validation:** the entered value's scheme must be a valid registered stream wrapper
  (`StreamWrapperManager::isValidScheme`); otherwise "You have entered an invalid scheme."
  The form description notes the path "must be accessible from internet" — use a public
  scheme (`public://`) so the served fonts are web-reachable.
- **Schema:** `config/schema/google_webfonts_helper.schema.yml` →
  `google_webfonts_helper.settings` (`config_object`, `fonts_path: string`).

Set via drush / PHP:

```bash
drush config:set google_webfonts_helper.settings fonts_path 'public://fonts' -y
```

```php
\Drupal::configFactory()->getEditable('google_webfonts_helper.settings')
  ->set('fonts_path', 'public://fonts')->save();
```

Changing `fonts_path` does not move already-downloaded files; re-save each font (or rebuild
libraries) to re-download into the new location. The temporary download staging directory
(`temporary://google-webfonts-helper`) is fixed and not configurable.
