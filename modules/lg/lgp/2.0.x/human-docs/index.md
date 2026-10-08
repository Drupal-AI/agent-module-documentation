# Lazy Guinea Pig (LGP) — manual setup guide

**Lazy Guinea Pig** (`lgp`) is a small set of **developer debugging helpers**.
You sprinkle a few short function calls into your code while you are chasing a
bug, and each one appends what it found — a variable, a dump, a backtrace — to a
plain text file called the *LGP file* (`lgp.log`) in the system temp directory. A
companion Drush command tails that file live in your terminal, so you watch the
output scroll by as you exercise the site.

It is deliberately low‑tech, and that is the point. It writes to a file rather
than the database, so it has a tiny memory footprint and doesn't add to
`watchdog` noise. It is handy exactly where the usual tools fall short — for
example when Devel's `dsm()` can't render output, or when you need to trace code
that runs too early or too deep (services, early bootstrap hooks) for a
page‑based debugger to help.

A word of caution the project itself makes plainly: **don't use LGP in
production.** It is a dev‑time aid. Enable it in a development environment, add
your debug calls, watch the log, and remove the calls (and the module) before you
ship.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it in
   your dev environment.

There is **no configuration page** for LGP — it has no settings form, routes, or
permissions. You use it entirely from code and the command line, as described
below.

## How to use it

Drop these helpers into any code path you are debugging. Each writes a timestamped
entry (with the calling function, file, and line) to `lgp.log`:

- **`lp($var)`** — logs the variable in `print_r` format. Pass `lp($var, TRUE)`
  to log only an array's keys and value types. Alias: `lfp()`.
- **`ld($var)`** — logs the variable in `var_dump` format. Alias: `lfd()`.
- **`lx($var)`** — logs the variable in `var_export` format. Alias: `lfx()`.
- **`lbt()`** — logs a backtrace (without function arguments by default). Alias:
  `lfbt()`.

Each helper also accepts a `$use_stdout` flag to echo the output instead of
writing it to the file. From `drush ev` you can use the stdout variants directly,
for example:

```bash
drush ev "_lp(user_load(1))"
```

To watch the log as it fills up, run the console watcher:

```bash
drush lg-console   # or the alias: drush lgc
```

It continuously tails new lines from `lgp.log`. (On Windows you'll need a Unix
`tail`, via Cygwin or similar.) You can find the exact path to the log file on the
site's **Status report** (`/admin/reports/status`). If you ever need to relocate
the log, the temp directory is derived from the standard `TMP`/`TEMP`/`TMPDIR`
environment and can be overridden through the `lgp_temp_dir_func` state callable.
