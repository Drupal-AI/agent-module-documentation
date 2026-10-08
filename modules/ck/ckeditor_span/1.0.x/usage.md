<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CKEditor Span adds the span tag in CKEditor 5, letting editors wrap text in spans.

---

CKEditor Span adds `<span>` tag support to CKEditor 5 — letting editors wrap inline text in spans (with
classes) for styling hooks, without switching to source view. It depends on core CKEditor 5.

Use it to let editors add inline `<span>` elements. It is a content-editing/CKEditor feature; the `<span>`
becomes markup in the content, so ensure the text format's allowed tags/attributes permit `<span>` (and the
intended classes) so it survives filtering — and keep allowed attributes reasonable (arbitrary attributes/
classes are an XSS surface). It has no access-control role. Add the tool via the CKEditor 5 configuration.

---

- Add <span> support to CKEditor 5.
- Wrap inline text in spans.
- Add styling hooks via classes.
- Depend on core CKEditor 5.
- Avoid switching to source view.
- Ensure the format allows <span>.
- Keep allowed attributes reasonable (XSS).
- Have no access-control role.
- Add the tool via configuration.
- Insert span elements.
- Handle span markup.
- Configure the format.
- Add inline spans.
- Wrap text.
- Configure CKEditor 5.
- Add span tags.
- Handle inline styling.
- Enable spans.
- Add styling spans.
- Insert spans.
