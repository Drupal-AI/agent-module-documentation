<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Redirect anonymous users forces anonymous visitors to the login page, turning the whole site private except for a configurable allow-list of route names.

---

A single KernelEvents::REQUEST subscriber (RedirectAnonymousSubscriber) runs on every request: if the current user is anonymous and the route is neither `user.login` nor one of the excluded route names, it issues a 302 RedirectResponse to `user.login` and calls `->send()` immediately. The redirect target is hard-coded to the login route (`Url::fromRoute('user.login')`), so it is never attacker-controlled — there is no open-redirect surface. Administrators manage the exclusions on the settings form at `/admin/people/redirect_anonymous_users/settings`, entering one Drupal route *name* per line (not paths — the form rejects any value containing `/`); the raw text and a whitespace-split list are stored in `redirect_anonymous_users.settings`.

The setup task is small: enable the module, then add every route an anonymous user must still reach (password reset `user.pass`, registration `user.register`, REST/API routes, cron, etc.) to the exclusion list, because by default only `user.login` is reachable and everything else redirects. The settings route is gated by the `administer redirect_anonymous_users configuration` permission (marked restrict access). Operational caveat: the subscriber fires on POST as well as GET and does not exclude system routes automatically, so an incomplete allow-list can break flows like password reset or API endpoints.
---
- Make an entire site private, forcing all anonymous visitors to log in.
- Add a route name to the exclusion allow-list so anonymous users can still reach it.
- Allow anonymous password reset by excluding `user.pass`.
- Allow public self-registration by excluding `user.register`.
- Keep a REST/JSON:API endpoint reachable anonymously by excluding its route name.
- Restrict a staging/pre-launch site to authenticated users only.
- Confirm the login route is always reachable (it is exempt by default).
- Review which routes currently bypass the redirect via the settings form.
- Grant the admin permission to a trusted role to manage exclusions.
- Exclude a custom controller route that must stay public.
- Exclude the cron route so scheduled runs are not redirected.
- Diagnose a "redirect loop"/broken flow caused by a missing exclusion.
- Enforce login before any content is viewable, without per-node access rules.
- Combine with core account settings to disable open registration entirely.
- Add several excluded routes at once (one route name per line).
- Verify entered values are route names, not paths (the form blocks `/`).
- Use as a lightweight alternative to a full access-control policy for a small site.
- Temporarily lock down a site during maintenance by enabling the module.
- Re-open specific sections by editing the exclusion list rather than code.
- Audit the stored `routes_to_exclude_split` config to see the effective allow-list.
