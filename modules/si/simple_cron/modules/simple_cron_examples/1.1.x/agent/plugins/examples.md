<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# simple_cron_examples — example SimpleCron plugins

This submodule ships three worked examples of the parent's `@SimpleCron` plugin type.
They are **not** a new plugin type — they are concrete plugin classes discovered by the
parent's manager. Enabling `simple_cron_examples` registers these three plugins; each can
then be turned into a cron job at the parent's cron-job UI (`entity.simple_cron.collection`).

All three extend `Drupal\simple_cron\Plugin\SimpleCronPluginBase`, live under
`src/Plugin/SimpleCron/`, and are annotated with `@SimpleCron(id, label)`. The parent
discovers them via manager service `plugin.manager.simple_cron` (discovery dir
`Plugin/SimpleCron`, annotation `Drupal\simple_cron\Annotation\SimpleCron`, alter hook
`simple_cron_info`).

## The three examples

| Plugin id | Class | Demonstrates |
|---|---|---|
| `example_simple_cron_single` | `SingleCron` | Minimal plugin: only `process()`. Logs `Simple cron run successfully` to channel `simple_cron_examples`. |
| `example_simple_cron_configurable` | `ConfigurableCron` | Per-job settings: `defaultConfiguration()`, `buildConfigurationForm()` (a `module_name` select), DI via `create()`, reading a value with `getConfigValue()`. |
| `example_simple_cron_multi_types` | `MultiTypesCron` | One plugin, several parallel jobs: `getTypeDefinitions()` returns `first`/`second`; `process()` branches on `getType()` and deliberately throws for `second` to show error/status reporting. |

## 1. Minimal plugin (`SingleCron`)

The only required override is `process()`. `id`, `label`, config and type handling come from
the base class.

```php
namespace Drupal\my_module\Plugin\SimpleCron;

use Drupal\Core\Logger\LoggerChannelTrait;
use Drupal\simple_cron\Plugin\SimpleCronPluginBase;

/**
 * @SimpleCron(
 *   id = "example_simple_cron_single",
 *   label = @Translation("Example: Single", context = "Simple cron")
 * )
 */
class SingleCron extends SimpleCronPluginBase {
  use LoggerChannelTrait;

  public function process(): void {
    $this->getLogger('simple_cron_examples')->info('Simple cron run successfully');
  }
}
```

## 2. Configurable plugin (`ConfigurableCron`)

Adds a per-job settings form that the parent renders on the cron-job edit form. Pattern:

- `defaultConfiguration(): array` — return default values (`['module_name' => 'simple_cron_examples']`).
- `buildConfigurationForm(array $form, FormStateInterface $form_state): array` — add form
  elements; keyed values are stored on the cron job. (`validateConfigurationForm()` /
  `submitConfigurationForm()` are also available from the base, optional.)
- `create()` — inject services (`module_handler`, `extension.list.module`) since the base's
  `create()` only wires `config.factory`; always call `parent::create(...)` first.
- Read a saved value in `process()` with the protected helper `getConfigValue('module_name')`.

```php
public static function create(ContainerInterface $container, array $configuration, $plugin_id, $plugin_definition) {
  $instance = parent::create($container, $configuration, $plugin_id, $plugin_definition);
  $instance->moduleHandler = $container->get('module_handler');
  $instance->extensionList = $container->get('extension.list.module');
  return $instance;
}

public function defaultConfiguration(): array {
  return ['module_name' => 'simple_cron_examples'];
}

public function buildConfigurationForm(array $form, FormStateInterface $form_state): array {
  $form['module_name'] = [
    '#type' => 'select',
    '#title' => $this->t('Module'),
    '#options' => $this->getModuleOptions(),
    '#default_value' => $this->getConfigValue('module_name'),
    '#required' => TRUE,
  ];
  return $form;
}

public function process(): void {
  $this->getLogger('simple_cron_examples')
    ->info('The module @module is selected.', ['@module' => $this->getConfigValue('module_name')]);
}
```

## 3. Multi-type plugin (`MultiTypesCron`)

One plugin class can back several independent cron jobs ("types") that run in parallel. Override
`getTypeDefinitions()` to return a keyed list of types (each with a `label`); the parent creates
one cron job per type. In `process()`, branch on `getType()`. Throwing an exception marks that
run as failed and records the error status against the job.

```php
public function getTypeDefinitions(): array {
  return [
    'first'  => ['label' => $this->t('First')],
    'second' => ['label' => $this->t('Second (run fail)')],
  ];
}

public function process(): void {
  if ($this->getType() === 'second') {
    $last = $this->getCronJob()->getLastRunTime();
    throw new \RuntimeException(sprintf(
      'The multi type %s cron not run. Last success run date: %s',
      $this->getType(),
      $last ? $last->format('Y-m-d H:i:s') : $this->t('Never')
    ));
  }
  $this->getLogger('simple_cron_examples')->info('Job type: @type', ['@type' => $this->getType()]);
}
```

`getType()` and `getCronJob()` come from the base class; `getCronJob()` returns a
`Drupal\simple_cron\Entity\CronJobInterface`, whose `getLastRunTime()` returns a
`DrupalDateTime` or `NULL`.

## Base-class surface these examples rely on

From `SimpleCronPluginBase` / `SimpleCronPluginInterface` (parent module):
`process()` (the one method you must implement), `id()`, `label()`, `getType()`,
`getTypeDefinitions()`, `getCronJob()` / `setCronJob()`, `getConfiguration()` /
`setConfiguration()`, `defaultConfiguration()`, `buildConfigurationForm()` /
`validateConfigurationForm()` / `submitConfigurationForm()`, and the protected
`getConfigValue(string $key)`. See the parent `simple_cron` docs for the full plugin contract.

The submodule defines no routes, permissions, services, config schema, or drush commands of
its own — it is purely a set of example plugin classes.
