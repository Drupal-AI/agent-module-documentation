<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
XSS File Scan scans uploaded files for XSS vulnerabilities (e.g. script/HTML content in files that could execute if served).

---

XSS File Scan scans uploaded files for potential cross-site-scripting content — inspecting file
contents for script/HTML patterns that could execute if the file were served inline from the site's
origin (a real risk for SVGs, HTML, and files served with a permissive content type). Flagged uploads can
be rejected before they are stored. It is configured at `xss_file_scan.xss_file_scan_config_form` and
provides its own permissions.

Use it as a defense layer where users can upload files that might be served in a way that executes markup
(SVG avatars, HTML attachments). Important framing: content-scanning for XSS is **heuristic** — it can
catch common patterns but is not a guarantee (obfuscation and novel vectors can evade it), so it
**complements, does not replace**, the core protections: serve user uploads from a separate domain or with
`Content-Disposition: attachment` / non-executable content types, restrict which file types are allowed,
and sanitize SVGs. Treat this as one layer in defense-in-depth, not the sole control.

---

- Scan uploads for XSS content.
- Detect script/HTML in files.
- Block flagged uploads.
- Protect against executable SVGs/HTML.
- Configure at the scan config form.
- Provide its own permissions.
- Reject risky files before storage.
- Understand scanning is heuristic.
- Know it can be evaded.
- Complement, not replace, core protections.
- Serve uploads from a separate domain.
- Use Content-Disposition: attachment.
- Restrict allowed file types.
- Sanitize SVGs.
- Treat as defense-in-depth.
- Not rely on it as the sole control.
- Inspect file contents.
- Flag XSS patterns.
- Add an upload scanning layer.
- Harden file uploads.
