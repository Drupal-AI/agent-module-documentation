# ComputerMinds Data Layer — manual setup guide

**ComputerMinds Data Layer** (`cm_data_layer`) is a small developer‑facing module
that lets your server‑side PHP code push events and data into the client‑side
`window.dataLayer` — the JavaScript object that Google Tag Manager and similar tag
managers read. If you've ever wanted to fire a "purchase" or "form submitted" event
into GTM from Drupal without hand‑writing inline `<script>` tags, this is the tool.

It works like Drupal's own messenger service: you call `push()` with your data, the
items are queued, and they're flushed into the page on the **next response**. For a
normal HTML page the payload is attached to `drupalSettings` and a JavaScript
behavior loops each item into `window.dataLayer`; for an AJAX response the module
emits a command that calls `dataLayer.push()` client‑side. Storage adapts to the
visitor — authenticated users get a per‑user `PrivateTempStore`, anonymous
session‑less requests use a static array, and on login any anonymously‑collected
events are migrated into the authenticated store so nothing is lost across the
session change.

This is a **developer's building block, not a point‑and‑click feature.** There is
**no admin UI and no configuration form** — you use it by calling the
`cm_data_layer.data_layer` service from your own module or event subscriber. It has
no dependencies beyond Drupal core and defines no permissions or routes.

One thing worth knowing: data is delivered through `drupalSettings` (JSON‑encoded)
and handed to `dataLayer.push()`; the client behavior never writes it into the page
as raw HTML, so the transport itself is not an XSS sink. However, the module does
**not** filter payload contents — if you push user‑controlled values, you are
responsible for sanitizing them wherever a downstream tag or template eventually
renders them.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

There is **no configuration page** — this module is used entirely from code. See
"How to use it" below.

## How to use it

Call the `cm_data_layer.data_layer` service and hand it an array. Each array item
becomes an individual `dataLayer.push()` call in the browser:

```php
\Drupal::service('cm_data_layer.data_layer')->push([
  'event' => 'myEvent',
  'data' => ['some_key' => 'some_value'],
]);
```

In real code you'll usually inject the service rather than call it statically —
declare `@cm_data_layer.data_layer` as an argument to your own service or event
subscriber and call `$this->dataLayer->push([...])`. A common pattern is to push
from an event subscriber so an analytics event fires after, say, a cart action or a
form submission.

The push signature is `push($data = '', $start_session = FALSE)`. Pass `TRUE` as
the second argument to force session storage (so the data survives to the next
response) even when no session is active yet. Queued events are de‑duplicated and
flushed once, so each event is delivered exactly once. Both full‑page and
AJAX‑driven responses are supported.
