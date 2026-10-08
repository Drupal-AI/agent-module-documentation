# ECA plugin types (Event, Condition, Action)

ECA models are built from three plugin kinds. ECA Core defines two and reuses core's for the
third.

| Kind | Manager service | Base namespace | Attribute / Annotation | Interface |
|---|---|---|---|---|
| Event | `plugin.manager.eca.event` (`Drupal\eca\PluginManager\Event`) | `Plugin/ECA/Event` | `#[EcaEvent]` / `@EcaEvent` | `EventInterface` |
| Condition | `plugin.manager.eca.condition` (`Drupal\eca\PluginManager\Condition`) | `Plugin/ECA/Condition` | `#[EcaCondition]` / `@EcaCondition` | `ConditionInterface` |
| Action | `plugin.manager.eca.action` — **decorates** core `plugin.manager.action` | core `Plugin/Action` | `#[Action]` (core) | core `ActionInterface` |

Because the action manager is a decorator, every existing Drupal core/contrib Action plugin is
available inside ECA; ECA's submodules add many more. Attributes live in `src/Attribute/`
(`EcaEvent`, `EcaCondition`, `EcaAction`, `Token`); legacy annotations in `src/Annotation/`.

## Add a custom capability
Put a plugin in your module:
- Event: `src/Plugin/ECA/Event/MyEvent.php` with `#[EcaEvent(...)]`, extending ECA's event base.
- Condition: `src/Plugin/ECA/Condition/MyCondition.php` with `#[EcaCondition(...)]`.
- Action: a normal core `#[Action]` plugin — it just appears in ECA.

After adding event plugins or changing models run `drush eca:subscriber:rebuild` so ECA
re-registers the underlying Symfony event subscriptions. The `Processor` (`src/Processor.php`)
executes matching models when an event fires.
