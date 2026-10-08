<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Inline SVG provides a field for storing SVG code and rendering it inline in the page.

---

Inline SVG provides a field type, widget and formatter for **raw SVG markup** — editors paste/store SVG
code and the formatter renders it **inline** in the page (so the SVG is part of the DOM and can be styled/
animated with CSS), with an `inline_svg_media` submodule for Media. It depends on core Field.

Use it where inline, CSS-styleable SVG is needed. **Security caveat: inlined SVG is active markup.** SVG can
carry `<script>`, event handlers and external references, so rendering **untrusted** SVG inline is an
XSS/stored-XSS vector — restrict who can enter SVG (the field/widget should be limited to **trusted editors**),
and sanitize SVG that doesn't come from a trusted source. It has no access-control role. Add the field to a
bundle and grant it only to trusted roles.

---

- Store raw SVG markup in a field.
- Render SVG inline in the DOM.
- Enable CSS styling/animation of SVG.
- Provide a Media submodule (inline_svg_media).
- Depend on core Field.
- Paste/store SVG code.
- TREAT inlined SVG as active markup.
- Restrict SVG entry to trusted editors.
- Sanitize untrusted SVG (XSS vector).
- Have no access-control role.
- Add the field to a bundle.
- Grant it only to trusted roles.
- Handle inline SVG.
- Render SVG.
- Configure the field.
- Inline SVG safely.
- Handle SVG markup.
- Style SVG with CSS.
- Guard against SVG XSS.
- Store SVG.
