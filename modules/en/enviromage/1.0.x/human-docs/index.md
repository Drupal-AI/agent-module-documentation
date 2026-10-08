# Enviromage — manual setup guide

**Enviromage** (`enviromage`) is a developer and performance dashboard that helps
you assess whether a Drupal site is ready for an update *before* you run one for
real. It can run a **dry‑run `composer update`** and profile its memory and time
cost, report the **on‑disk size** of your enabled modules, and read selected **PHP
environment settings** (memory limit, execution time, upload limits, and so on).

The typical use is planning a maintenance window: point it at a module, simulate
the update, and see the projected memory usage, time, and install/update/remove
counts without actually changing any files or the database. The module sizes help
you spot oversized modules bloating the codebase, and the environment read lets
you compare PHP configuration across servers. Results are logged so you can browse
the history of your performance checks.

> **Security note — a privileged, admin‑only feature.** The Composer check works
> by building a command like `composer update drupal/<package>:<constraint>
> --dry-run --profile` and executing it on the server. This is intentional
> server‑command execution. It is gated **only** by the admin‑only **Administer
> env settings** permission (marked *restrict access*), and its two inputs are
> constrained (the version constraint is validated by Composer's version parser
> and the package comes from a fixed select list), so it is not reachable by
> non‑admins and not trivially injectable — but it remains a privileged surface.
> **Grant the permission only to trusted operators.** The `--dry-run` flag means
> the check simulates rather than applies changes.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module together with its Automatic Updates dependency.
2. [Configuration](configuration/index.md) — the settings form, the dry‑run
   Composer check, module sizes, environment read, and the log.

## Where it lives in the admin menu

All of Enviromage's screens live under **Configuration → Development → Enviromage**
(`/admin/config/development/enviromage`), and every one of them requires the
**Administer env settings** permission.
