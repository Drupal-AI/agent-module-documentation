<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SIBS API — agent index

**Base integration with the SIBS payment API** (client/service layer; underpins SIBS API Commerce). Provides
permissions. Version **1.0.4**. Core `^9||^10||^11`.

Payment/integration base — calls the **SIBS API** (egress) with **merchant credentials/API keys** (store as secrets
— env/Key, HTTPS; they authorize payments); take status from SIBS's authoritative API. Own permissions.
