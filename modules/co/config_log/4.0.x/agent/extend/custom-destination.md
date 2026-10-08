# Add a custom log destination

Config Log has no plugin type. A new destination is just another **event subscriber** that
extends `ConfigLogSubscriberBase` and reuses its enable/ignore/redaction helpers. Give it a new
`$type` string, register it in your module's `*.services.yml` with the `event_subscriber` tag,
and (optionally) add a checkbox for your `$type` to the settings form via
`hook_form_config_log_config_form_alter()`.

```php
namespace Drupal\my_module\EventSubscriber;

use Drupal\config_log\EventSubscriber\ConfigLogSubscriberBase;
use Drupal\Core\Config\ConfigCrudEvent;
use Drupal\Core\Config\ConfigEvents;

class SlackConfigLogSubscriber extends ConfigLogSubscriberBase {

  // Must match a key you expose in log_destination.
  public static $type = 'slack';

  public static function getSubscribedEvents(): array {
    return [ConfigEvents::SAVE => [['onConfigSave', 10]]];
  }

  public function onConfigSave(ConfigCrudEvent $event): void {
    if (!$this->isEnabled()) {                     // checks log_destination['slack']
      return;
    }
    $config = $event->getConfig();
    if ($this->isIgnored($config->getName())) {    // honours the ignore list + negate
      return;
    }
    // encodeRedacted() gives you redacted YAML you can post anywhere.
    $yaml = $this->encodeRedacted($config->getName(), $config->get());
    // ... send $yaml to Slack ...
  }
}
```

```yaml
# my_module.services.yml
services:
  my_module.slack_config_log_subscriber:
    class: Drupal\my_module\EventSubscriber\SlackConfigLogSubscriber
    arguments: ['@config.factory']
    tags:
      - { name: event_subscriber }
```

Helpers available from the base class: `isEnabled()`, `isIgnored($name)`, `isChanged($config)`,
`isIgnoredNoChanges()`, `isConfigImportIgnored()`, `encode($array)`,
`encodeRedacted($name, $array)`, `formatConfigValue($name, $key, $value)`. There is no service to
call to *read* the log — query the `config_log` table directly or use the Views submodule.
