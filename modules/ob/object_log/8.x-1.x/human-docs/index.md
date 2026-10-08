# Object Log — manual setup guide

**Object Log** (`object_log`) is a developer debugging companion for the
[Devel](https://www.drupal.org/project/devel) module. It lets you stash the
contents of any variable — an object, an array, whatever you're wrestling with —
under a label, and then inspect it later from an admin report page. Think of it as
`dpm()` or `kprint_r()` that persists: instead of dumping a value into the message
area for a single request, you store it and come back to it whenever you like.

That persistence is exactly what makes it useful for the cases where inline dumping
falls short — debugging **server‑to‑server requests, cron runs, web services, or
requests made by anonymous and other unprivileged users**, where there's no
convenient screen to print to. You can even display two stored objects side by side
to compare them.

You use it from code. Wherever you'd like to capture a value, call the
`object_log()` helper:

```php
object_log($label, $data);
```

`$label` is a name for the entry and `$data` is the variable to store. Storing a
new value under an existing label overwrites that entry. Stored values are then
viewable at **Reports → Object log** (`/admin/reports/object_log`) by any user with
Devel's **access devel information** permission.

Because entries are only ever written by developer code (there is no web‑facing
write path) and the report pages require the developer‑only *access devel
information* permission, the stored data is not attacker‑writable. Like Devel
itself, this is a development tool — **keep it disabled on production**.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer alongside Devel
   and enable the module.

There is **no configuration page** for this module — it has no settings form. You
use it entirely from code and from the report page described above.

## Where it lives in the admin menu

Object Log adds a report at **Reports → Object log**
(`/admin/reports/object_log`), with a detail view at
`/admin/reports/object_log/{label}`. Both are gated by Devel's **access devel
information** permission. On the detail page you can select a second stored object
to view both side by side, and there is a form to clear the log when you're done.
