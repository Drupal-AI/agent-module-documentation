<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
ECA External Workflows triggers workflows on external automation platforms (Pipedream, n8n, Zapier, Make) from ECA.

---

ECA External Workflows **triggers workflows on external automation platforms from ECA** — calling out to
Pipedream, n8n, Zapier or Make (via their webhooks/APIs) from Event-Condition-Action models, so Drupal events can
kick off external automations. It depends on the ECA module and the **Key** module.

Use it to bridge ECA to external automation. It is an integration/automation feature. Security/data handling: it
**sends data (event/entity payloads) to external automation services** (egress — confirm acceptable, as payloads
can include site data/PII) and authenticates using **credentials/webhook secrets stored via the Key module**
(secret handling, a positive). Serve over HTTPS. It has no access-control role. Configure the external endpoints
and keys (via Key).

---

- Trigger external workflows from ECA.
- Call Pipedream/n8n/Zapier/Make.
- Kick off automations on Drupal events.
- Depend on ECA + the Key module.
- Serve integration/automation.
- Bridge ECA to external platforms.
- Send event/entity payloads externally (egress; can include PII).
- Store webhook secrets/credentials via the Key module (positive).
- Serve over HTTPS.
- Have no access-control role.
- Configure the endpoints and keys via Key.
- Handle external workflows.
- Trigger workflows.
- Configure the endpoints.
- Send payloads.
- Handle the integration.
- Automate externally.
- Call webhooks.
- Secure the keys via Key.
- Provide external-workflow triggering.
