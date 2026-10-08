<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# POST File — agent index

**Upload files through an API endpoint** (`POST /postfile/upload`) into managed storage. Depends on core
`basic_auth`, `file`. Provides permissions. Version **1.0.2**. Core `^10.3||^11`.

Media/integration — **safe**: route is `_access: TRUE` but the controller enforces **non-anonymous +
`postfile upload` permission** in code, rejects insecure extensions, requires the admin allowlist, sanitizes the
name. Grant the perm only to trusted clients; Basic Auth over HTTPS. No broader access role.
