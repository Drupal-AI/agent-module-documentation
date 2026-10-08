<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Keycloak User Sync syncs Drupal users with Keycloak SSO.

---

Keycloak User Sync **synchronizes Drupal users with Keycloak** (the open-source SSO/identity server) — it
talks to Keycloak's admin API with client credentials to create/update users and set required actions
(verify-email, update-password, verify-profile, etc.), keeping the two user stores in sync. Connection and
credentials are configured in **settings.php** (`keycloak_user_sync.connection` / `.credentials`). It depends
on core User, provides its own permissions.

Use it to bridge Drupal accounts to Keycloak. It is an authentication/identity integration. Security posture
is reasonable: credentials live in **settings.php** (a Key/secret store, not exported config — good) and it
uses Guzzle (**TLS verification on by default**) to reach the Keycloak URL. But note it holds a **privileged
Keycloak client** (client credentials that can manage users in the realm — a powerful capability): keep
settings.php protected, scope the Keycloak client to the least privilege needed, and use the **HTTPS** Keycloak
endpoint. It has no Drupal access-control role beyond its permission. Configure the connection and
credentials in settings.php.

---

- Sync Drupal users with Keycloak.
- Create/update users via the Keycloak admin API.
- Set required actions (verify email, etc.).
- Configure connection/credentials in settings.php.
- Use Guzzle (TLS verification on).
- Depend on core User.
- STORE credentials in settings.php (not exported config).
- KNOW it holds a privileged Keycloak client.
- Scope the Keycloak client to least privilege.
- Use the HTTPS Keycloak endpoint.
- Provide its own permissions.
- Configure the connection.
- Handle user sync.
- Sync accounts.
- Bridge to Keycloak.
- Handle SSO sync.
- Configure credentials.
- Sync users.
- Protect settings.php.
- Provide Keycloak sync.
