<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Web Accessibility gives content editors one-click links to external accessibility, markup, and broken-link validators straight from the node edit form, so a saved page can be checked against WCAG 2.0 and HTML standards without copying its URL into an outside tool by hand.

---

On every already-saved node, `hook_form_node_form_alter` adds a collapsed "Web Accessibility Services" section (in the form's advanced sidebar group) containing a button link for each configured validator. Each link is the validator's URL with a `<URL>` token replaced by the node's absolute canonical URL, opened in a new tab — the module itself makes no HTTP calls, it just builds the links, so the editor's browser drives the check and the page has to be publicly reachable for the external tool to fetch it. Three validators ship by default (W3C link checker, W3C markup check, and WAVE), seeded into the `web_accessibility_services` database table on install. An admin form at `/admin/config/system/web_accessibility` (permission `administer_web_accessibility`) lists the services and lets you add more (name plus a URL that must be a valid absolute URL once the `<URL>` token is stripped) or delete them through a confirm form. Services are plain table rows rather than config entities, and are managed in code through the `web_accessibility.service_manager` service. Core support is a wide `^8 || ^9 || ^10 || ^11`, and the release still carries the legacy `8.x-1.4` packaging string.

---

- Check a page against WCAG 2.0 from inside the node edit form.
- Run the W3C markup validator on the current node.
- Check a node for broken links via the W3C Link Checker.
- Send a page to the WAVE accessibility evaluation tool.
- Give editors an accessibility check before publishing.
- Add a custom third-party validator by name and URL.
- Point editors at an internal or preferred validation service.
- Remove a default validator you do not want to offer.
- Centralise which accessibility tools the team uses.
- Support a public-sector accessibility obligation.
- Provide evidence for an accessibility statement.
- Compare results from two validators side by side.
- Restrict who can change the validator list to administrators.
- Add an accessibility step to an editorial review workflow.
- Audit an existing article for accessibility issues.
- Seed the three W3C/WAVE validators automatically on install.
- Substitute the live page URL into any validator's query string.
- Manage validators programmatically via the service manager.
- Keep validator links out of the node create form (saved nodes only).
- Complement in-editor checkers like Editoria11y with external tools.
