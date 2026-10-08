<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Markup Field stores rendered markup output along with the dependent assets (CSS/JS) for that markup.

---

Markup Field provides a field type that stores rendered markup — the HTML output plus its dependent
assets (attached CSS/JS libraries) — so pre-rendered content can be stored and re-displayed with its
associated assets intact. It is in the Field types package.

Use it where rendered markup (with assets) needs to be stored on an entity. The security-relevant point is
that the field stores **markup** that is then output: ensure the markup stored is trusted/sanitized —
because it's rendered output, if untrusted or unsanitized HTML/JS can be placed in the field, it is a
stored-XSS vector when displayed. Restrict who can set this field to trusted users and/or sanitize the
markup, and be deliberate about what generates the stored markup. It has no access-control role. Configure
the field where trusted rendered markup should be stored.

---

- Store rendered markup in a field.
- Store markup with its assets.
- Keep attached CSS/JS with markup.
- Re-display pre-rendered content.
- Ensure stored markup is trusted/sanitized.
- Restrict who can set the field.
- Know unsanitized markup = stored XSS.
- Sanitize the markup.
- Be deliberate about what generates markup.
- Have no access-control role.
- Store rendered output.
- Handle markup fields.
- Store trusted markup only.
- Preserve dependent assets.
- Configure the field.
- Restrict to trusted users.
- Store HTML output.
- Handle rendered content.
- Avoid untrusted markup.
- Store markup safely.
