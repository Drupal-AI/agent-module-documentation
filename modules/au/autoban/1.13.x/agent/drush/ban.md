<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `autoban:ban`

Defined by `Drupal\autoban\Drush\Commands\AutobanCommand` (`drush.services.yml` /
`src/Drush`). Runs the ban logic for one rule or all rules — the same work cron does.

```
drush autoban:ban [rule]
```

- `rule` (optional) — an `autoban` rule **id**. Omit to process **all** rules.

Behavior:
- With a `rule` id: validates the rule exists, then bans the IPs it matches
  (`AutobanController::getBannedIp()` → `banIpList()`), reporting the banned count.
- Without an argument: loops every `autoban` rule, bans per rule, and prints a total.
- Each rule bans through its configured `provider`, so the relevant provider submodule
  (e.g. `autoban_ban`) must be enabled for bans to actually take effect.

Examples:
```bash
drush autoban:ban                 # process every rule (like cron)
drush autoban:ban ban_404_scanners   # process just this rule
```

Use it from a deploy hook or scheduled job to force rule processing outside cron. There is no
alias; the command name is `autoban:ban`.
