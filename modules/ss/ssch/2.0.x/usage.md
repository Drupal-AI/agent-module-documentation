<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Server sided code highlighting (ssch) uses server-side rendering to highlight code snippets.

---

Server sided code highlighting (ssch) highlights code snippets by rendering the syntax highlighting on
the **server** rather than in the browser — providing a code field type whose highlighted output is generated
server-side (avoiding a client-side highlighter library and its flash-of-unstyled-code). It depends on core
Field and Vendor Stream Wrapper, in the Field types package.

Use it to display syntax-highlighted code with server-side rendering. It is a content-display/fields feature
producing highlighted markup from code content; the code is authored content rendered as (highlighted,
escaped) markup, so ensure the field is used for code display (the highlighter escapes the code), and it has
no access-control role. Add the code field and configure the language/highlighting.

---

- Highlight code server-side.
- Provide a code field type.
- Render highlighting on the server.
- Avoid a client-side highlighter.
- Depend on core Field and Vendor Stream Wrapper.
- Avoid flash-of-unstyled-code.
- Render highlighted (escaped) markup.
- Have no access-control role.
- Add the code field.
- Configure the language/highlighting.
- Display code snippets.
- Handle code highlighting.
- Render highlighted code.
- Configure highlighting.
- Show syntax highlighting.
- Highlight snippets.
- Display code.
- Handle code fields.
- Configure code display.
- Highlight code.
