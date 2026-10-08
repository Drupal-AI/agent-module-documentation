# Monitoring Multigraph — config entity, UI & API

## Config entity `monitoring_multigraph`

Config prefix `monitoring_multigraph.multigraph.<id>`. Exported keys: `id`, `label`, `description`,
`sensors`. `sensors` is a sequence keyed by sensor id:

```yaml
id: watchdog_severe_entries
label: 'Watchdog severe entries'
description: 'Watchdog entries with severity Warning or higher'
sensors:
  dblog_404:
    weight: 0
    label: '404'
  dblog_event_severity_critical:
    weight: 2
    label: Critical
dependencies:
  module:
    - dblog
```

## Admin UI

- List: `/admin/config/system/monitoring/multigraphs` (`entity.monitoring_multigraph.list`).
- Add / edit / delete: `…/multigraphs/add`, `…/multigraphs/{monitoring_multigraph}`,
  `…/multigraphs/{monitoring_multigraph}/delete`. All require `administer monitoring`.

## Entity API (`\Drupal\monitoring_multigraph\Entity\Multigraph`)

- `getSensors()` — sensor objects in the multigraph.
- `getSensorsRaw()` — the raw `sensors` array.
- `addSensor($name, $label = NULL)` / `removeSensor($name)`.
- `getDescription()`, `getDefinition()`.
- `calculateDependencies()` — adds config deps on referenced sensors/modules.

```php
use Drupal\monitoring_multigraph\Entity\Multigraph;
$mg = Multigraph::create(['id' => 'my_graph', 'label' => 'My graph']);
$mg->addSensor('dblog_404', '404s');
$mg->addSensor('user_failed_logins', 'Failed logins');
$mg->save();
```

## REST

REST resource `monitoring-multigraph` (`config/optional/rest.resource.monitoring_multigraph.yml`)
exposes multigraph data to external systems (e.g. Munin).
