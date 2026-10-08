<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush commands

Provided by `Drupal\nagios\Commands\NagiosCommands` (`drush.services.yml`). They run the same
checks as the web status page from the CLI and **exit with the Nagios severity code**
(0 OK, 1 Warning, 2 Critical, 3 Unknown), so they can be wired into cron/NRPE.

| Command | Purpose |
|---|---|
| `drush nagios [check]` | Run all checks (or a single named `check`/module) and print the one-line status; return code = severity. |
| `drush nagios-list` | List all valid checks (built-ins + modules implementing `hook_nagios`/`hook_nagios_info`), as a table (`check`, `description`, `module`). |
| `drush nagios-updates [type]` | Report pending updates (`type` e.g. `all`); requires core's **update** module (`drush en update` if disabled). |

Examples:

```bash
drush nagios                 # full health line, exit code = worst severity
drush nagios cron            # only the 'cron' check
drush nagios-list            # discover available checks
drush nagios-updates all     # pending module/theme updates
echo $?                      # inspect the Nagios exit code
```

Notes:
- `drush nagios` warns if checks are run as a different OS user than the web server (file
  permission checks depend on the running user); clear with `drush state:delete nagios.os_user`.
- Legacy Drush 8 callbacks also exist in `nagios.drush.inc` (`nagios-list`, `nagios-check`,
  `nagios-updates`); the service-based `NagiosCommands` is used on modern Drush.
