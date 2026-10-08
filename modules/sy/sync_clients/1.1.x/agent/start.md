<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Sync Clients — agent index

**Base module for data sync to/from a remote, using AdvancedQueue and a custom Sync API**. Depends on
`advancedqueue`, core `mysql`. Provides permissions. Version **1.1.0-beta6**. Core `^11`.

Developer/integration framework — **exchanges data with a remote** (egress/ingress; may include PII); **remote
credentials** as secrets (env/Key, HTTPS); validate received data. Own permissions.
