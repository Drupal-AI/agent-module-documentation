# Configuration

Configuration happens in two places: the **connection and credentials** go in
`settings.php`, and the **field mappings and options** are set in the admin UI.

## 1. Set the connection and credentials in settings.php

The Keycloak URL and the client credentials are defined as `$settings` values in
your site's `settings.php` — deliberately kept out of exported configuration so the
secret never lands in your config export or version control. Add the connection and
credentials arrays:

```php
$settings['keycloak_user_sync.connection'] = [
  // Keycloak base URL, realm, etc. — use the HTTPS endpoint.
];
$settings['keycloak_user_sync.credentials'] = [
  // Client ID and secret for a client that can manage realm users.
];
```

Consult the module's `README.md` for the exact keys each array expects.

> **Protect these credentials.** The client can create and update users in your
> Keycloak realm, so:
> - Keep **`settings.php` protected** (correct file permissions, never in a
>   web‑readable location, never committed with real secrets).
> - Better still, read the secret from an **environment variable** — with DDEV,
>   `ddev dotenv set .ddev/.env --keycloak-client-secret=<value>` (never commit
>   `.ddev/.env`) and reference it via `getenv()` in `settings.php`.
> - **Scope the Keycloak client** to the least privilege it needs.
> - Always use the **HTTPS** Keycloak endpoint.

## 2. Configure field mappings in the admin UI

1. Log in as a user with the module's administration permission.
2. Go to **Configuration → People → Keycloak User Sync**
   (`/admin/config/people/keycloak-user-sync`).
3. Set up the **field mappings** — map Drupal user account fields (and, if you use
   the Profile module, profile fields) to the corresponding Keycloak attributes.
4. Enable the options you need, such as **custom field updates** and **default
   actions applied to new users** on login.
5. Save.

## How the sync behaves

With the connection configured and mappings in place, user **create, update, and
delete** actions in Drupal are pushed to Keycloak via its admin API in real time.
The module can also set Keycloak **required actions** (verify email, update password,
verify profile, and so on) on the accounts it manages, so new users complete the
right steps on their next Keycloak login.
