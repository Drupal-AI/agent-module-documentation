<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CrowdSec Drush commands

Class `Drupal\crowdsec\Drush\Commands\CrowdSecCommands` (Drush attribute style).

| Command | Args | Effect |
|---|---|---|
| `crowdsec:enroll` | `name` `enrollkey` | Enroll this instance into a CrowdSec console account (`watcher()->enroll()`). |
| `crowdsec:signal` | — | Push buffered signals upstream now (`Buffer::push()`). |
| `crowdsec:collect` | — | Download/refresh subscribed blocklists (`Client::refresh()`). |
| `crowdsec:test:signal` | `ip` | Send a test signal banning `ip` using the `flood` scenario. |
| `crowdsec:test:ip` | `ip` | Verify/print the current remediation decision for `ip`. |

```bash
drush crowdsec:enroll "My Drupal site" <ENROLL_KEY>
drush crowdsec:signal
drush crowdsec:collect
drush crowdsec:test:signal 1.2.3.4
drush crowdsec:test:ip 1.2.3.4
```

The signal-push and blocklist-refresh also run automatically on `hook_cron()`.

Note: on a site with no live CrowdSec API/agent (like this documentation site) the enroll/signal/collect
/test commands will fail to reach CrowdSec; they are still the correct commands to name.
