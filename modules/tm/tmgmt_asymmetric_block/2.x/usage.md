<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT for Layout Builder Asymmetric Block translates Layout Builder blocks as new (asymmetric) blocks via TMGMT.

---

TMGMT for Layout Builder Asymmetric Block **translates Layout Builder blocks as new blocks** — allowing blocks
placed in Layout Builder to be translated into separate (asymmetric) blocks per language via the TMGMT translation
workflow, so translations can diverge structurally. It depends on TMGMT, core Block, Layout Builder Asymmetric
Translation and Entity Reference Revisions.

Use it to translate Layout Builder blocks asymmetrically. It is a multilingual/integration feature. Security/data
handling: translating via TMGMT may **send block content to a translation provider** (egress — confirm) and provider
credentials should be secrets. It has no access-control role. Configure the translation.

---

- Translate LB blocks as new blocks.
- Support asymmetric translations.
- Use the TMGMT workflow.
- Depend on TMGMT + Layout Builder AT.
- Serve multilingual/integration.
- Diverge translations structurally.
- Possibly send block content to a translation provider (egress).
- Store provider credentials as secrets.
- Have no access-control role.
- Configure the translation.
- Handle block translation.
- Translate blocks.
- Configure the connector.
- Send translations.
- Handle the integration.
- Localize blocks.
- Configure TMGMT.
- Handle the workflow.
- Manage translations.
- Provide asymmetric block translation.
