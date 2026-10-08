<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Update NARF squishes pesky No available releases found issues.

---

Update NARF addresses the **"No available releases found" (NARF)** problem in Drupal's Update Status —
where the Update module can't fetch/parse release data for some projects and reports them as having no
available releases, cluttering the update report. It helps resolve/suppress those false reports. It depends on
core Update, requires core 11.2+.

Use it to clean up bogus "no releases found" update reports. It is an administration/updates utility affecting
the update report; it has no content or access role. Enable it to squish NARF messages.

---

- Fix 'No available releases found' issues.
- Clean up the update report.
- Resolve NARF false reports.
- Depend on core Update.
- Require core 11.2+.
- Handle update-status glitches.
- Affect the update report.
- Have no content/access role.
- Squish NARF messages.
- Handle NARF.
- Fix update reports.
- Configure nothing (utility).
- Clean update status.
- Handle the report.
- Suppress false reports.
- Handle updates.
- Fix release data.
- Resolve NARF.
- Enable it.
- Provide NARF fixes.
