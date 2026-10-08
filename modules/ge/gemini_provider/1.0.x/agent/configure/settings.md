<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings

Config object **`gemini_provider.settings`** (schema in
`config/schema/gemini_provider.schema.yml`). Form
`Drupal\gemini_provider\Form\GeminiConfigForm`, route **`gemini_provider.settings_form`** →
`/admin/config/ai/providers/gemini`, permission **`administer ai providers`** (defined by the
AI module — this module ships no permissions). The menu link sits under the AI providers
listing (`ai.admin_providers`).

## Config keys

| Key | Type | Meaning |
|---|---|---|
| `api_key` | string | The **id of a Key entity** (from the `key` module) holding the Gemini API key. Chosen on the form with a `key_select` widget; default is empty. |
| `safety_settings` | mapping | Per-category content-filter thresholds: `HarmCategory` name → `HarmBlockThreshold` value. |

### `api_key` — it is a Key reference, not the secret itself

The form stores the **Key entity machine name**, not the raw key. Create a Key first
(`/admin/config/system/keys`) — commonly an *Authentication* key using the **env** provider so
the secret lives in an environment variable — then select it here. At request time the AI base
provider resolves this Key to the real value (`getSetupData()` maps
`key_config_name => 'api_key'`; the provider calls `loadApiKey()` / `setAuthentication()`).

```php
\Drupal::configFactory()->getEditable('gemini_provider.settings')
  ->set('api_key', 'my_gemini_key')   // a key.key.my_gemini_key entity id
  ->save();
```

### `safety_settings`

Each configurable `HarmCategory` (e.g. `HARM_CATEGORY_HARASSMENT`, `HARM_CATEGORY_HATE_SPEECH`,
`HARM_CATEGORY_SEXUALLY_EXPLICIT`, `HARM_CATEGORY_DANGEROUS_CONTENT`) maps to a
`HarmBlockThreshold`: `BLOCK_LOW_AND_ABOVE`, `BLOCK_MEDIUM_AND_ABOVE`, `BLOCK_ONLY_HIGH`,
`BLOCK_NONE`, `OFF` (empty = not configured). Applied to each generative request by
`applySafetySettings()`.

```php
\Drupal::configFactory()->getEditable('gemini_provider.settings')
  ->set('safety_settings', ['HARM_CATEGORY_HATE_SPEECH' => 'BLOCK_MEDIUM_AND_ABOVE'])
  ->save();
```

The provider is "usable" only once `api_key` is set (`isUsable()` checks
`getConfig()->get('api_key')`).
