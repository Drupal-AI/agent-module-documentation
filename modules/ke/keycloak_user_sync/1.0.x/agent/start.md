<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Keycloak User Sync — agent index

**Syncs Drupal users with Keycloak SSO** via the Keycloak admin API (create/update users, set required
actions). Connection + client credentials in **settings.php** (`keycloak_user_sync.connection`/`.credentials`).
Depends on core `user`. Provides permissions. Version **1.0.11**. Core `^10.2||^11`.

Auth/identity integration — creds in **settings.php** (good, not exported config); Guzzle **TLS on**. Holds a
**privileged Keycloak client** (can manage realm users): protect settings.php, least-privilege the client,
HTTPS endpoint. No Drupal access role beyond permission.
