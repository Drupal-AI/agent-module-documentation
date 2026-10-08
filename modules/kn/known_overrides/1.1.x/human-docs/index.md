# Known Overrides — manual setup guide

**Known Overrides** (`known_overrides`) is a small reporting tool that answers one
confusing question: *which of my configuration values are being overridden by
`settings.php`?* Configuration overrides are how a Drupal site differs per
environment — a development mail transport, a disabled cache, a different API
endpoint, a search server pointing at a local instance. They work invisibly by
design, and that is exactly the problem: the configuration UI shows the **stored**
value while the site actually runs on the **overridden** one. An administrator can
change a setting, see it saved, and have nothing happen — one of the most
confusing situations in Drupal, and worst on hosting platforms that inject
overrides for you.

Known Overrides surfaces these at a **report** page, comparing your editable
configuration against the values `settings.php` is really using and showing only
the differences. You declare which overrides you *expect* by listing their
configuration names in a `$settings['knownOverrides']` array, so the report can
separate **"this is deliberate"** from **"where did this come from?"**. The classic
example is a module like *Mail Safety*: its settings form shows email sending as
enabled, but a `settings.local.php` override has actually switched it — and Known
Overrides makes that override visible instead of leaving you to panic.

The report lives at `/admin/reports/known-overrides` behind a dedicated **`known
overrides report`** permission that is marked *restrict access*, and its route is
`no_cache` so it always reads live state. That restriction is deliberate: an
override report is effectively a **map of how this environment differs from the
codebase** — endpoint hostnames, service names, feature flags, deployment shape.
None of that is secret if you keep real secrets in environment variables, but it
is still a useful map for someone who shouldn't have it, so grant the permission
sparingly.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable it, and
   declare your expected overrides in `settings.php`.

There is **no settings form** for this module. Its "configuration" is code you
add to `settings.php` / `settings.local.php`, described under "How to set it up"
below and in the installation guide.

## Where it lives in the admin menu

Known Overrides adds one page: **Reports → Known Overrides Report**
(`/admin/reports/known-overrides`), visible to users with the **`known overrides
report`** permission.

## How to set it up

The setup is a small edit to your `settings.local.php` (or `settings.php`). After
the opening `<?php` line, make sure the `knownOverrides` array exists, then add
each config override you apply and register its config name:

```php
if (!isset($settings['knownOverrides'])) {
  $settings['knownOverrides'] = [];
}

// Your config override.
$config['mail_safety.settings']['enabled'] = TRUE;

// Register the config name so the report knows this override is expected.
$settings['knownOverrides'][] = 'mail_safety.settings';
```

Each config name listed in `$settings['knownOverrides']` is compared against the
editable configuration, and any differences are reported at
`/admin/reports/known-overrides`. That way the report distinguishes overrides you
put there on purpose from ones you didn't expect.
