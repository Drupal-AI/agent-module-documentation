<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Extending: add a tracked event type

Three hooks (`event_log_track.api.php`) let you register a new event type, alter every log, or
route logs elsewhere. This is exactly how the shipped submodules work.

## `hook_event_log_track_handlers()` — register a type

Return an array keyed by `type`. The handler's metadata populates the report's Type/Operation
filters; declaring `form_ids` (or `form_ids_regexp`) + `form_submit_callback` also wires the
type into the module's global form-submit dispatch.

```php
#[\Drupal\Core\Hook\Attribute\Hook('event_log_track_handlers')]
public function handlers(): array {
  return [
    'my_entity' => [
      'title' => $this->t('My entity'),
      'operations' => ['insert', 'update', 'delete'],
      // Optional form-driven logging:
      // 'form_ids' => ['my_entity_form'],
      // 'form_ids_regexp' => ['/^my_entity_.*_form$/'],
      // 'form_submit_callback' => [static::class, 'formSubmit'],
    ],
  ];
}
```

Then actually log — most submodules do it from **entity hooks** (or event subscribers), calling the
manager directly (see [api/logging.md](../api/logging.md)):

```php
#[\Drupal\Core\Hook\Attribute\Hook('my_entity_insert')]
public function insert(MyEntityInterface $e): void {
  $log = ['type' => 'my_entity', 'operation' => 'insert',
    'description' => $e->label(), 'ref_numeric' => $e->id(), 'ref_char' => $e->label()];
  $this->eventLogTrackManager->insert($log);
}
```

A `form_submit_callback` receives `($form, $form_state, $form_id)` and returns a `$log` array (or
NULL); the manager adds `type` and calls `insert()`.

## `hook_event_log_track_alter(array &$log)`

Fired inside `insert()` for **every** log entry, before it is written — enrich or modify any field.

## `hook_event_log_track_log_alternative(array $log)`

Fired for every prepared log entry so a module can dispatch it to its own backend (this is how
`event_log_track_syslog` and `event_log_track_stdout` re-emit each event to syslog / stdout).

```php
#[\Drupal\Core\Hook\Attribute\Hook('event_log_track_log_alternative')]
public function toBackend(array $log): void {
  \Drupal::service('my_module.logger')->logEvent($log);
}
```

Note there is **no plugin type** — extension is purely via these hooks and the manager service.
