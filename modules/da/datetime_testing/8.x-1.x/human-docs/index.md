# Datetime testing — manual setup guide

**Datetime testing** (`datetime_testing`) is a developer tool that provides an
**API for writing automated tests involving dates and times**. It lets your tests
set, freeze, and advance Drupal's notion of "now" so that date- and time-dependent
behaviour becomes deterministic and testable.

It works by *decorating* Drupal's core `datetime.time` service — the service that
tells Drupal classes what the current time is — adding methods to alter or freeze
the reported time. It also ships a drop-in replacement for `DrupalDateTime` (and
thus PHP's `\DateTime`) that respects the manipulated "now" when parsing strings,
and a subcontext for the Drupal Extension for Behat so scenarios can say things
like `Given the time is 12pm` or `When "1 hour" passes`. Because the decorated
service persists the manipulated time across requests via Drupal's State API, it is
particularly useful for **functional** tests, where merely mocking the time service
(enough for unit tests) does not carry across page requests.

This is an **API module for developers** — it has no useful effect on its own
without custom test code driving it.

> **Not for production.** The maintainers are explicit that this module is for
> testing purposes only and should not be installed on production sites: it can
> slow performance, and it has **no security advisory coverage**. Enable it on
> local, CI, and test environments only.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, enable
   it in your test environment, and (optionally) wire up its Behat subcontext.

There is **no configuration page** for this module. The only "configuration" is an
optional entry in your project's `behat.yml` so Behat can find the provided
subcontext — see the Installation page.

## How to use it

Once enabled, drive it from your test code. A few illustrative calls from the
module's own documentation:

```php
// Set the current time.
\Drupal::time()->setTime('2008-12-03 09:15pm');
echo \Drupal::time()->getCurrentTime(); // timestamp for that moment

// Freeze time so it stops flowing.
\Drupal::time()->freezeTime();

// Let time flow normally again, then return to core's default behaviour.
\Drupal::time()->unFreezeTime();
\Drupal::time()->resetTime();
```

The same string-parsing logic is available in your own objects via the provided
`TestDateTime` class. See `\Drupal\datetime_testing\TestTimeInterface` and the
other classes in the module for the full API.
