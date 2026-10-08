# Configuration

Redsys Button to Drupal is configured at **Configuration → System → Redsys
settings** (`/admin/config/system/redsys-settings`, route
`redsys_button.redsys_config_form`). Because this is a payment gateway, treat the
credentials — and especially the secret key — with care.

## Enter your merchant credentials

On the settings form you provide the details Redsys issues to your merchant
account:

- **Merchant code (FUC)** — the numeric merchant identifier from your bank.
- **Terminal** — the terminal number for the merchant (often `1`).
- **Merchant secret key** — the shared secret used to sign and verify Redsys
  messages. This is the sensitive value; see below for storing it safely.
- **Environment** — choose the Redsys **test** endpoint while you set things up,
  and switch to **production** only once test payments succeed end to end.

Enter the credentials exactly as your bank provides them, then save.

## Handle the secret key safely

The merchant secret key is what makes signatures trustworthy — anyone who has it
can forge payment messages — so keep it out of exported configuration and out of
version control.

1. **Store the value in an environment variable**, never hard‑coded. With DDEV:

   ```bash
   ddev dotenv set .ddev/.env --redsys-merchant-key=<value>
   ddev restart
   ```

   Keep `.ddev/.env` out of version control.

2. **Prefer a Key entity** if you can. Install the
   [Key](https://www.drupal.org/project/key) module
   (`ddev composer require drupal/key && ddev drush en key -y`) and create a key
   backed by the environment provider, so the secret is referenced rather than
   stored in config:

   ```bash
   ddev drush key:save redsys_secret --label='Redsys Merchant Key' \
     --key-type=authentication --key-provider=env \
     --key-provider-settings='{"env_variable":"REDSYS_MERCHANT_KEY","base64_encoded":false,"strip_line_breaks":true}' \
     --key-input=none -y
   ```

   If this version's form doesn't offer a Key selector, at minimum make sure the
   secret you paste in is not committed via exported config, and restrict who can
   read the site's configuration.

3. Whichever route you take, make sure the value only leaves your site to reach
   **Redsys endpoints over HTTPS** — do not send it anywhere else.

## Confirm callback verification

This version signs requests with **HMAC‑SHA256** and includes a *Validators*
component that checks the signature on the payment **notification/return**. That
check is essential: it is what rejects a forged "paid" callback. Before going
live, confirm on the settings form (and by testing) that the notification path is
signature‑validated, so only genuinely paid transactions are treated as paid.

## Test before going live

Run real end‑to‑end payments against the Redsys **test** environment first. Only
switch the **Environment** setting to production once test payments — and their
signed return notifications — behave correctly.
