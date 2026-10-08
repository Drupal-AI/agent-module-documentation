<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Salesforce Web2Lead Webform Handler creates a lead in Salesforce from a webform.

---

Salesforce Web2Lead Webform Handler adds a **Webform handler that creates a Salesforce lead** — on
submission it posts the mapped form fields to Salesforce's **Web-to-Lead** endpoint (using your Salesforce org
ID), turning form submissions into CRM leads. It depends on the Webform module, in the Webform package.

Use it to send webform submissions to Salesforce as leads. It is a forms/CRM integration feature. Security/data
notes: it sends **submitter data (PII)** to Salesforce (external data egress — handle per your privacy policy);
Salesforce **Web-to-Lead is an unauthenticated endpoint by design** (it accepts posts keyed by the org id), so
the form itself is the trust boundary — apply **spam/bot protection** (CAPTCHA, honeypot) to the webform so it
isn't abused to inject junk leads; and post over **HTTPS**. It has no access-control role. Configure the
Salesforce org ID and field mapping.

---

- Create Salesforce leads from a webform.
- Post fields to Salesforce Web-to-Lead.
- Use the Salesforce org ID.
- Depend on the Webform module.
- Turn submissions into CRM leads.
- Map form fields to lead fields.
- Send submitter PII to Salesforce (egress).
- Add spam/bot protection to the form.
- Know Web-to-Lead is unauthenticated by design.
- Post over HTTPS.
- Have no access-control role.
- Configure the org ID and mapping.
- Handle Salesforce leads.
- Create leads.
- Configure the handler.
- Send to Salesforce.
- Handle the integration.
- Submit leads.
- Protect the form.
- Provide Web-to-Lead.
