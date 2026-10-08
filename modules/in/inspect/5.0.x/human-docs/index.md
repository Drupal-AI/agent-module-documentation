# Inspect — manual setup guide

**Inspect** (`inspect`) is a **developer debugging tool**. It logs instructive,
well-formatted dumps of variables and deep stack traces — richer and safer than
scattering raw `print_r()` or `var_dump()` calls through your code — so you can
diagnose what a piece of code is actually doing. It analyzes all kinds of
variables safely, produces deep back-traces and error traces, and degrades
gracefully on very large data structures rather than blowing up or timing out.

Developers use it from code through a service, for example
`\Drupal::service('inspect.inspect')->variable($subject)->log('debug', 'Message
prefix')` to dump a variable, or `->trace($throwable)->log()` to log a stack
trace. The output goes to Drupal's logging (it works with database log viewers
and tools like Grafana), so you inspect what happened rather than printing to the
screen. It builds on the standalone SimpleComplex Inspect library and requires
**PHP 8.1+**; it supports Drupal 9, 10, and 11.

**Please treat this as a developer/diagnosis tool, not a production feature.** By
design it dumps runtime data, and dumps and stack traces can reveal sensitive
information — configuration, values held in memory, user data, and the internal
structure of your code. Inspect takes some care here (it hides the values of
buckets keyed `pass`/`password`), but the safest posture is to keep it to
**trusted administrators and developers** and to **avoid enabling it on
production**, or at least strictly limit who can trigger inspection. Its admin
functionality is gated behind the **Administer site configuration** permission,
and it has no access-control role of its own beyond that gate.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Inspect is driven from code rather than from a point-and-click screen. After
enabling it, a developer calls the `inspect.inspect` service to dump a variable or
trace and log the result, then reads the output in **Reports → Recent log
messages** (or whatever log viewer you use). Because the value ends up in the
log, you can gather inspections during real usage — enable logging for the
relevant role, let the site run, then review what was captured — and switch it off
again afterward to avoid flooding the log.

Keep the ability to trigger and see inspections limited to trusted roles, and
remember the guidance above about not leaving this active on a production site.
