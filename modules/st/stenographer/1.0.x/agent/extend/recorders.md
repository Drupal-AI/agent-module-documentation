<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Stenographer — defining recorders & extending

## Recorder definitions
Recorders live in `<your_module>.stenographer.yml`. A recorder binds:
- a **trigger** (one of the built-in ids: `hook`, `exception`, `entity`, `form`) that decides *when* to capture;
- a **capture strategy** + **data adapters** that decide *what* data to record;
- a **storage** plugin that decides *where* the event goes.

Start from the shipped `example.stenographer.yml`, which demonstrates security/audit recorders with inline comments explaining each option.

## Dev storage override
Redirect every recorder to one storage target in `settings.local.php`:
```php
$settings['stenographer.dev'] = [
  'storage' => 'drupal_watchdog',
];
```

## Extension points (plugins / tagged services)
- **Storage** — subclass into `plugin.manager.stenographer.storage`.
- **Data adapter** — `plugin.manager.stenographer.data_adapter`.
- **Condition** — `plugin.manager.stenographer.condition`.
- **Trigger** — register a service tagged `{ name: stenographer_trigger, id: <id> }`; it is collected by `TriggerCollection::addBuilder`. Built-ins: `HookTriggers`, `ExceptionTriggers`, `EntityTriggers`, `FormTriggers` (each paired with a Handler that receives the logger factory).

After adding YAML or plugins, run `drush cr` so the discovery caches rebuild.
