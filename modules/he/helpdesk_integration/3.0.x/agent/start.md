<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Helpdesk Integration — agent index

A **framework letting other modules integrate external helpdesk/ticketing systems** (tickets, comments,
attachments). Depends on core `comment`, `file`, `text`. Provides permissions. Version **3.0.1**. Core
`^11.4||^12.0`.

Integration framework — concrete integrations call an **external helpdesk API** (credentials as secrets, HTTPS,
ticket PII); features gated by permissions. No access role beyond permissions.
