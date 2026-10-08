# The event handler system (how a subsystem gets tracked)

Events Log Track does **not** define an annotated plugin type. A "tracker" is an entry
returned from `hook_event_log_track_handlers()` (a procedural-style hook, implemented in
5.0.x with `#[Hook('event_log_track_handlers')]` attribute classes). Each submodule provides
one handler entry plus its own entity/form hooks that call the logging service.

## hook_event_log_track_handlers()

Return an associative array keyed by **event type** (the value stored in the `type` column),
each valued by a handler-info array:

| Key | Type | Meaning |
| --- | --- | --- |
| `title` | string | Human label; feeds the Views *Type* exposed-filter options (`EventLogTrackApi::getHandlerOptions()`). |
| `operations` | string[] | The operation labels this type emits; feeds the *Operation* exposed-filter options. Free-form (e.g. `insert`, `update`, `delete`, `login`, `save`). |
| `form_ids` | string[] | (Optional) Exact form IDs whose submit should invoke `form_submit_callback`. |
| `form_ids_regexp` | string[] | (Optional) Regex patterns matched against `$form_id`. |
| `form_submit_callback` | callable | (Optional) `fn(array &$form, FormStateInterface $form_state, string $form_id): ?array` — returns a `$log` array (its `type` is set automatically) or NULL. |

Minimal example (entity-hook style, the common case):

```php
#[Hook('event_log_track_handlers')]
public function eventLogTrackHandlers(): array {
  return ['my_thing' => [
    'title' => $this->t('My thing'),
    'operations' => ['insert', 'update', 'delete'],
  ]];
}

#[Hook('my_thing_insert')]
public function insert(MyThingInterface $e): void {
  \Drupal::service('event_log_track.manager')->insert([
    'type' => 'my_thing',
    'operation' => 'insert',
    'description' => $this->t('%label', ['%label' => $e->label()]),
    'ref_numeric' => $e->id(),
    'ref_char' => $e->label(),
  ]);
}
```

The handler list is gathered once per request via `EventLogTrackManager::getEventHandlers()`
(`moduleHandler->invokeAll('event_log_track_handlers')` + `drupal_static`).

## Form-submit dispatch

The base module implements `hook_form_alter` (`EventLogTrackHooks::formAlter`) and, via
`EventLogTrackManager::addSubmitHandler()`, appends
`[EventLogTrackManager::class, 'formSubmitCallback']` to **every** form's `#submit` tree. On
submit, `handleFormSubmit()` runs each handler whose `form_ids` / `form_ids_regexp` matches
`$form['#form_id']`, calls its `form_submit_callback`, and inserts the returned `$log` (with a
`event_log_track_logged` temporary flag so a form is logged once). Submodules that log via
this path: `event_log_track_menu`, `event_log_track_auth` (password-reset), `event_log_track_tfa`.

## Alter hooks

- `hook_event_log_track_handlers_alter(array &$handlers)` — add/modify/remove handler entries.
- `hook_event_log_track_alter(array &$log)` — mutate a prepared `$log` right before it is
  written (invoked by `moduleHandler->alter('event_log_track', $log)` inside `insert()`).

## Alternative logging backends

`hook_event_log_track_log_alternative(array $log)` is `invokeAll`-dispatched from `insert()`
after alter, **before** the DB write. Submodules `event_log_track_syslog` and
`event_log_track_stdout` implement it to also emit each event to syslog/watchdog or
stdout/stderr. Combine with `disable_db_logs` (see configure/settings.md) to log *only* to the
alternative backend.

See [api/logging.md](../api/logging.md) for the `$log` array shape and the service.
