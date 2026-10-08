<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Past — agent index

Structured **event-logging framework** — logs events with normalized arguments/metadata (queryable, beyond
watchdog text). `past_db`/`past_form` + test submodules. Provides permissions. Version **8.x-1.4**. Core
`^10.1||^11`.

Developer/logging — logged arguments can contain sensitive data (avoid secrets/PII); gate access to event
logs. No content-access role beyond permission.
