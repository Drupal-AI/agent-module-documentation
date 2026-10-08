# State Expirable — manual setup guide

**State Expirable** (`state_expirable`) is a small developer building block that
adds expiration (a TTL) to Drupal's State API. Core's `State` service persists
key/value data indefinitely; this module's `state_expirable.state` service offers
the same familiar surface — `get`, `set`, `getMultiple`, `setMultiple`, `delete` —
but lets you set values that automatically disappear once their time-to-live
elapses. Under the hood it combines core's `keyvalue` and `keyvalue.expirable`
stores, and the expirable backend handles dropping expired values for you.

It is meant for code, not clicks. There are **no routes, permissions, forms, or
admin UI** — you enable the module and then inject the service (or fetch it with
`\Drupal::service('state_expirable.state')`) from your own custom code. It's the
right tool when you need short-lived server-side state — transient feature flags,
rate-limit windows, cached remote lookups, a self-cleaning "last run" marker —
without abusing the cache system or leaving stale permanent State keys lying
around forever.

Because there is no request surface, the security posture is neutral: the service
is only reachable from server-side PHP that already holds a reference to it;
nothing anonymous can reach it.

This guide is written for a **human**. Since the module is purely a developer API,
an AI coding agent will get more from the sibling [`agent/`](../agent/start.md)
docs, which include the exact method signatures.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

After enabling, inject or fetch the service and use it like core's State, but with
a TTL argument on writes:

```php
$state = \Drupal::service('state_expirable.state'); // or inject the service
$state->set('mymodule.flag', 'on', 3600);   // expires in 1 hour
$value = $state->get('mymodule.flag', $default);
$state->setMultiple(['a' => 1, 'b' => 2], 300);
$vals = $state->getMultiple(['a', 'b']);
$state->delete('mymodule.flag');
```

There is nothing to configure in the UI — enabling the module and using the
service is the whole setup.
