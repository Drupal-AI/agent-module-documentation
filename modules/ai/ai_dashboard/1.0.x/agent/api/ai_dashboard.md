<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Dashboard — API (services)

## `ai_dashboard.setup_status` — is a provider's key configured?

Service id **`ai_dashboard.setup_status`** → `Drupal\ai_dashboard\AiSetupStatus`
(interface `AiSetupStatusInterface`). One method:

```php
/** @return string  One of: 'yes', 'no', 'not-available'. */
public function getProviderSetupStatus(string $provider_name): string;
```

```php
$status = \Drupal::service('ai_dashboard.setup_status')
  ->getProviderSetupStatus('openai');   // 'yes' | 'no' | 'not-available'
if ($status !== 'yes') {
  // provider plugin exists but has no API key wired up yet.
}
```

How it decides (see `src/AiSetupStatus.php`):

1. Loads the AI provider plugin definition + instance from `ai.provider`
   (`AiProviderPluginManager`).
2. Calls the provider's `getSetupData()` and reads `key_config_name` (the config property that
   holds the key's machine name).
3. Loads `{provider_module}.settings` (e.g. `ai_provider_openai.settings`):
   - config object is new/absent → **`no`** (never configured);
   - `key_config_name` value is empty → **`no`**;
   - value present → **`yes`**.
4. Any `PluginException`, or a provider whose `getSetupData()` omits `key_config_name`, →
   **`not-available`** (status can't be determined). The return is intentionally a **string
   enum, not a bool**, for that third state.

Used internally by `SetupAiProviderForm` to grey out already-configured providers and by the
`ai_operations_status` block. Constructor deps: `@ai.provider`, `@config.factory`,
`@logger.channel.ai_dashboard`.

## Other services (internal)

- `plugin.manager.ai_documentation` — the documentation-link plugin manager (see
  [../plugins/ai_dashboard.md](../plugins/ai_dashboard.md)).
- `ai_dashboard.route_subscriber` — event subscriber that overrides `ai.settings.menu`.
- `Drupal\ai_dashboard\Hook\AiDashboardHooks` — autowired hook object (`hook_theme`).

No Drush commands, no permissions, no public hooks (`*.api.php`) are defined by this module.
