# Services & how the action runs

Defined in `rabbit_hole.services.yml`.

| Service | Class | Purpose |
|---|---|---|
| `rabbit_hole.behavior_invoker` | `BehaviorInvoker` | Resolves the entity from the request and invokes the behavior plugin. Called from the request event subscriber. |
| `rabbit_hole.behavior_settings_manager` | `BehaviorSettingsManager` | CRUD for `rabbit_hole.behavior_settings.*` config entities (bundle/global defaults). |
| `rabbit_hole.form_mangler` | `FormManglerService` | Adds the "Rabbit Hole settings" tab to entity/bundle/global forms and handles submit. |
| `rabbit_hole.entity_extender` | `EntityExtender` | Declares the extra `rh_*` base fields on supported entities. |
| `plugin.manager.rabbit_hole_behavior_plugin` | `RabbitHoleBehaviorPluginManager` | Behavior plugin manager. |
| `plugin.manager.rabbit_hole_entity_plugin` | `RabbitHoleEntityPluginManager` | Entity plugin manager (supported types, token map). |

## Flow

`RabbitHoleSubscriber` (event subscriber, `EventSubscriber/RabbitHoleSubscriber.php`) listens
on kernel request and delegates to `BehaviorInvoker::processEntity()`. The invoker loads the
entity's behavior settings, honors the per-entity override and the `bypass` permission, then
runs the matching behavior plugin's `performAction()`; if it returns a `Response`, that becomes
the page response (redirect / 403 / 404).

Typical programmatic entry points: read a bundle default via
`\Drupal::service('rabbit_hole.behavior_settings_manager')`, or add a behavior/entity plugin
(see [../plugins/plugins.md](../plugins/plugins.md)). Values and the final response can be
altered via hooks (see [../hooks/hooks.md](../hooks/hooks.md)).
