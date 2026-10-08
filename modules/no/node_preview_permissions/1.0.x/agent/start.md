<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Node Preview Permissions — agent index

**Gates node-preview access by permission** (`use node preview` / `use <bundle> node preview`) — grant preview
to roles without edit access. Depends on core `node`. Provides permissions. Version **1.0.4**. Core `^9||^10||^11`.

Access/editorial — a preview object lives in the **previewing user's own private tempstore** (session-scoped),
so this controls use of the feature on **your own** preview; it does **not** expose other users' drafts. No
other access role.
