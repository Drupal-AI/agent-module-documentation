# Devel Debug Log — manual setup guide

**Devel Debug Log** (`devel_debug_log`) is a small developer‑only aid for stashing
ad‑hoc debug output and reading it later on a dedicated admin page, instead of
relying on on‑screen messages or the watchdog log. You drop a `ddl()` call into
your code, trigger the code path, and then go read what it captured at **Reports →
Debug messages**.

It really shines when the usual debugging output would be hard to see — inside an
**AJAX** response, a **redirect**, a **subrequest**, a **cron** or Drush run, a
**queue/batch** worker, or **Twig** rendering. In all those places `dpm()` or
`\Drupal::messenger()` output tends to vanish or never reach the browser. Devel
Debug Log persists across requests, so you can fire an AJAX call and calmly read
what happened afterward, then clear it all with one button before the next test.

Array and object arguments are pretty‑printed through Devel's dumper (Kint by
default), so you get readable, formatted output for complex data. There is a
companion `ddl_once()` that skips writing if the same message was already logged
during the current request (handy inside loops), and a `ddl()` Twig function for
dumping template values.

Because it writes to a raw table and renders stored markup on an admin page, this
is strictly a **debugging tool for development environments** — it is not something
to leave enabled on a production site, and it has no end‑user features.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module (and its Devel
   dependency) with Composer and enable it.

## Where it lives in the admin menu

There is **no settings page**. The collected messages appear at **Reports → Debug
messages** (`/admin/reports/debug`), gated by the **Access debug messages**
permission. That same page has a **Clear log messages** button that empties the
log.

## How to use it

### From PHP

`ddl()` and `ddl_once()` are global functions — no service or `use` statement,
just call them anywhere your code runs (a module, hook, service, controller, and so
on):

```php
ddl($some_value, 'A title');            // titled entry
ddl($entity);                           // untitled entry
ddl(['a' => 1, 'b' => 2], 'my array');  // array/object → pretty-printed (Kint)

foreach ($items as $item) {
  ddl_once($item->type, 'item types seen'); // one row per distinct value this request
}
```

Each `ddl()` call appends a row (with a timestamp, optional title, and the rendered
message). `ddl_once()` is the same but de‑duplicates identical messages within a
single request.

### From Twig

A `ddl()` Twig function is available, but it stays inert unless Twig debug is
enabled (`twig.config: { debug: true }` in your `services.yml`):

```twig
{{ ddl(node.field_foo.value, 'field_foo') }}   {# log one value with a title #}
{{ ddl(node) }}                                 {# log one value #}
{{ ddl() }}                                     {# no args → dumps the whole Twig context #}
```

### Read and clear

Go to **Reports → Debug messages** to see the entries newest‑first with a pager.
Click **Clear log messages** to wipe the whole log before a fresh test run. Grant
the **Access debug messages** permission only to trusted developer roles — note
that whoever can view the page can also clear it, and stored messages may contain
dumped entities, config, or service state.
