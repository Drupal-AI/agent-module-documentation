# Drush commands

Defined in `src/Drush/Commands/PurgeControlCommands.php` (final class extending `DrushCommands`,
auto-discovered via `AutowireTrait`; injects the `purge_control.purge_control` service). Requires
Drush `^12 || ^13` (composer conflicts with `< 12.5.1`).

One command, `purge-control` (alias `pc`), taking a single positional `op` argument. Each operation
accepts a long form or a short alias; both map to the same service call.

| `op` value(s) | Service call | Effect | Notice |
|---|---|---|---|
| `enable-purge` / `enp` | `enablePurge()` | `disable_purge = FALSE` (resume purging) | "Purging is enabled." |
| `disable-purge` / `disp` | `disablePurge()` | `disable_purge = TRUE` (pause purging) | "Purging is disabled." |
| `enable-automation` / `ena` | `setAutomation(TRUE)` | `purge_auto_control = TRUE` | "Automated purge control is enabled." |
| `disable-automation` / `disa` | `setAutomation(FALSE)` | `purge_auto_control = FALSE` | "Automated purge control is disabled." |
| anything else | — | none | error "Invalid operation." |

Note: `enable-purge`/`disable-purge` call `enablePurge()`/`disablePurge()` directly (unconditional),
whereas the `autoEnablePurge()`/`autoDisablePurge()` service methods used by cron and the pre/post
hook pattern are gated by the automation flag. The Drush command never calls the auto-gated methods.

## Deployment / migration recipe (from README)

```
# Before the release: stop cron auto-recovery, then pause purging
drush pc disa
drush pc disp

# ... run the deployment / migration / bulk resave ...

# After: resume, then flush the external cache in one shot
drush pc ena
drush pc enp
drush pqe            # purge:queue-empty
drush pqa everything # purge:queue-add an "everything" invalidation
drush pqw            # purge:queue-work — process the queue
```

`drush pc --help` (em-dash in the README is cosmetic) prints the usage list. `pqe`/`pqa`/`pqw` are
Purge module commands, not part of this module.
