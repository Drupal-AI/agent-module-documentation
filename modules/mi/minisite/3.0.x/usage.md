<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Minisite accepts an uploaded ZIP or TAR archive of a static site — HTML, CSS, JavaScript and assets — extracts it and serves it from a path on the Drupal site.

---

The need is real and recurring: an annual report produced as a static build, a campaign microsite from an agency, an interactive data visualisation, a legacy site preserved for reference, a conference programme delivered as a folder of files. Rebuilding each in Drupal is disproportionate, and hosting them elsewhere costs a domain, a certificate and an entry in someone's inventory. Serving them from the site keeps the URL, the certificate and the analytics in one place, and makes the archive a field value attached to a node, so it has an owner, a revision history and an editorial workflow. Version **3.0.3** on core `^10.3 || ^11`, depending on core `file`, with `manage minisites` correctly marked `restrict access: true`. **That permission is the whole security model and it deserves to be understood rather than granted.** Extracted files are served from the site's own origin, and the allowed extensions include `html`, `js` and `svg` because a minisite is made of them — so anything in the archive executes as the site: it can read non-`HttpOnly` cookies, make authenticated same-origin requests as whoever is browsing, and present a convincing login form on the real domain. Treat the permission as equivalent to deploying front-end code. Two things to decide deliberately: a **Content-Security-Policy** on minisite paths is the only thing that meaningfully constrains what the uploaded code can do, and serving minisites from a **separate origin** removes the problem entirely where the requirement allows it.

---

- Serve an annual report's static build.
- Host an agency-produced microsite.
- Publish an interactive data visualisation.
- Preserve a legacy site for reference.
- Serve a conference programme.
- Host a static build under the main domain.
- Attach a microsite to a node.
- Keep a campaign site's URL on the main domain.
- Serve a static style guide.
- Publish a static documentation build.
- Host a designer's HTML deliverable.
- Serve an archived exhibition site.
- Publish a static prototype.
- Keep a microsite under editorial workflow.
- Serve a generated report bundle.
- Host a training module's static files.
- Publish a static microsite with revisions.
- Archive a previous site version.
