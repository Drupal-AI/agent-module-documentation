# Configuration

This module works as a Keycloak provisioning method inside the **User Provisioning**
module, so you configure it through that module's settings under **Configuration →
People**. The exact labels come from the User Provisioning UI; the pieces you set up
are described below.

## 1. Connect to Keycloak

Provide the connection details for your Keycloak server and the **admin API
credentials** (the client ID and secret of a Keycloak client that is allowed to
manage users in your realm). Use the **HTTPS** Keycloak endpoint so credentials and
user data are protected in transit.

> **These are privileged credentials.** A client that can create, update, and delete
> realm users is powerful. Store the secret securely — prefer an **environment
> variable** (for example a DDEV `.ddev/.env` value referenced from `settings.php`)
> over typing a permanent secret into exported configuration — and **scope the
> Keycloak client to the least privilege** it needs.

## 2. Choose a provisioning mode

Pick how changes flow from Drupal to Keycloak:

- **Real‑time** — user create/update/delete in Drupal syncs to Keycloak
  immediately. Best for keeping the two perfectly in step.
- **Manual / on‑demand** — provision selected users when you choose, useful for
  troubleshooting or one‑off fixes.
- **Scheduler / cron‑based** — run synchronization automatically on a schedule.
  Make sure Drupal cron is running for this mode.

You can combine on‑demand runs with a scheduled baseline.

## 3. Map user attributes and roles

Configure how Drupal user fields correspond to Keycloak attributes — name, email,
roles, and any custom profile fields — so records stay consistent across both
systems. Review the **role mapping** carefully: mapping Drupal roles to Keycloak
groups/roles affects what synced users can do, so grant only what each role should
have.

## 4. Monitor with the audit log

The module records create, update, and delete operations. Check its reporting/audit
output to confirm users are syncing as expected and to keep a compliance trail of
identity changes.
