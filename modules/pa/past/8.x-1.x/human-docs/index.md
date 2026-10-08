# Past — manual setup guide

**Past** (`past`) is an extended logging framework for Drupal, designed to record —
and later analyze — complex data structures against a pluggable storage backend.
Where Drupal's core logging (watchdog / dblog) is built around simple, often
translated text messages aimed at end users, Past is built for developers who need
to capture *what actually happened* in a rich, queryable form.

A single log entry in Past is called an **event**, and each event can carry any
number of **arguments** — a scalar, an array, an object, or an exception. Complex
arguments like arrays and objects are broken down and stored element by element (as
"event data") so they can be searched and displayed readably later, rather than
being flattened into an unreadable blob. That makes Past a good fit for auditing
and debugging complicated flows — for example logging the back‑and‑forth of data as
it is received, processed, and forwarded between services.

Beyond ordinary event logging, Past can act as a watchdog replacement, capture
**uncaught exceptions with backtraces**, use a shutdown handler to catch PHP errors
that normal error handling would miss, and even scan PHP `error.log` files for
fatal errors. It also includes a small "bug hunt" UI with TODO / done flags for
working through captured errors, and it can expire old entries so the log does not
grow forever.

Two submodules do the real work: **Past DB** (`past_db`) is the default
database/entity storage backend — the one most sites enable — and **Past Form**
(`past_form`) adds form‑related logging. The framework itself is backend‑agnostic;
you pick a backend by enabling one.

> **Handle logged data with care.** Because Past captures rich arguments, those
> arguments can easily contain sensitive data — secrets, tokens, personal
> information. Avoid logging secrets/PII, and gate access to the event logs, since
> they can reveal internal detail about how your site works.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   framework plus the Past DB backend.
2. [Configuration](configuration/index.md) — where logged events appear, how to
   control who can see them, and expiring old entries.

## How to use it

Past is primarily an API for developers: your custom code logs events through
Past's procedural or object‑oriented interface, attaching whatever arguments are
useful. Once the **Past DB** backend is enabled, those events are stored as
entities and can be listed and inspected in the admin area (and, with the Views
module, listed and filtered in the reports section of your site). See
[Configuration](configuration/index.md) for where the logs live and how to keep
them tidy.
