<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# build_hooks API: triggering, events, alter hook

Grounded in `build_hooks.services.yml`, `src/Trigger.php` + `src/TriggerInterface.php`,
`src/Event/BuildTrigger.php`, `src/Event/ResponseEvent.php`, `src/DeployLogger.php`, and
`src/Plugin/FrontendEnvironmentManager.php`.

## The Trigger service — `build_hooks.trigger`

`Drupal\build_hooks\Trigger` (interface `TriggerInterface`) is the entry point for firing deploys.

```php
$trigger = \Drupal::service('build_hooks.trigger');
$env = \Drupal::entityTypeManager()->getStorage('frontend_environment')->load('prod');

// Deploy ONE environment now (asks the plugin for BuildHookDetails, does the Guzzle request,
// logs messages, and on success closes the current deployment + invalidates the toolbar tag):
$trigger->triggerBuildHookForEnvironment($env);

// Deploy every environment whose deployment_strategy is 'cron' (what hook_cron calls):
$trigger->deployFrontendCronEnvironments();

// Toolbar cache tag helpers:
$tag = $trigger->getToolbarCacheTag();     // 'build_hooks_toolbar'
$trigger->invalidateToolbarCacheTag();
```

`triggerBuildHookForEnvironment()` swallows failures into messenger warnings/errors and the
`build_hooks` logger channel rather than throwing — check dblog if a deploy silently no-ops.
`showMenu()` returns TRUE only if the current user has `trigger deployments`.

## DeployLogger — `build_hooks.deploylogger`

`Drupal\build_hooks\DeployLogger` records content into the open `build_hooks_deployment` per environment:
`logEntityCreated()`, `logEntityUpdated()` (same as created), `logEntityDeleted()`,
`isEntityTypeLoggable($entity)` (checks `build_hooks.settings:logging.entity_types`),
`getNumberOfItemsSinceLastDeploymentForEnvironment($env)`,
`setLastDeployTimeForEnvironment($env)` (closes the deployment). Storage handler
`build_hooks_deployment` implements `getOrCreateNextDeploymentForEnvironment()`.

## Events

Both are dispatched from `Trigger::triggerBuildHook()` (a private step of the deploy).

### `Drupal\build_hooks\Event\BuildTrigger` (before the request)

Dispatched **before** the outbound HTTP call, after the plugin's `preDeploymentTrigger()`. Carries the
`BuildHookDetails`, the `FrontendEnvironment` entity, and the open `build_hooks_deployment`. A subscriber
can **cancel** the build; if `shouldBuild()` is false the request is skipped and the reason surfaced.

```php
use Drupal\build_hooks\Event\BuildTrigger;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;

class MyDeploySubscriber implements EventSubscriberInterface {
  public static function getSubscribedEvents(): array {
    return [BuildTrigger::class => 'onBuild'];
  }
  public function onBuild(BuildTrigger $event): void {
    // Inspect $event->getFrontendEnvironment() / $event->getDeployment() / $event->getBuildHookDetails().
    // Call $event->cancelBuild($reason) (or the shouldBuild()/setReason API) to abort.
  }
}
```

(Dispatched by class name — subscribe to `BuildTrigger::class`. Confirm accessor/cancel method names
against `src/Event/BuildTrigger.php` in your installed release before relying on them.)

### `Drupal\build_hooks\Event\ResponseEvent` (after the request)

Dispatched with the provider's PSR-7 response and the plugin, event name
`ResponseEvent::EVENT_NAME`. Use it to log/inspect provider responses.

## Alter hook — plugin definitions

```php
/** Implements hook_build_hooks_frontend_environment_info_alter(). */
function mymodule_build_hooks_frontend_environment_info_alter(array &$definitions): void {
  // Add/remove/modify FrontendEnvironment plugin definitions.
  unset($definitions['generic']);
}
```

## No Drush commands

The module ships no Drush commands; script deploys via `build_hooks.trigger` in `drush php:eval`
(see above) or `drush cron` for the cron strategy.
