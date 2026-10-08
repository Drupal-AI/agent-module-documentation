<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Link Checker Summary Mail emails a periodic (daily or weekly) digest of the broken links that the Link Checker module has found on your site.

---

Link Checker records every broken link it finds as a `linkcheckerlink` entity, but that report only helps if someone opens it, and on most sites nobody does — broken links accumulate silently until a visitor complains or an audit surfaces them. This module inverts that by pushing the findings out on a cron-driven schedule. On each `hook_cron` run it checks whether a day (or a week) has elapsed since the last send, queries Link Checker for links whose `fail_count > 0`, `status = 1`, and HTTP `code <> 200`, and mails a summary. It can send to a single global address, to the author (owner) of each affected entity, to the latest editor (revision user) of each entity, or any combination. By default the digest reports only links whose `last_check` is newer than the previous send (new failures), but a "summarize all" option makes every mail contain the full standing backlog instead. All configuration lives in one settings form gated by the Link Checker `administer linkchecker` permission.

---

- Email a daily or weekly digest of broken links found on the site.
- Push Link Checker findings to a shared webmaster or content-team inbox (global address).
- Notify each content author about broken links in the entities they own.
- Notify the latest editor (revision user) of a node about its broken links.
- Send to a combination of global address, authors, and latest editors at once.
- Report only newly-failed links since the last mail (default) to avoid repeating the backlog.
- Send the entire standing list of broken links every time (enable "summarize all").
- Switch the send cadence between daily and weekly.
- Seed the global recipient from the site email at install (`hook_install` copies `system.site` mail).
- Turn off the global mail and rely only on per-author / per-editor notifications.
- Drive broken-link remediation without anyone logging in to check a report.
- Track link health over time by keeping the digests.
- Prompt a periodic link-cleanup workflow on a content team.
- Provide stakeholders a recurring signal on external-link rot.
- Route each finding to the person who owns the content it appears in.
- Include the offending link URL, the page it was found on, its HTTP status code, and how many times it has failed, in each mail body.
- Localise the digest subject/body to the site default language.
- Integrate with any Drupal mail plugin/transport (uses the core mail manager).
- Rely entirely on cron scheduling — no queue or external service to run.
- Reset the send schedule by clearing the `linkchecker_summary_mail.last_checked` state key.
- Document the module's cron/mail behaviour for a team runbook.
- Review its recipient configuration during a site audit.
- Re-verify its behaviour after a Link Checker or core upgrade.
