# Configuration

Enviromage's screens all live under **Configuration → Development → Enviromage**
(`/admin/config/development/enviromage`), and every one requires the **Administer
env settings** permission (marked *restrict access*).

> **This is the only gate on a server‑command‑execution feature.** The Composer
> check runs a real `composer` command on the server. Grant **Administer env
> settings** only to trusted operators — see the note under each section below.

## Permission

Grant **Administer env settings** under **People → Permissions** to the specific
role(s) that should run performance checks. Do not hand it out broadly.

## Settings

The settings form stores two choices (in `enviromage.settings`):

- **PHP directives to read** — which settings the Environment read screen
  displays: `memory_limit`, `max_execution_time`, `realpath_cache_size` /
  `realpath_cache_ttl`, `upload_max_filesize`, `post_max_size`.
- **Modules to size** — which enabled modules the Module sizes screen measures.

Pick what you care about and save.

## Composer check (dry run)

This screen builds a command of the form:

```
composer update drupal/<package>:<constraint> --dry-run --profile
```

- **Package** — chosen from a select list of your module machine names.
- **Version constraint** — validated by Composer's `VersionParser`; if it is
  invalid, the tool falls back to a package‑only or plain update command.

Running it profiles the update — reporting average memory, time, and the counts of
install/update/remove operations — **without applying any changes**, thanks to the
`--dry-run` flag. The command is executed on the server (via `proc_open` from the
project directory), so treat this as a privileged operation: it is admin‑only and
its inputs are constrained, but it still runs Composer on your server. Each run is
recorded in the log.

## Module sizes

This screen recursively measures the on‑disk size of each module you selected in
the settings form, so you can identify oversized modules and see the total
footprint of your chosen set.

## Environment read

This screen reports the current values of the PHP directives you selected in the
settings form — handy for comparing configuration across development, staging, and
production servers.

## Log

The log screen renders the history of your performance checks — the running user,
average memory, time, and operation counts — so you can review past runs.
