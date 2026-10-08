# Configuration

Two steps: tell the module how to reach your vault, then create a Key whose value is
pulled from it.

## 1. Configure the vault connection

Open the module's admin form (route `azvault.admin`) and enter your vault's details —
the vault name/URL and how the site should authenticate to Azure.

### The bootstrap credential — store it securely

To open the vault the module must authenticate to Azure. There are two approaches, and
the choice matters:

- **Managed identity (preferred).** If Drupal runs on Azure infrastructure that
  supports managed identity, use it — Azure hands the site a token automatically and
  **no secret is stored anywhere**. This is the safest option.
- **Service principal (client ID + secret).** If you must use an app registration,
  the client secret is exactly the value that unlocks every other secret in the vault,
  so treat it as your most sensitive credential. Do **not** put it in exported
  configuration. Supply it from the environment:

  ```bash
  ddev dotenv set .ddev/.env --azure-vault-client-secret=<value>
  ddev restart
  ```

  (The flag becomes the variable `AZURE_VAULT_CLIENT_SECRET`. Never commit
  `.ddev/.env`.) Reference it from Drupal via `getenv('AZURE_VAULT_CLIENT_SECRET')`,
  or a Key entity backed by the env provider.

Secrets are fetched from the vault over TLS.

## 2. Create a vault‑backed Key

With the **Azure Key Vault Key Provider** submodule enabled, go to **Configuration →
System → Keys** (`/admin/config/system/keys`) and **Add key**. Choose the Azure Key
Vault provider and point the key at the secret's name in your vault. From then on any
module that reads that Key entity gets its value straight from Azure Key Vault, never
from committed config.

## Why this is the recommended pattern

Keeping secrets in the vault — fetched at runtime over TLS, never written into
configuration or the codebase — is the whole point of the module. The only thing you
must protect yourself is the one bootstrap credential above; managed identity removes
even that.
