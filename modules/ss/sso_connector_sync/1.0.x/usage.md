<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SSO Connector Sync replicates entities/config across sites via HMAC-signed webhooks.

---

SSO Connector – Cross-site Sync replicates entities and configuration across the sites in an SSO Connector network using HMAC-signed webhooks — so content/config changes on one site can be pushed to others securely, keeping a federation of sites in sync.

Security: webhooks are HMAC-signed (integrity/authenticity), so the shared signing secret must be stored securely (env-backed) and kept consistent across sites. Depends on `sso_connector`, core `serialization`, `rest`, and `system`; requires Drupal 11.2+.

---

- Replicate entities across sites.
- Replicate configuration across sites.
- Use HMAC-signed webhooks.
- Keep a site federation in sync.
- Push changes securely.
- Sign webhooks with HMAC.
- Store the signing secret securely (env-backed).
- Keep the secret consistent across sites.
- Depend on `sso_connector` and core `serialization`.
- Depend on core `rest` and `system`.
- Require Drupal 11.2+.
- Support cross-site sync.
- Verify webhook authenticity
- Configure replication
- Sync content/config.
- Support SSO networks.
- Handle webhooks.
- Replicate securely
