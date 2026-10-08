<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SSO Connector – Cross-site Sync — agent index

**Cross-site entity/config replication** over HMAC-signed webhooks. Version **1.0.1**. Core `^11.2||^12`.

Webhooks HMAC-signed (positive); shared secret env-backed + consistent across sites. Depends on `sso_connector`, core `serialization`/`rest`/`system`.