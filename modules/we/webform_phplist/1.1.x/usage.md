<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform phpList adds email addresses to phpList from webform submissions.

---

Webform phpList provides a **Webform handler that adds submitters' emails to a phpList mailing list** — so a
form submission can subscribe the submitter to a phpList (open-source newsletter) list. It depends on the Webform
module, in the Webform package.

Use it to feed webform signups into phpList. It is a forms/integration feature. Security/data handling: it sends
**submitter email addresses (PII) to a phpList instance** via its API (external egress — use a trusted phpList
endpoint over HTTPS; store any API **credentials** as a secret), respect **consent/opt-in** (only subscribe with
consent) and privacy/unsubscribe obligations. It has no access-control role. Configure the phpList handler and
credentials.

---

- Add webform emails to phpList.
- Subscribe submitters to a list.
- Feed signups into phpList.
- Depend on the Webform module.
- Serve forms/integration.
- Use the phpList API.
- Send submitter emails (PII) to phpList (egress).
- Use a trusted endpoint over HTTPS + secret credentials.
- Respect consent/opt-in + unsubscribe.
- Have no access-control role.
- Configure the handler and credentials.
- Handle phpList subscriptions.
- Subscribe emails.
- Configure the handler.
- Add to phpList.
- Handle the integration.
- Sync signups.
- Feed the list.
- Respect consent.
- Provide phpList subscription.
