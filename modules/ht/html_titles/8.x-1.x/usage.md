<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
HTML Titles for Drupal allows titles to contain HTML.

---

HTML Titles for Drupal allows titles (node/entity/page titles) to contain **HTML markup** — so a title
can include formatting (e.g. `<em>`, `<sup>`, styling) that would normally be escaped, for richer headings.
It is in the Other package.

**Security caution: this bypasses the normal escaping of titles, creating a stored-XSS surface.** Drupal
normally escapes titles precisely because they're output in many contexts; allowing raw HTML in titles means
whatever HTML an editor puts in a title is **rendered** — so if title editing is available to a less-trusted
user, they could inject `<script>` (stored XSS). Only use this where title editing is restricted to
**trusted editors**, and ideally sanitize the allowed title HTML to a safe tag set. It has no access-control
role. Configure which titles allow HTML.

---

- Allow HTML in titles.
- Add formatting to headings.
- Include <em>/<sup>/styling in titles.
- Bypass the normal title escaping.
- CAUTION: this is a stored-XSS surface.
- Understand title HTML is rendered.
- Restrict title editing to trusted editors.
- Sanitize allowed title HTML to a safe tag set.
- Not expose HTML titles to less-trusted users.
- Have no access-control role.
- Configure which titles allow HTML.
- Handle HTML titles.
- Render title HTML.
- Configure titles.
- Add rich titles.
- Restrict HTML titles.
- Handle the titles.
- Format titles.
- Guard against XSS.
- Enable HTML titles carefully.
