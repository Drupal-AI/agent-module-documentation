<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
SVG Icon Field allows to provide an SVG icon field type.

---

SVG Icon Field provides an **SVG icon field type** — letting content reference/store an SVG icon (from a
configured icon set) and render it, so entities can carry an icon field. It depends on core Field, in the
Field types package.

Use it to add an icon field to a bundle. It is a fields/media feature. Security note: **rendered inline SVG is
active markup** (SVG can contain `<script>` and event handlers), so an icon **set/source should be trusted** —
prefer a curated icon library over letting untrusted users supply arbitrary SVG (stored-XSS surface). It has
no access-control role. Add the SVG icon field to a bundle.

---

- Provide an SVG icon field type.
- Store/reference an SVG icon.
- Render an icon on entities.
- Depend on core Field.
- Use a configured icon set.
- Add an icon field.
- TREAT rendered SVG as active markup.
- Use a trusted icon set/source.
- Avoid untrusted SVG (stored-XSS).
- Have no access-control role.
- Add the field to a bundle.
- Handle icon fields.
- Choose icons.
- Configure the field.
- Store icons.
- Render icons.
- Handle the field.
- Add SVG icons.
- Configure icons.
- Provide icon fields.
