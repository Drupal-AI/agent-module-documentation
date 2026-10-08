<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Webform Global Purge provides default purge settings for submissions.

---

Webform Global Purge **provides default/global purge settings for Webform submissions** — letting an
administrator set a site-wide submission-purge policy (auto-delete submissions after a period / on draft/
completed) applied across webforms, rather than configuring each form individually. It depends on the Webform
module, provides its own permissions, in the Webform package.

Use it to enforce a submission-retention policy site-wide. This is a **data-hygiene/privacy-positive** feature:
auto-purging old submissions helps meet **data-minimization/retention** obligations (GDPR) by not keeping
submission **PII** longer than needed. Two cautions: purging is **destructive** (deleted submissions are gone —
set the retention window deliberately and ensure you've exported/processed what you need first), and the setting
is gated by its permission (keep to trusted admins). It has no access-control role beyond its permission.
Configure the global purge policy.

---

- Set global submission-purge settings.
- Auto-delete old submissions.
- Apply a site-wide retention policy.
- Depend on the Webform module.
- Provide its own permissions.
- Avoid per-form configuration.
- BE data-hygiene/privacy-positive (retention/GDPR).
- Reduce retained submission PII.
- KNOW purging is destructive (set the window deliberately).
- Keep the permission to trusted admins.
- Have no access-control role beyond permission.
- Configure the purge policy.
- Handle submission purging.
- Purge submissions.
- Configure the policy.
- Auto-delete data.
- Handle retention.
- Purge PII.
- Set the retention window.
- Provide global submission purge.
