# Configure buses, transports, routing (container parameters + sm_config UI)

SM is configured with **container parameters**, set in a site-wide `services.yml` referenced by
`settings.php` (`$settings['container_yamls'][] = ...`). Defaults live in `sm.services.yml`. The
optional `sm_config` submodule adds *routing* on top through Drupal config; the two are additive
(config from `sm_config` overrides/merges into the YAML `sm.routing`).

## Parameters (source of truth: `sm.services.yml`, applied by `src/SmCompilerPass.php`)

```yaml
parameters:
  # ID of the auto-generated default bus service.
  sm.default_bus: sm.bus.default

  # Each key becomes a service `sm.bus.<key>` (Symfony MessageBus, tagged messenger.bus).
  sm.buses:
    default:
      middleware: []            # extra middleware IDs inserted between the before/after defaults
      default_middleware:
        enabled: true           # recommended; adds the standard Messenger middleware stack

  # name => transport definition. See api/transports.md for drupal-sql options.
  sm.transports:
    synchronous:
      dsn: 'sync://'            # handled immediately, in-request
    asynchronous:
      dsn: 'drupal-sql://default'
    failed:
      dsn: 'drupal-sql://default?queue_name=failed'

  # class/wildcard => transport name(s). Empty = everything runs synchronously.
  sm.routing: []

  # Transport name where messages land after exhausting retries.
  sm.failure_transport: 'failed'
```

### `sm.routing` — which message goes to which transport
Keys are message FQCNs or wildcards; values are a transport name or a list of names. Matching follows
Symfony's rules (exact class, then `Namespace\*` prefix, then `*` fallback). Example:

```yaml
parameters:
  sm.routing:
    Drupal\my_module\MyMessage: asynchronous
    Drupal\my_module\MyMessage2: [asynchronous, other_transport]
    'Drupal\my_module\*': asynchronous
    '*': asynchronous
```

A message with no matching route is handled **synchronously** (immediately, in the dispatching
request). `SmCompilerPass::sendersLocator()` maps this parameter onto Messenger's
`SendersLocator`.

### Per-transport options (defaults from `SmCompilerPass::applyTransportsDefaults`)
Under each `sm.transports.<name>` you may set:

- `dsn` (required) — e.g. `sync://`, `drupal-sql://default?queue_name=...`.
- `options` — transport-specific (Drupal SQL: `table_name`, `queue_name`, `redeliver_timeout`,
  `auto_setup`). See [../api/transports.md](../api/transports.md).
- `serializer` — service ID; defaults to `messenger.default_serializer` (PHP native serializer).
- `failure_transport` — override `sm.failure_transport` for this transport only.
- `retry_strategy` — `service` (custom) OR the tunables `max_retries` (default `3`), `delay`
  (`1000` ms), `multiplier` (`2`), `max_delay` (`0`), `jitter` (`0.1`).
- `rate_limiter` — a rate-limiter name; resolves to service `limiter.<name>` and requires
  `symfony/rate-limiter` (else a `LogicException` is thrown at compile). Define the limiter and its
  storage under `services:` in the same YAML (see README "Rate Limiting").

### Deduplication
When `symfony/lock` + Messenger's `DeduplicateMiddleware` are present (they are, by default),
`SmCompilerPass` adds the deduplicate middleware to every bus, backed by a `LockFactory` over
`DrupalDeduplicatingLockStore` (Drupal `lock.persistent`, key prefix `sm-`). Opt in per message by
adding a `DeduplicateStamp` at dispatch — see [../api/dispatch.md](../api/dispatch.md).

## sm_config submodule (optional UI + Drupal config)

Enable `sm_config` to manage **routing** through the admin UI and persist it in config instead of (or
in addition to) YAML.

- Route/form: `sm_config.settings` → `/admin/config/messenger/routing`, form
  `Drupal\sm_config\Form\SmRoutingConfigForm` (`getFormId()` = `sm_config_sm_config`).
- Permission (required to reach the form): **`administer sm_config configuration`**
  (`sm_config.permissions.yml`, `restrict access: true`).
- Menu: `sm_config.settings` under `system.messenger_settings` (which is the base module's
  `/admin/config/messenger` landing, perm `access administration pages`).
- Config object: **`sm_config.settings`** with a single `routing` key
  (schema `config/schema/sm_config.schema.yml`): a sequence of `{bus, message, receivers[]}`.
- Mechanism: `SmConfigServiceProvider` → `SmConfigCompilerPass` reads `sm_config.settings.routing`
  at container build (via `BootstrapConfigStorageFactory`) and merges each entry into
  `messenger.senders_locator`'s message→senders map — a config entry **overrides** the same message's
  YAML routing. The form also computes a per-bus message×bus map (`sm_config.message_bus_map`
  parameter) to populate the checkbox options.
- The form builds checkboxes of available receiver names (transport aliases and service IDs) grouped
  by bus, plus namespace-prefix and `*` fallback rows. Submitting calls
  `$kernel->invalidateContainer()` so the container rebuilds with the new routing.

The form's help text and titles are rendered through `t()`/`inline_template` with placeholder
escaping; message class names and transport names come from the server-derived container maps, not
from request input.

> Warning (from README): uninstalling `sm` (or `sm_config`) removes its configuration — unlike
> Field UI / Views UI, where config survives module removal.

## Apply changes
Container parameters and message-handler/routing changes take effect only on **container rebuild**:
`drush cr` (or `drush cache:rebuild`). The `sm_config` form triggers a rebuild automatically on save.
