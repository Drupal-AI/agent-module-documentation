<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Varbase API — agent index

**JSON:API web-services layer** with authentication/authorization for the **Varbase** distribution —
lets external apps ingest content. Settings at `varbase_api.settings`. Version **10.1.1**. Core
`~11.4.0`.

**Security surface:** which entities/operations are exposed and the auth/roles required — review the
JSON:API/OAuth config before public exposure. Provides admin permissions; expects the Varbase
ecosystem.
