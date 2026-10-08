# SimpleCron plugin type

Simple Cron defines one plugin type, **`SimpleCron`**, which is how you declare cron work.

- Annotation: `@SimpleCron` — `Drupal\simple_cron\Annotation\SimpleCron` with `id` (string),
  `label` (`@Translation`), and optional `weight` (int, default `0`).
- Manager service: `plugin.manager.simple_cron` → `Drupal\simple_cron\Plugin\SimpleCronPluginManager`
  (extends `DefaultPluginManager`). Discovery directory `Plugin/SimpleCron`, interface
  `SimpleCronPluginInterface`, cache bin key `simple_cron_plugins`.
- Alter hook: `hook_simple_cron_info(&$definitions)` (alter id `simple_cron_info`) to alter/remove
  discovered plugin definitions.
- Base class: `Drupal\simple_cron\Plugin\SimpleCronPluginBase` (implements
  `SimpleCronPluginInterface` + `ContainerFactoryPluginInterface`, so you may add a `create()` for DI).

## Minimal plugin

```php
namespace Drupal\my_module\Plugin\SimpleCron;

use Drupal\simple_cron\Plugin\SimpleCronPluginBase;

/**
 * @SimpleCron(
 *   id = "my_cron_job",
 *   label = @Translation("My cron job"),
 *   weight = 0
 * )
 */
class MyCronJob extends SimpleCronPluginBase {

  public function process(): void {
    // Do the work. Runs on schedule from the default cron run.
  }
}
```

Place it in `my_module/src/Plugin/SimpleCron/`, then clear cache. `CronJobManager::updateList()`
(fired on module install/uninstall/rebuild and settings save) creates a `simple_cron_job` entity for
it, defaulting to crontab `*/15 * * * *`, enabled, weight from the annotation.

## Interface surface (`SimpleCronPluginInterface`)

Required: `process(): void`. Provided by the base class (override as needed):

| Method | Purpose |
|---|---|
| `getTypeDefinitions(): array` | Return one job per key to spawn **multiple** jobs from one plugin (see below). Default returns a single `default` type. |
| `getType(): string` | The current job's type key (from the entity). |
| `defaultConfiguration(): array` | Default per-job configuration. |
| `buildConfigurationForm()/validateConfigurationForm()/submitConfigurationForm()` | Add per-job settings to the job edit form (`PluginFormInterface`). |
| `getConfiguration()/setConfiguration()` | Config accessors (`ConfigurableInterface`); base merges with defaults. |
| `getCronJob()/setCronJob()` | The backing `CronJob` entity; `getConfigValue($key)` reads one config value. |
| `id()/label()` | Plugin id and (type-aware) label. |

## Multiple jobs from one plugin

Override `getTypeDefinitions()` to return an array keyed by type; each key becomes a separate job
`<plugin_id>.<type>` with its own crontab/config. Example (from `simple_cron_examples`,
`MultiTypesCron`, id `example_simple_cron_multi_types`):

```php
public function getTypeDefinitions(): array {
  return [
    'first'  => ['label' => $this->t('First')],
    'second' => ['label' => $this->t('Second (run fail)')],
  ];
}
```

A type definition may also carry `provider` and `configuration` keys, which seed the created job.

## Built-in plugins

| id | Class | Behavior |
|---|---|---|
| `cron` | `Plugin/SimpleCron/Cron` | When `cron.override_enabled` is TRUE, `getTypeDefinitions()` returns one type per module implementing `hook_cron` → jobs `cron.<module>`; `process()` invokes that module's `hook_cron`. |
| `queue` | `Plugin/SimpleCron/Queue` (weight 100) | When `queue.override_enabled` is TRUE, returns one type per cron-enabled queue worker → jobs `queue.<worker>`; adds a **Cron time** config field (`time`, default 15, 1–3600 s); `process()` claims and processes queue items until the time budget elapses, handling `DelayedRequeue`/`Requeue`/`SuspendQueue` exceptions. |

## Examples submodule

`simple_cron_examples` (`modules/simple_cron_examples/`, depends on `simple_cron`) ships copy-ready
plugins: `example_simple_cron_single` (bare `process()`), `example_simple_cron_configurable`
(`module_name` select via `buildConfigurationForm()` + `defaultConfiguration()`), and
`example_simple_cron_multi_types` (two types, the `second` one throws to demonstrate failure logging).
