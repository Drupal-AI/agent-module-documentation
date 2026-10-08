<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Paragraphs Iframe (paragraphs_iframe) — agent index

**Config-only Paragraphs add-on: installs an "iframe" paragraph type with a required Source link field.**

- **Version:** 2.0.x
- **Core:** ^8 || ^9 || ^10
- **Dependencies:** field, language, link, paragraphs
- **Ships:** `paragraphs.paragraphs_type.iframe`, `field.storage.paragraph.field_iframe_source` + field, form/view displays (as optional config). `.module` file is empty.
- **Field:** `field_iframe_source` (type `link`, required); default view display uses the core `link` formatter.

**Security:** No PHP logic, routes, permissions, or services. The Source is a core `link` field rendered by the core `link` formatter (URL sanitized by core) — despite the module name it emits **no** `<iframe>` markup or raw attributes, so there is no custom XSS sink here. Rendering an actual iframe requires a formatter you add. No security findings.
