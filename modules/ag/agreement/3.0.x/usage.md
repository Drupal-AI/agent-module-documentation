<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Agreement makes users in chosen roles accept a document — terms of service, an acceptable use policy, an NDA — before they can use the site, and records that they did.

---

Each agreement is a configuration entity (`agreement`) with its own page path, target roles, text format, page-visibility rules and re-acceptance frequency, managed at `/admin/config/people/agreement`. A request subscriber (`agreement_subscriber`, priority 28) checks every request from a targeted user via the `agreement.handler` service and redirects them to the agreement's page until they accept; the intended destination is remembered so they land back where they were headed. Authenticated acceptance is written to the `{agreement}` table keyed to the current user's id (`uid`, `type`, `agreed`, `sid`, `agreed_date`); anonymous acceptance (when the agreement targets the anonymous role) is a `agreement_anon_<id>` cookie. Frequency governs re-acceptance: once (`-1`), every login (`0`, per session id), or after N days (e.g. `365` for yearly), with a `reset_date` floor to force everyone to re-accept. Three permissions divide duties: `administer agreements` (restricted), `bypass agreement` for accounts that must never be interrupted, and `revoke own agreement` so a user can withdraw consent. It supports multiple agreements targeting different roles or paths, an optional email notification to a recipient on accept/revoke, `hook_agreement_handler_alter()` to change which agreement applies, and two bundled Views for reporting. It depends only on core `filter`, because the agreement body renders through a text format.

---

- Require acceptance of terms of service before using a site.
- Record who accepted which agreement and when.
- Show an NDA to contractors on first login.
- Require re-acceptance yearly (`frequency: 365`) when terms change.
- Force re-acceptance on every login (`frequency: 0`).
- Force everyone to re-accept by setting a new `reset_date`.
- Target an agreement at specific roles.
- Present an agreement to anonymous visitors (cookie-based).
- Apply an agreement to specific paths, or all paths except some.
- Run several agreements at once for different roles or sections.
- Let users withdraw their acceptance (`revoke own agreement`).
- Exempt monitoring/deployment accounts (`bypass agreement`).
- Email a compliance mailbox each time someone accepts or revokes.
- Report on acceptance with the bundled `agreements` admin View.
- Let users see their own acceptance history on their profile tab.
- Redirect users to a chosen page after they accept.
- Preserve the original destination (and query string) after acceptance.
- Keep agreement text under a chosen text format.
- Show a code-of-conduct to new members before entry.
- Swap or suppress the applicable agreement per-domain via the alter hook.
- Provide acceptance evidence for an audit.
- Deploy agreements as configuration with `drush cex`/`cim`.
- Meet a GDPR-style requirement where consent can be withdrawn as easily as given.
