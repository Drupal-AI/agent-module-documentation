<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Smart 404 logs 404 errors and provides an admin UI to quickly create redirects.

---

Smart 404 **logs 404 (not found) errors and lets admins quickly create redirects** for them — surfacing
the URLs visitors hit that 404 and offering a one-click way to add a redirect, reducing broken links/SEO loss.
It depends on the Redirect module, provides its own permissions, in the Administration package.

Use it to find and fix 404s. It is an administration/SEO feature. Security note: the 404 log records
**requested URLs**, which can include whatever visitors (or bots) probe — treat the log as it may contain
noisy/attacker-supplied paths, and gate its permission to trusted admins. The redirects it creates are
admin-configured (trusted). It has no access-control role beyond its permission. Review 404s and create
redirects.

---

- Log 404 errors.
- Create redirects for 404s in a UI.
- Reduce broken links/SEO loss.
- Depend on the Redirect module.
- Provide its own permissions.
- Surface hit-but-missing URLs.
- Know the log records requested (possibly attacker) URLs.
- Gate the permission to trusted admins.
- Create admin-configured redirects.
- Have no access-control role beyond permission.
- Review 404s and add redirects.
- Handle 404 management.
- Fix 404s.
- Configure redirects.
- Log not-found.
- Handle the log.
- Add redirects.
- Manage 404s.
- Restrict the log.
- Provide 404 management.
