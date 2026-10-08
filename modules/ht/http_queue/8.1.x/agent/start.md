<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# HTTP Queue — agent index

**Queues and processes outbound HTTP requests via Advanced Queue** (async, retryable external calls). Depends
on `advancedqueue`. Version **8.1.6**. Core `^8||^9||^10||^11`.

Developer/integration — outbound requests use the enqueuing code's URLs/credentials: ensure only **trusted
code** enqueues, credentials as secrets, HTTPS, guard **SSRF** if URLs come from input. No access role.
