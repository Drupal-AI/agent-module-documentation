<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Linkychecker is a link checker for finding broken links in content.

---

Linkychecker is a link checker — scanning content for hyperlinks and verifying they resolve (detecting
broken/dead links, e.g. 404s), so editors can find and fix broken links across the site. It requires PHP
8.1, provides Drush commands and its own permissions, in the Links package.

Use it to audit links for breakage. It is an administration/content-audit feature that makes outbound HTTP
requests to check links; be aware it fetches the linked URLs server-side (a normal link-checker behaviour) —
run it on a schedule/Drush, and the report of broken links is admin-oriented. It has no access-control role
beyond its permission. Configure and run the link check.

---

- Check content links for breakage.
- Detect broken/dead URLs.
- Verify links resolve.
- Require PHP 8.1.
- Provide Drush commands and permissions.
- Find 404 links.
- Make outbound requests to check links.
- Fetch linked URLs server-side.
- Run on a schedule/Drush.
- Have no access-control role beyond permission.
- Configure the link check.
- Handle link checking.
- Audit links.
- Configure the checker.
- Find broken links.
- Check URLs.
- Handle broken-link reports.
- Run link checks.
- Configure checking.
- Audit for dead links.
