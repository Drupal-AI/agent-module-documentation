# Configuration

Setting up Coffre Fort has two parts: the module settings, and creating and
unlocking a safe.

## Module settings

1. Log in as a user with the **Administer coffre fort** permission.
2. Go to **Configuration → System → Coffre Fort**, or navigate directly to
   `/admin/config/system/coffre_fort`.
3. Set the module-wide options here (for example the default secret-provider
   behaviour), then save.

## Assign permissions

At **People → Permissions**, grant:

- **Administer coffre fort** — to the people who create and manage safes and
  their entries.
- **Unlock coffre fort** — to the operators who need to reveal secret values.

Because unlocking exposes confidential data, keep both permissions narrowly
held.

## Create a safe and add secrets

Safes are managed under `/admin/structure/coffre-fort/...`.

1. **Create a safe** (a `coffre_fort` entity).
2. **Choose a secret provider** for the safe:
   - **Password** — the operator's password unlocks the safe. The password is
     never stored; after unlocking, a 24-hour cookie holds the re-encrypted key
     so the safe stays open for that session.
   - **Vault** — HashiCorp Vault supplies the unlock key.
   - **Keycloak / OpenID** — a Keycloak/OpenID server supplies the unlock key.
3. **Add private data** to the safe — a simple string, a text value, or a number
   (for example an API token). Each item is encrypted with the safe's key.

## Unlock and relock

- **Unlock** the safe (using the chosen provider — e.g. entering the password) to
  read the real secret values.
- While **locked**, the safe shows the configured replacement/placeholder values
  instead of the real secrets.
- **Relock** the safe to hide the secrets again.

Stored private-data names are exposed as **tokens**, so you can reference secrets
from content, blocks, and configuration once a safe is unlocked.

## External provider secrets

If you use the Vault or Keycloak providers, keep *their* connection secrets in
environment variables rather than in Drupal configuration (see
[Installation](../installation/index.md)).
