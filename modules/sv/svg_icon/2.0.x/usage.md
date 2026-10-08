<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Icon provides a field type to upload SVG icons and sprites for use in content/theming.

---

SVG Icon provides a field type for uploading SVG icons and sprites — so editors can upload SVG vector
graphics (icons, icon sprites) and use them in content/theming. It depends on core File and provides its own
permissions.

Use it to manage SVG icons as field content. **Security caveat — SVG uploads are an XSS risk.** SVG files
can contain embedded JavaScript (`<script>`, event handlers, `<foreignObject>`), so if user-uploaded SVGs are
served **inline** from the site's origin (e.g. embedded in the page rather than in an `<img>` tag), a
malicious SVG can execute script in visitors' browsers — stored XSS. Therefore: restrict SVG upload to
trusted roles (via the permission), and either sanitize uploaded SVGs (strip scripts/handlers — e.g. with an
SVG sanitizer) or ensure they are served in a way that doesn't execute (as `<img src>` or with a restrictive
`Content-Security-Policy`), and never allow untrusted users to upload SVGs that are then inlined. Confirm your
rendering path is safe before allowing untrusted uploads.

---

- Upload SVG icons and sprites.
- Provide an SVG field type.
- Use SVGs in content/theming.
- Depend on core File.
- Provide its own permissions.
- Restrict SVG upload to trusted roles.
- Know SVGs can contain JavaScript (XSS).
- Sanitize uploaded SVGs.
- Not inline untrusted user SVGs.
- Serve SVGs safely (img src / CSP).
- Strip scripts/handlers from SVGs.
- Confirm the rendering path is safe.
- Manage icon sprites.
- Use SVG icons.
- Guard against stored XSS via SVG.
- Gate SVG upload by permission.
- Handle vector graphics.
- Upload icons.
- Mind foreignObject/onload in SVG.
- Sanitize before inlining.
