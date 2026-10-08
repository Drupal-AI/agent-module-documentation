<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP client logger — agent index

**Logs Guzzle HTTP requests/responses (debug)**. Version **1.0.x-dev**. Core `^10||^11`.

**SECURITY NOTE:** logs full headers/bodies UNREDACTED → `Authorization`/API-key secrets land in dblog. Dev-only; NEVER run in production.