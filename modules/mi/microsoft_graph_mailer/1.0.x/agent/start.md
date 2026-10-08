<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Microsoft Graph Mailer — agent index

**Sends and receives email via the Microsoft Graph Mail service** (Azure AD OAuth app). Provides permissions.
Version **1.0.1**. Core `^10||^11`.

Mail/integration — **CAVEAT**: stores the OAuth **`client_secret` in module config** (`microsoft_graph_mailer.settings`,
exported via config-sync) — keep that config **out of version control**, restrict config access, prefer a **Key
entity / env variable**. Grant least Graph permissions (send-only if possible); HTTPS.
