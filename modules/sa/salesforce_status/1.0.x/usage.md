<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Salesforce Status manages Salesforce status and sends events so other modules can interact.

---

Salesforce Status **manages Salesforce sync status and dispatches events** — tracking the state of the
Salesforce integration and firing events so other modules can react (e.g. on sync success/failure), with a
`salesforce_status_mail` submodule for email notifications. It depends on the Salesforce Suite module, in the
Salesforce package.

Use it to observe and react to Salesforce sync status. It is an integration/eventing feature layered on the
Salesforce Suite (which owns the actual Salesforce connection and its credentials); this module tracks status
and emits events, and has no access-control role. Note the mail submodule can email status detail — configure
recipients appropriately. Configure the status handling.

---

- Track Salesforce sync status.
- Dispatch status events.
- Let modules react to sync state.
- Provide an email submodule.
- Depend on the Salesforce Suite.
- React to success/failure.
- Layer on the Salesforce connection.
- Configure mail recipients appropriately.
- Have no access-control role.
- Configure status handling.
- Handle Salesforce status.
- Emit events.
- Monitor sync.
- Configure the events.
- React to Salesforce.
- Handle the integration.
- Track status.
- Send status mail.
- Configure status.
- Provide status events.
