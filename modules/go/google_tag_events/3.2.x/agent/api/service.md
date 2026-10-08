# Pushing events: the `google_tag_events` service

Service id `google_tag_events` — class `Drupal\google_tag_events\GoogleTagEvents`. Get it with the
container or the shortcut `google_tag_events_service()` (defined in `google_tag_events.module`).
It queues events server-side and the front-end library replays them into `window.dataLayer`.

## Push an event

```php
// Simplest: an event with an explicit payload.
google_tag_events_service()->setEvent('some_event_name', [
  'event' => 'some_event_name',
  'foo' => 'bar',
]);
```

Produces, once the next page renders:

```js
dataLayer.push({ event: 'some_event_name', foo: 'bar' });
```

`setEvent(string $name, array $data = [], bool $save_to_tempstore = TRUE)`:
- If a `google_tag_event` plugin whose `id` equals `$name` exists, it is instantiated with
  `['data' => $data]` and `$data = $plugin->process($data)` shapes the payload (see
  [../plugins/event-plugins.md](../plugins/event-plugins.md)). Otherwise `$data['event']` defaults
  to `$name`.
- No-ops when GTM is not active (`gtmIsEnabled()` false and Debug mode off) — nothing is queued.
- Empty `$data` after processing is dropped.
- The same event name may be pushed repeatedly in one request; later ones are keyed `name_1`,
  `name_2`, … so none overwrite.
- `$save_to_tempstore = TRUE` persists the queue to the private tempstore so it survives a
  redirect/reload (needed for form-submit and other POST-then-redirect flows). Pass `FALSE` when the
  event will be rendered on the very same request.

## Other public methods

| Method | Purpose |
| --- | --- |
| `getEvents(): array` | Current queued events (keyed by name). |
| `flushEvents()` | Clear the in-memory queue and delete the tempstore entry. |
| `saveEvents()` | Persist the current queue to the tempstore. |
| `gtmIsEnabled(): bool` | TRUE if Debug mode is on, else if `google_tag`'s container resolver returns a container. Statically cached per request. |
| `getEventsWeightsList(): array` | Map of plugin id → `weight` (only plugins that define one); drives push order client-side. |
| `processCurrentEvents(array &$build)` | Adds `enabled` + `weights` to `$build['#attached']['drupalSettings']['google_tag_events']`. Called from `hook_page_attachments`. |
| `processAjaxCommandCurrentEvents(): GoogleTagEventsSettingsCommand` | Builds the AJAX settings command carrying queued events, then flushes them. |
| `processInlineCurrentEvents(): string` | Returns a self-contained `<script>` that merges the events into `drupalSettings` and calls `Drupal.attachBehaviors` (helper for non-standard render paths; not invoked by the module itself). |

Constant `GoogleTagEvents::TYPE = 'google_tag_events'` is the tempstore collection, the
`drupalSettings` namespace, and the config-derived event storage key.

## How queued events reach the page

The module implements three hooks in `google_tag_events.module`:

- `hook_page_attachments` — attaches the `google_tag_events/tracking` library and calls
  `processCurrentEvents()` (sets `drupalSettings.google_tag_events.enabled` and `.weights`).
- `hook_page_bottom` — adds a `#lazy_builder` placeholder resolving to
  `google_tag_events.lazy_builder:getEvents` (`Drupal\google_tag_events\LazyBuilder`,
  a `TrustedCallbackInterface`). It renders a `<script type="application/json"
  data-selector="google_tag_events">` element containing `Json::encode($events)` plus an init
  `<script>`, then flushes the queue. Using a lazy builder keeps the surrounding page cacheable.
- `hook_ajax_render_alter` — prepends a `googleTagEventsSettings` AJAX command
  (`Drupal\google_tag_events\Ajax\GoogleTagEventsSettingsCommand`, extends core `SettingsCommand`)
  so events raised during an AJAX request are delivered even when the response makes no DOM change.

Front end (`js/google_tag_events.js`, behavior `Drupal.behaviors.google_tag_events`): reads the JSON
`<script data-selector='google_tag_events'>` via `once()`, merges it into
`drupalSettings.google_tag_events.gtmEvents`, sorts pending events by their `weights`, and calls
`window.dataLayer.push(event)` for each, deleting it after. It also registers the
`Drupal.AjaxCommands.prototype.googleTagEventsSettings` command (merge settings + re-attach
behaviors). Library deps: `core/jquery`, `core/drupal`, `core/drupalSettings`, `core/once`,
`js_cookie/js-cookie`.

## Cross-request delivery (redirect-safe, anonymous-safe)

Queued events live in a private tempstore collection named `google_tag_events`. Because anonymous
visitors have no server session, the module ships a custom tempstore factory
(`google_tag_events.private_tempstore`, class `PrivateTempStoreFactory`; deprecated alias for
core `tempstore.private`):

- Anonymous user → `PrivateTempStoreCookie` stores the serialized queue in a cookie named
  `STYXKEY_gte_ptsc_google_tag_events` (prefix `STYXKEY_gte_ptsc_`, `secure` flag set), so events
  survive the redirect.
- On login the cookie's contents are merged into the real `PrivateTempStore` and the cookie cleared.
- On read, the stored value is `unserialize(..., ['allowed_classes' => FALSE])`; a non-array result
  is discarded, so only plain event arrays are ever queued.

Values are emitted through `Json::encode` into a `type="application/json"` script and JSON-parsed
client-side before `dataLayer.push` — they are not written into executable markup.
