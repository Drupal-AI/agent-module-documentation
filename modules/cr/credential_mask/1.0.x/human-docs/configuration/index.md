# Configuration

Configuring Credential Mask means building a list of the configuration properties
you want kept out of exports. There are two ways to manage that list — a small admin
page and a set of Drush commands — and they edit the same underlying
`credential_mask.sensitive_config` list. **Anything you do not add to the list is
still exported normally**, so the completeness of this list is what determines how
well your secrets are protected.

## Manage sensitive keys from the admin page

1. Log in as a user with the **Import configuration** permission (an administrator
   by default).
2. Go to **Configuration → Development → Configuration synchronization → Credential
   mask**, or navigate directly to
   `/admin/config/development/configuration/credential_mask`.

On this page you add and remove the configuration properties that should be treated
as sensitive. Each entry identifies a configuration object and the property within
it that holds the secret (for example the API-key field of a particular module's
settings). Once a property is on the list, its value is masked on export and its
real value is preserved (not overwritten) on import.

## Manage sensitive keys from Drush

If you prefer the command line — or want to script this as part of a deployment —
the module ships four Drush commands (Drush 10+):

| Command | What it does |
|---------|--------------|
| `drush credential_mask:add` | Mark a configuration key as sensitive so it is masked on export. |
| `drush credential_mask:del` | Remove a configuration key from the masked list. |
| `drush credential_mask:list` | List all configuration properties currently marked as sensitive. |
| `drush credential_mask:show-configuration` | Show the configuration names and properties currently marked as sensitive. |

## How masking behaves

- **On export** (`drush config:export`) — the value of each listed property is
  replaced with a masked placeholder in the written YAML, so the real secret never
  reaches your repository.
- **On import** (`drush config:import`) — the masked placeholder does **not**
  overwrite the live value already stored on the site, so importing config from Git
  will not wipe out a real secret that is set in the environment.

## A note on scope

Credential Mask reduces one very common leak channel, but treat it as one layer of
protection rather than the whole answer. The most robust approach is to keep secrets
out of configuration altogether — supply them through environment variables or the
Key module — and use Credential Mask as a safety net for the cases where a secret
would otherwise be written into exported config.
