<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Salesforce Client credentials Auth Provider — agent index

Provides an **OAuth client-credentials flow auth plugin** for the Salesforce Suite (server-to-server API
auth, no user context). Config at `salesforce.auth_config`. Version **1.1.0**. Core `^9||^10||^11`.

**Security:** store the **consumer key/secret** as **secrets** (not exported config); HTTPS; grant the
connected app **minimum** Salesforce permissions. No access role.
