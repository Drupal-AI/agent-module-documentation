<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Iplicit API — connection configuration

1. `drush en iplicit_api` (pulls in Key).
2. Create a Key at `/admin/config/system/keys` holding the Iplicit API key. Use the **Environment variable** or **File** provider so the secret never enters the database/config.
3. Configure `/admin/config/services/iplicit` (permission `administer iplicit api`): base URI, domain (e.g. `sandbox.demo`), username, the key created above, timeout (default 30s), `enabled`, `debug`.
4. Press **Test connection**.

Config object `iplicit_api.settings` stores `base_uri`, `domain`, `username`, `api_key` (the key **ID**, not the secret), `timeout`, `enabled`, `debug`. Per-environment override in settings.php:

```php
$config['iplicit_api.settings']['domain'] = 'live.acme';
```

`CredentialProvider::isConfigured()` returns FALSE (and every request refuses) when `enabled === FALSE` or any required field/secret is missing.
