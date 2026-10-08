<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Drush: `pantheon-secrets:sync`

The module registers exactly one Drush command (`drush.services.yml` →
`\Drupal\pantheon_secrets\Commands\PantheonSecretsCommands`, injected with
`@pantheon_secrets.secrets_syncer`).

| Command | Aliases | Arguments/options | Effect |
|---|---|---|---|
| `pantheon-secrets:sync` | none | none | Creates a Key entity for every Pantheon secret not already referenced by a `pantheon`-provider key |

```bash
# on Pantheon
terminus drush <site>.<env> -- pantheon-secrets:sync

# locally / inside a container
drush pantheon-secrets:sync
```

Output:

- `Synced secrets: <id1>, <id2>` (success) when new keys were created;
- `No new secrets to sync.` (notice) when everything already exists — exit code 0 either way;
- `An error ocurred adding secrets: <message>` (error, exit code 1) if the syncer throws.

It is **idempotent** — re-running it never duplicates or overwrites a key. It only *adds*;
it never removes keys for secrets that disappeared from Pantheon, and it never changes the
`key_type` of an existing key.

The command does exactly what the **Sync Keys** button on
`/admin/config/system/keys/pantheon` does; both call
`\Drupal::service('pantheon_secrets.secrets_syncer')->sync()`.
