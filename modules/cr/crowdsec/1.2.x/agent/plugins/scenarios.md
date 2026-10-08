<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `crowdsec_scenario` plugin type (ban plugins)

CrowdSec defines a plugin type for "scenarios" — local bad-behaviour detectors that ban IPs and can
signal upstream.

- **Manager:** `Drupal\crowdsec\ScenarioPluginManager` (service `plugin.manager.crowdsec_scenario`),
  a `DefaultPluginManager` implementing `FallbackPluginManagerInterface` (fallback id: `whisper`).
- **Discovery dir:** `src/Plugin/CrowdsecScenario/`.
- **Attribute:** `Drupal\crowdsec\Attribute\Scenario` (`#[Scenario(...)]`).
- **Interface / base:** `ScenarioInterface` / `ScenarioPluginBase`.
- **Alter:** `hook_crowdsec_scenario_info_alter()`; cache key `crowdsec_scenario_plugins`.

## The three built-in plugins

| id | CrowdSec scenario | Label | Buffered | Detects |
|---|---|---|---|---|
| `flood` | `drupal/auth-bruteforce` | Flood control bans | no | IPs hitting Drupal flood control (e.g. failed logins) |
| `core-ban` | `drupal/core-ban` | Administrator bans | no | IPs banned via core Ban / Advanced Ban |
| `whisper` | `drupal/4xx-scan` | 4xx response bans | **yes** | IPs causing many 4xx responses in a window |

Only buffered plugins use `leak_speed` (time window) + `bucket_capacity` (threshold); `whisper` is the
only buffered one and is the fallback plugin.

## Scenario attribute parameters

```php
#[Scenario(
  id: 'flood',                       // must equal the group or be prefixed "group:sub"
  scenario: 'drupal/auth-bruteforce',// the CrowdSec scenario name
  label: new TranslatableMarkup('Flood control bans'),
  description: new TranslatableMarkup('...'),
  buffer: FALSE,                     // TRUE => signals are batched via the Buffer service
)]
```

## Writing a custom scenario plugin

Create `my_module/src/Plugin/CrowdsecScenario/Something.php`:

```php
namespace Drupal\my_module\Plugin\CrowdsecScenario;

use Drupal\Core\StringTranslation\TranslatableMarkup;
use Drupal\crowdsec\Attribute\Scenario;
use Drupal\crowdsec\ScenarioPluginBase;

#[Scenario(
  id: 'my_scenario',
  scenario: 'my_org/my-detection',
  label: new TranslatableMarkup('My detection'),
  description: new TranslatableMarkup('Bans IPs doing X.'),
  buffer: TRUE,
)]
final class Something extends ScenarioPluginBase {}
```

Then emit a signal from your detection code:

```php
\Drupal\crowdsec\ScenarioPluginManager::getPlugin('my_scenario')->addSignal($ip, $statusCode, $targetUser);
```

`addSignal()` respects the plugin's `enable` setting; buffered plugins go through `crowdsec.buffer`,
non-buffered ones signal immediately. Settings for your plugin are auto-added to `crowdsec.settings`
under `plugins.<id>` (schema via `CrowdsecHooks::configSchemaInfoAlter`), and it appears in the config
form and the `signal_scenarios` options automatically.

## Base-class helpers (`ScenarioPluginBase` / `ScenarioInterface`)

- `label(): string`, `getSetting($key)` (enable|leak_speed|bucket_capacity|ban_duration),
  `getSettingKey($key)` → `plugins.<id>.<key>`, `getStorageKey($ip, $key)`.
- `addSignal(string $ip, int $status, ?string $targetUser = NULL): void`.
