# Deployment identifier status — manual setup guide

**Deployment identifier status** (`dis`) is a tiny helper that adds one check to
Drupal's status report: it warns you when the site's **deployment identifier** is
not set. That is the whole module — no routes, no permissions, no configuration
screen, not even a `src/` directory.

The deployment identifier is one of those settings that does nothing visible until
it is missing. Drupal folds it into the service container's cache key, so changing
it on every deploy guarantees that the container, plugin definitions, and other
bootstrap-level caches are rebuilt for the new code — exactly what you want when a
release changes a service definition or adds a plugin. Without it, a deployment can
leave a stale container in place and produce failures that look random: a service
that "does not exist," a plugin that "is not found," behaviour that mysteriously
reverts after a cache clear.

Most sites never set the identifier, and nothing tells them. That is the gap this
module fills — it surfaces the omission right next to every other environment
warning on `/admin/reports/status`, where an ops team already looks. The check
costs almost nothing, and the failure mode it warns about is expensive to diagnose
from symptoms alone.

It runs on Drupal 9, 10, and 11 and needs nothing but core.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.

There is **no configuration page** for this module. Its only job is to raise a
warning; you clear that warning by setting the deployment identifier in
`settings.php`, described below.

## How to use it

After enabling, visit **Reports → Status report**
(`/admin/reports/status`). If the deployment identifier is unset, you will see a
warning there.

To clear it, set the value in `settings.php` from something that changes with every
release — a git commit SHA, a build number, or a timestamp injected by your
deployment pipeline. For example:

```php
$settings['deployment_identifier'] = 'my-build-123';
```

Once the identifier is present, the warning disappears. The point is that the value
should *change per release*, so wire it into your pipeline rather than hard-coding a
constant.
