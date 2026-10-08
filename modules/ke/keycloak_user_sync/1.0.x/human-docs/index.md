# Keycloak User Sync — manual setup guide

**Keycloak User Sync** (`keycloak_user_sync`) integrates Drupal with
[Keycloak](https://www.keycloak.org/) to synchronize user data in **real time**.
When a user is created, updated, or deleted in Drupal, the change is reflected in
Keycloak, giving you centralized identity management with Keycloak as the source of
truth for authentication.

It talks to Keycloak's **admin API** using client credentials, creating and updating
users and setting Keycloak "required actions" — such as verify‑email,
update‑password, or verify‑profile — on the accounts it manages. It can also map
**custom fields** from Drupal (User account fields, or fields from the optional
Profile module) to Keycloak attributes, so richer profile data stays in sync too.

A notable design choice: the connection details and client credentials live in your
site's **`settings.php`** (under `keycloak_user_sync.connection` and
`keycloak_user_sync.credentials`), not in exported configuration. That's good for
security — the secret stays out of your config export and version control — but it
means the connection is set up by editing a file, while the **field mappings** are
configured in the admin UI. The client credentials are **privileged** (they can
manage users in your Keycloak realm), so protect `settings.php`, scope the Keycloak
client to least privilege, and always use the HTTPS Keycloak endpoint. The module
depends on core's **User** module, provides its own permissions, and supports Drupal
10.2 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it.
2. [Configuration](configuration/index.md) — set the connection and credentials in
   `settings.php`, then configure field mappings in the admin UI.

## Where it lives in the admin menu

The **field mappings** and options page is at **Configuration → People → Keycloak
User Sync** (`/admin/config/people/keycloak-user-sync`). The **connection and
credentials** are not in the UI — they're defined in `settings.php` (see
[Configuration](configuration/index.md)).
