<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# The `eca` parameters collection & event subscriber

## Install & enable

```bash
composer require drupal/eca_parameters
drush en eca_parameters -y
```

Requires `drupal/eca ^2.0` and `drupal/parameters ^1.0` (both pulled in by Composer). No
configuration UI in the base module; the plugins are used inside ECA models. To manage the `eca`
collection's parameters visually, also enable the `eca_parameters_ui` submodule
(see `../../../modules/eca_parameters_ui/2.0.x/agent/start.md`).

## The `eca` collection

`config/install/parameters.collection.eca.yml` installs a `parameters.collection` config entity:

```yaml
id: eca
label: ECA
status: true
locked: false
deletable: false
parameters: {  }
```

This is the collection the *Set parameter* action writes to and the collection that gets injected
into every parameter resolution (below).

## Event subscriber — `EventSubscriber/EcaParameters.php`

Registered in `eca_parameters.services.yml` as `eca_parameters.subscriber`, extending ECA's
`eca.execution.subscriber_parent`, with `setEventDispatcher(@event_dispatcher)`. It subscribes to
the **`parameters`** module's `ParameterEvents::COLLECTIONS_PREPARATION`
(`CollectionsPreparationEvent`) via `onPreparation()`, which does two things:

1. **Dispatch the ECA request event.** If the preparation event carries a specific
   `->name` (a named parameter is being requested), it dispatches a `RequestingParameterEvent`
   under `eca_parameters.request` — this is what the `parameters:request` ECA event plugin reacts
   to (see [../plugins/events.md](../plugins/events.md)).
2. **Inject the `eca` collection into resolution.** It loads the `eca`
   `ParametersCollection` and appends it to `$event->collections`, but keeps any `global`
   collection last:
   - if the last collection is `global`, it is temporarily popped, the `eca` collection is added
     (unless already present), then `global` is pushed back after it;
   - `reset($event->collections)` restores the array pointer.

   Effect: **`eca` parameters take precedence over `global`** ones, while more specific
   entity/bundle collections earlier in the list still win over `eca`. Storage lookup failure
   (`InvalidPluginDefinitionException` / `PluginNotFoundException`) is caught and the subscriber
   returns quietly.

The target collection id is the class constant `static::$collectionId = 'eca'` (matched by the same
constant in the *Set parameter* action).

## Config schema

`config/schema/eca_parameters.schema.yml` defines `eca_parameters_action_configuration`
(`type: ignore`) and maps `action.configuration.eca_parameter_get` to it. No other config schema is
shipped; the `eca` collection uses the `parameters` module's own schema.

## Update hook

`eca_parameters.post_update.php` → `eca_parameters_post_update_rename_tokens_2_0_0()` renames the
token `event:parameter-name` to `event:parameter_name` across existing ECA models (via ECA's
`_eca_post_update_token_rename()`), for the ECA 2.0.0 token-naming convention.
