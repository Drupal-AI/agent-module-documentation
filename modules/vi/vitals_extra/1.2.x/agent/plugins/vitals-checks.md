# The four `VitalsCheck` plugins

vitals_extra provides four plugins of the **`VitalsCheck`** type that the `vitals` module defines
(annotation `Drupal\vitals\Annotation\VitalsCheck`, manager `plugin.manager.vitals_check`, discovery
dir `Plugin/VitalsCheck`). It does **not** define the plugin type. Each plugin implements one method,
`getData()`, returns a plain array, and does no writes / no external requests / no user-input handling.

## How they run

- Enable each check on the parent Vitals settings form: route `vitals_settings`,
  path `/admin/config/services/vitals`, permission `administer vitals`. The chosen ids are stored in
  config `vitals.settings:vitals_enabled_plugins` (a sequence; `Drupal\vitals\Vitals::getEnabledChecks()`
  treats a check as enabled only when the key equals its own id, e.g. `mail: mail`).
- `Drupal\vitals\Vitals::getStatus()` loops the enabled ids, calls
  `$manager->createInstance($id)->getData()`, and builds `[$plugin_id => data]`.
- The result is returned as JSON by `Drupal\vitals\Controller\VitalsController::output($token)` at
  `/vitals/{token}` (route `vitals.content`). That endpoint is gated by the *parent* module
  (`hash_equals()` against the `vitals.token` state value plus a flood limit of 10 attempts/hour);
  vitals_extra adds no access control of its own.

## Base class

`Drupal\vitals_extra\VitalsExtraPlugin` extends `Drupal\vitals\VitalsCheckPluginBase` and implements
`ContainerFactoryPluginInterface`. Its `create()` injects and stores `$this->configFactory`
(`config.factory`) and `$this->moduleHandler` (`module_handler`). `UpdateStatus`, `DevModules` and
`Mail` extend it; `EnvironmentIndicator` extends `VitalsCheckPluginBase` directly and *additionally*
injects `$this->state` (`state`) alongside config factory + module handler.

## `update_status` — `UpdateStatus.php`

Reports the core update-manager cadence and where notifications go.

- Reads `update.settings:check.interval_days` → `interval`.
- Collects addresses from `update.settings:notification.emails`. If `symfony_mailer` is enabled it
  *also* appends addresses from `symfony_mailer.mailer_policy.update.status_notify:configuration.email_to.addresses`,
  falling back to `symfony_mailer.mailer_policy._:configuration.email_to.addresses` (each entry's
  `value`).
- Output: `{ "interval": <int|null>, "emails_list": [<addresses>], "emails_status": <bool: list non-empty> }`.

## `environment_indicator` — `EnvironmentIndicator.php`

- If the `environment_indicator` module is enabled: `name` = config
  `environment_indicator.indicator:name`.
- `release` = state value `environment_indicator.current_release` (only when set).
- Output: `{ "name": <string|null>, "release": <string|null> }`. Both are `null` when the module is
  absent / values unset.

## `dev_modules` — `DevModules.php`

Flags common development-only modules that are actually active. Every value is a boolean.

- `devel` = `moduleExists('devel')`.
- `stage_file_proxy` = module enabled **and** `stage_file_proxy.settings:origin` non-empty.
- `shield` = module enabled **and** `shield.settings:shield_enable` truthy.
- `reroute_email` = `reroute_email.settings:enable` when `reroute_email` is enabled; else
  `symfony_mailer_reroute.settings:enable` when `symfony_mailer_reroute` is enabled; else `FALSE`.
- Output: `{ "devel": <bool>, "stage_file_proxy": <bool>, "shield": <bool>, "reroute_email": <bool> }`.
  (No other dev module — e.g. `dblog` — is inspected.)

## `mail` — `Mail.php`

Reports the effective mail provider/transport, first match wins:

1. `mailsystem` enabled → `provider` = `"mailsystem > " . mailsystem.settings:defaults.sender`;
   `transport` = that sender, but if the sender is `swiftmailer` → `swiftmailer.transport:transport`,
   and if `smtp`/`phpmailer_smtp` → `"smtp"`.
2. else `symfony_mailer` → `provider` `"symfony_mailer"`, `transport` = `symfony_mailer.settings:default_transport`.
3. else `smtp` enabled **and** `smtp.settings:smtp_on` → both `"smtp"`.
4. else `phpmailer_smtp` enabled → `provider` `"phpmailer_smtp"`, `transport` `"smtp"`.
5. else default → both = `system.mail:interface.default`.
- Output: `{ "provider": <string|null>, "transport": <string|null> }`.

## Adding your own check

```php
namespace Drupal\my_module\Plugin\VitalsCheck;

use Drupal\vitals_extra\VitalsExtraPlugin;

/**
 * @VitalsCheck(
 *   id = "my_check",
 *   label = @Translation("My check"),
 *   description = @Translation("What it reports."),
 * )
 */
class MyCheck extends VitalsExtraPlugin {

  public function getData() {
    return ['ok' => $this->moduleHandler->moduleExists('some_module')];
  }

}
```

Clear caches, then enable `my_check` on `/admin/config/services/vitals`. (You may extend Vitals'
`VitalsCheckPluginBase` directly instead if you don't need the config-factory/module-handler that
`VitalsExtraPlugin` injects.)
