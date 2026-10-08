# Restrict By IP Drush commands

`src/Drush/Commands/RestrictByIpCommands.php`. Primary use is inspection and **lockout recovery** (a
one-time login link does NOT bypass the firewall — the IP check signs you straight back out).

## `restrict_by_ip:status` (alias `rbi:status`)

Shows every configured range (global, optionally a user's, and all role ranges) and, if you pass an IP,
whether that IP matches each and whether a login would be allowed.

```bash
# All configured ranges + whether 203.0.113.5 could log in as admin:
drush restrict_by_ip:status 203.0.113.5 --user=admin
```

Arg `ip` (optional): IP to evaluate. Option `--user=<name>`: also include that user's personal ranges.
The overall allow/deny verdict mirrors `LoginFirewall::isLoginAllowed`. Note: runtime ranges added by
`hook_restrict_by_ip_ranges_alter()` are NOT reflected (config/field only).

## `restrict_by_ip:allow` (alias `rbi:allow`)

Adds an allowed CIDR range to the global login list, or to one user's list.

```bash
# Allow logins from your current public IP site-wide:
drush restrict_by_ip:allow 203.0.113.5/32

# Allow it for one account only:
drush restrict_by_ip:allow 203.0.113.0/24 --user=admin
```

Arg `range` (required): CIDR, validated via `IPTools::validateIP` (invalid → error). Option `--user=<name>`:
append to that user's `restrict_by_ip_ranges` field instead of `login_range` config. Duplicate entries are
detected and skipped.

## Lockout recovery recipe

1. `drush restrict_by_ip:status <your_ip> --user=<you>` to see what is blocking you.
2. `drush restrict_by_ip:allow <your_ip>/32` (or `--user`) to add your IP, or
   `drush config:set --input-format=yaml restrict_by_ip.settings login_range '{}'` to clear the global list.
