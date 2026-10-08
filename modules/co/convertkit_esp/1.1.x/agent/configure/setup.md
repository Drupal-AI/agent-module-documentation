<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring ConvertKit ESP

Config form: `/admin/config/services/convertkit` (permission `administer convertkit configuration`).

The form (`ConvertkitConfig`) manages three config objects: `convertkit_esp.config`, `convertkit_esp.pkce`, `convertkit_esp.tokens`. It detects whether application settings come from `settings.php` or config and recommends the settings.php approach:

```php
$settings['convertkit_esp'] = [
  'client_id' => 'your_apikey',
  'client_secret' => 'your_clientsecret',
  'tag_ids' => 'your_tag_id',
];
```

If found in settings.php the form switches to read-only guidance; otherwise values are stored in config (less secure — surfaced by a warning in the UI). Configure the tag id(s) applied when subscribing, then embed forms via the ConvertKit blocks/field or attach the Webform handler to a webform to push submissions to ConvertKit.
