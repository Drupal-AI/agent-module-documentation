# Configuration

You configure this module by creating a **Key** entity that uses the **HashiCorp
Vault** provider. There is no separate settings page; everything happens on the
Key module's forms at **Configuration → System → Keys**
(`/admin/config/system/keys`).

## Before you start: handle the Vault credentials safely

This module connects Drupal to your secret store, so its own connection details
are themselves sensitive. Follow these rules:

- **Never hard-code or commit the Vault address or auth token.** Keep them out of
  `settings.php` literals, out of exported configuration, and out of version
  control.
- **Store them in environment variables.** With DDEV, set them once with the
  built-in dotenv command and restart so the container picks them up:

  ```bash
  ddev dotenv set .ddev/.env --vault-addr=https://vault.example.com --vault-token=<token>
  ddev restart
  ```

  The flags `--vault-addr` and `--vault-token` become the variables `VAULT_ADDR`
  and `VAULT_TOKEN`. Keep `.ddev/.env` out of version control.
- **Always use HTTPS** for the Vault address so the token and secrets are
  encrypted in transit.
- Give the token the **least privilege** it needs — read access to just the KV
  paths Drupal must reach.

## Create a Vault-backed Key

1. Log in as an administrator and go to **Configuration → System → Keys → Add
   key** (`/admin/config/system/keys/add`).
2. Give the key a **Name** and, optionally, a description.
3. Choose the appropriate **Key type** for what the secret is (for example an
   authentication token or an encryption key).
4. Under **Key provider**, select **HashiCorp Vault**.
5. Fill in the provider settings so Drupal can reach the secret in your Vault KV
   engine — the Vault address, the auth token, and the KV path/field that holds
   the value. Wherever the form lets you reference an environment variable rather
   than typing a secret inline, do that so the actual values stay in the
   environment (see above).
6. Save.

From now on, anything in Drupal that consumes this Key — encryption,
authentication, an API integration — reads the current value straight from Vault
at runtime, and the secret itself never lives in Drupal's config or state.

## Rotating and revoking

Because the value lives in Vault, rotating a secret is done **in Vault**: update
the value at its KV path and Drupal will resolve the new value on its next read.
If the Vault auth token itself changes, update the environment variable and (with
DDEV) `ddev restart`. Revoking Drupal's access is a matter of revoking or
narrowing the token in Vault.
