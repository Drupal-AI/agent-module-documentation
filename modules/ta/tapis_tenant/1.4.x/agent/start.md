<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# TAPIS Tenant — agent index

**Manages TAPIS tenant configuration and credentials**. Stores credentials via **`key`**. Depends on core `node`,
`field`, `content_moderation`. Provides permissions. Version **1.4.1-beta2**. Core `^10||^11`.

Integration-configuration foundation — holds **tenant credentials/secrets**, stored via the **Key module**
(positive); keep keys secured (env/Key), HTTPS. Own permissions.
