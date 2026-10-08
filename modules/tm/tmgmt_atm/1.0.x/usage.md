<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
TMGMT Auto Translate Manager extends TMGMT with automatic (continuous) translation.

---

TMGMT Auto Translate Manager (tmgmt_atm) **adds automatic translation to TMGMT** — using a continuous
translation job so content is auto-translated via TMGMT providers as it changes. It depends on the TMGMT and TMGMT
Content modules, and provides its own permissions.

Use it to auto-translate content via TMGMT. It is a multilingual/integration feature. Security/data handling:
automatic translation **sends content to the configured TMGMT translation provider** (external egress — confirm
acceptable, including drafts) and provider credentials should be stored as secrets. It has its own permissions.
Configure the automatic translation.

---

- Add automatic translation to TMGMT.
- Use a continuous translation job.
- Auto-translate on change.
- Depend on TMGMT + TMGMT Content.
- Provide its own permissions.
- Serve multilingual/integration.
- Send content to the TMGMT provider automatically (egress; incl. drafts).
- Confirm the egress is acceptable.
- Store provider credentials as secrets.
- Configure the automatic translation.
- Handle auto-translation.
- Auto-translate.
- Configure the jobs.
- Translate content.
- Handle the integration.
- Manage translations.
- Configure TMGMT.
- Handle the workflow.
- Localize content.
- Provide auto-translation.
