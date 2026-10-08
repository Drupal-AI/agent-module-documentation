<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Simple Integrations — agent index

Developer framework: **Integration** config entities (endpoint, auth type, credentials, cert, timeout) + a Guzzle-based `ConnectionClient`/`ConnectionClientFactory` that auto-applies config and credentials and refuses inactive integrations. Admin 'test connection' action at `/admin/config/integrations/{integration}/test-connection`. Version **2.1.0**, core 8–10.

Permissions: `view integrations`, `administer integrations` (restricted), `test integration connections`. Endpoints/creds admin-configured; Guzzle default TLS; creds stored in config. No user-controlled SSRF.