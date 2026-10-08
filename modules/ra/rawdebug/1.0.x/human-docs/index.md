# RawDebug — manual setup guide

**RawDebug** (`rawdebug`) is a small set of low-level debugging helper functions
for Drupal developers. Its helpers write variables, data, and a stack trace to a
log file so you can inspect what your code is doing during development — a quick,
`dump`-style aid rather than a full step debugger.

What makes RawDebug distinctive is that it is designed to work even when your site
is badly broken. Because it is "mostly just code, not a module," you don't
strictly have to enable it: the recommended setup is to include its `rawdebug.php`
file from your `settings.php`, so its functions are available even if modules
aren't loading. Enabling the module simply adds some help text and defines the
functions if they aren't already defined. Once set up, you get debug functions
such as `rawdebug('label', $val, dbt())` that write a string, a variable, and a
stack trace to a log file.

> **Development only.** RawDebug writes potentially sensitive data (which can
> include personal data or secrets) to a log file, and that log file could be
> exposed. It is meant only for development sites that are **not** publicly
> available. Never leave it set up on production, and remove your debug calls
> before deploying.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, and set it up
   from `settings.php`.

This module has **no configuration page** and no settings form — it is a code
library of debug helpers.

## How to use it

The full setup instructions live in the project's `README.md` (it involves
copying the `rawdebug.php` file and editing `settings.php`). In short:

1. Include `rawdebug.php` from your `settings.php` so the helper functions are
   always defined — even when modules fail to load.
2. In your code, call the debug helpers to log data, for example:

   ```php
   rawdebug('safe_tokens', $val, dbt());
   ```

   This writes a label, the value of `$val`, and a stack trace to the log file.
3. Inspect the log file to see what was captured.

See `rawdebug.php` itself for more detail on the available functions.
