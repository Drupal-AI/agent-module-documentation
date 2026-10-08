<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Javascript Editor lets administrators customize a theme's JavaScript directly in the browser via a syntax-highlighting editor; the code runs on the front end.

---

Javascript Editor lets administrators write custom JavaScript for a theme directly in the browser —
a syntax-highlighting textarea on each theme's settings page where an admin types JS that is then attached
to and executed on the site's pages. It is in the Development package and gates the capability behind an
`execute arbitrary js_editor scripts` permission.

**Security caveat — this is a highly privileged, dangerous-by-design capability.** Custom JavaScript
entered here runs in every visitor's browser, so the `execute arbitrary js_editor scripts` permission is
effectively equivalent to full site compromise: someone with it can inject scripts that steal
session cookies/credentials, deface pages, exfiltrate data, or perform actions as any user who visits.
Treat this permission like "administer filters"/PHP-eval-class permissions: grant it **only** to fully
trusted administrators (ideally no one, or a single super-admin), never to content editors, and be aware
that its presence widens the site's attack surface. The module is a legitimate tool for trusted
theming/customization, but the permission must be tightly controlled.

---

- Add custom theme JavaScript via the browser.
- Edit JS with syntax highlighting.
- Attach custom JS to pages.
- Gate behind execute arbitrary js_editor scripts.
- Understand JS runs for all visitors.
- Treat the permission as site-takeover-equivalent.
- Grant only to fully trusted admins.
- Never grant to content editors.
- Know it can steal sessions/credentials.
- Compare to administer-filters/PHP permissions.
- Widen the attack surface knowingly.
- Use for trusted customization only.
- Restrict the permission tightly.
- Customize a theme's JS.
- Run code on the front end.
- Avoid granting broadly.
- Add per-theme scripts.
- Control the dangerous permission.
- Inject trusted JS only.
- Manage custom JavaScript carefully.
