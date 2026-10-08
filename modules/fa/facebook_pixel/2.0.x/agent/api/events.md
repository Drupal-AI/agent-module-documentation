<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Firing pixel events

## The service

`facebook_pixel.facebook_event` → `Drupal\facebook_pixel\FacebookEvent`
(implements `FacebookEventInterface`), constructed with `tempstore.private`,
`session_manager` and `module_handler`.

```php
/** @var \Drupal\facebook_pixel\FacebookEventInterface $fb */
$fb = \Drupal::service('facebook_pixel.facebook_event');

$fb->addEvent('Lead', [
  'content_name' => $node->getTitle(),
  'content_ids'  => [$node->id()],
  'value'        => '19.99',
  'currency'     => 'EUR',
]);
```

| method | signature | notes |
|---|---|---|
| `addEvent` | `addEvent(string $event, string\|array $data = '', bool $start_session = FALSE)` | invokes `hook_facebook_pixel_event_data_alter($data, $event)` first, then stores the event |
| `getEvents` | `getEvents(): array` | merges the static array with the session events, `array_unique(…, SORT_REGULAR)`; reading session events **flushes** them |

Storage rules inside `addEvent()`:

* A session is already started **or** `$start_session === TRUE` → the event is appended to
  the `facebook_pixel` key of the **`user` private tempstore** (survives a redirect, which is
  what add-to-cart / checkout flows need).
* Otherwise → a **static** array on the class, i.e. this request only.

`getEvents()` is called by `hook_page_attachments()`, which JSON-encodes each event's data
and XSS-filters both the name and the encoded payload before handing them to
`drupalSettings.facebook_pixel.events`.

## Events the module fires by itself

| Event | Trigger | Payload |
|---|---|---|
| `PageView` | `js/facebook_pixel.js` right after `fbq('init', id)` | none |
| `ViewContent` | `hook_entity_view()` for **node** entities in the `default` or `full` view mode | `content_name` (title), `content_type` (bundle), `content_ids` (`[nid]`) |
| `CompleteRegistration` | `hook_entity_insert()` for **user** entities | the new uid (a scalar, not an array) |

Commerce events (`AddToCart`, `InitiateCheckout`, `Purchase`, product `ViewContent`) come
from the `facebook_pixel_commerce` submodule.

## The JS contract

`drupalSettings.facebook_pixel` carries:

```js
{
  facebook_id: '123…',
  events: [{event: 'ViewContent', data: '{"content_name":"…"}'}, …],
  fb_disable_advanced: false,
  eu_cookie_compliance: false,
  donottrack: true
}
```

`js/facebook_pixel.js` (library `facebook_pixel/facebook_pixel`, `header: true`) computes
`Drupal.facebook_pixel.fb_disable` from those three flags:

* `fb_disable_advanced` → defines `window.fbOptout(reload)` which sets an `fb-disable=true`
  cookie, and reads that cookie into `window['fb-disable']`.
* `eu_cookie_compliance` → disables tracking unless
  `Drupal.eu_cookie_compliance.hasAgreed()`; warns in the console if that JS loaded later.
* `donottrack` → disables tracking when `navigator.doNotTrack` / `navigator.msDoNotTrack` /
  `window.doNotTrack` indicate DNT (unless EU Cookie Compliance already said "agreed").

If not disabled it injects `https://connect.facebook.net/en_US/fbevents.js`, calls
`fbq('init', facebook_pixel_id)`, `fbq('track', 'PageView')` and then replays every queued
event with `fbq('track', event.event, JSON.parse(event.data))`. It re-runs on the
`eu_cookie_compliance.changeStatus` document event, and is guarded by `once()`.

## Firing an event from an Ajax response

```php
use Drupal\facebook_pixel\Ajax\FacebookPixelTrackCommand;

$response = new \Drupal\Core\Ajax\AjaxResponse();
$response->addCommand(new FacebookPixelTrackCommand('Lead', ['value' => '10', 'currency' => 'EUR']));
return $response;
```

The command renders `{command: 'facebook_pixel_track', event: …, data: …}` and attaches the
`facebook_pixel/facebook_pixel_command` library, whose
`Drupal.AjaxCommands.prototype.facebook_pixel_track` calls
`fbq('track', response.event, response.data)`. Note it calls `fbq` directly — the base
library must already have initialised it on that page.

## Inspecting queued events

```bash
drush php:eval 'print_r(\Drupal::service("facebook_pixel.facebook_event")->getEvents());'
```

(Empty on a CLI request, because nothing has rendered a node or inserted a user in that
process; use it inside a request-scoped debug route instead.)
