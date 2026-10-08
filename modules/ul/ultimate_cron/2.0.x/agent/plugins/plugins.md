# Plugin types

Ultimate Cron defines **three** plugin types; every cron job picks one of each. All use
annotation discovery (managers extend `DefaultPluginManager`).

| Type | Namespace | Annotation | Interface / base | Manager service | Built-ins |
|---|---|---|---|---|---|
| Scheduler | `Plugin/ultimate_cron/Scheduler` | `@SchedulerPlugin` | `SchedulerInterface` / `SchedulerBase` | `plugin.manager.ultimate_cron.scheduler` | `simple`, `crontab` |
| Launcher | `Plugin/ultimate_cron/Launcher` | `@LauncherPlugin` | `LauncherInterface` / `LauncherBase` | `plugin.manager.ultimate_cron.launcher` | `serial` |
| Logger | `Plugin/ultimate_cron/Logger` | `@LoggerPlugin` | `LoggerInterface` / `LoggerBase` | `plugin.manager.ultimate_cron.logger` | `database`, `cache` |

- **Scheduler** decides whether a job is due (`isScheduled()`) from its rules.
- **Launcher** actually executes the job, handling locks/timeouts/threads.
- **Logger** records each run (start/end, user, severity, messages).

Each plugin extends `CronPlugin` (config form via `buildConfigurationForm()` /
`submitConfigurationForm()`, `defaultConfiguration()`, `settingsLabel()`). Alter hooks:
`hook_ultimate_cron_scheduler_info_alter`, `..._launcher_info_alter`,
`..._logger_info_alter`. Optionally implement `PluginCleanupInterface::cleanup()` to be
called during `ultimate_cron_cron()`.

Example scheduler:

```php
namespace Drupal\my_module\Plugin\ultimate_cron\Scheduler;

use Drupal\ultimate_cron\Entity\CronJob;
use Drupal\ultimate_cron\Plugin\ultimate_cron\Scheduler\Crontab;

/**
 * @SchedulerPlugin(
 *   id = "business_hours",
 *   title = @Translation("Business hours"),
 *   description = @Translation("Only runs 9-17 on weekdays."),
 * )
 */
class BusinessHours extends Crontab {
  public function defaultConfiguration() {
    return ['rules' => ['0+@ 9-17 * * 1-5']] + parent::defaultConfiguration();
  }
}
```

Config schema for a new plugin goes in `config/schema` keyed
`ultimate_cron.plugin.<type>.<id>` (see the built-ins in
`config/schema/ultimate_cron.schema.yml`). Run `drush cr` after adding a plugin.
