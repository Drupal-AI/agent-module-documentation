<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Salesforce Status — agent index

Manages **Salesforce sync status and dispatches events** for other modules to react to (`salesforce_status_mail`
submodule for email). Depends on `salesforce`. Version **1.0.1**. Core `^9||^10||^11`.

Integration/eventing — layered on the Salesforce Suite (which owns the connection/credentials); emits status
events; mail submodule can email status detail (set recipients). No access role.
