<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Single Page Protection — agent index

**Password-protects specific pages** — a `KernelEvents::REQUEST` subscriber redirects to a password
form until the password is entered (session-tracked); password compare uses **`hash_equals()`**
(constant-time). Machine name `single_page_protection`. Depends on core `system`, `filter`. Config at
`single_page_protection.admin_settings`; provides permissions. Version **1.0.10**. Core `^10||^11`.

Reasonably built (request-level gate, not display-only). **Caveat: path-based** — gates configured
paths, not entity/data access; for true confidentiality ensure content isn't reachable via other routes
(canonical vs alias, JSON:API/REST, feeds) and back it with entity access.
