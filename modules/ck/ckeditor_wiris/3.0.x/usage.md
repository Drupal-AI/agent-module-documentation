Adds Wiris **MathType** (math) and **ChemType** (chemistry) equation-editor buttons to a CKEditor 5 toolbar, letting authors compose formulas visually and store them as MathML in the content.

---

`ckeditor_wiris` integrates the commercial Wiris equation editor into Drupal's core CKEditor 5. Enabling the module and adding the **MathType** and/or **ChemType** toolbar buttons to a text format gives authors two dialog-based editors: MathType for mathematical notation and ChemType for chemistry. Formulas are authored visually in a modal, inserted into the editor as a rendered image widget, and saved into the content as `<math>` **MathML** — a semantic, accessible, searchable representation rather than a flat image. Everything the module ships is client-side: a CKEditor 5 build plugin (`js/build/MathType.js`) plus two stylesheets; there is no Drupal PHP (empty `.module`, no routes, services, filters, permissions, or config schema). Editing-view images and the modal formula editor are produced by Wiris's rendering service — the bundled plugin points at the Wiris **demo** endpoint (`https://www.wiris.net/demo/plugins/app`), which is rate-limited and not licensed for production, so a real deployment needs a Wiris licence/self-hosted service. The module deliberately does **not** render formulas in the final rendered page: as its README states, you must add a MathML renderer such as [MathJax](https://www.drupal.org/project/mathjax) (or ensure the browser renders MathML) to display equations to end users. Which authors get the buttons is a per-text-format decision, and the text format's allowed-HTML must permit `<math>` (and its children) or the filter will strip stored formulas.

---

- Let content authors insert mathematical equations into rich-text fields without writing LaTeX or MathML by hand.
- Add a chemistry-formula editor (ChemType) for chemical notation, bonds, and structures.
- Store equations as semantic MathML in the body/content for accessibility (screen readers) and searchability, rather than as opaque images.
- Author formulas that round-trip: double-click an existing formula in the editor to reopen and edit it.
- Support LaTeX authoring — `$$...$$` LaTeX in the source is parsed to MathML, and MathML with a LaTeX annotation is shown back as `$$...$$`.
- Provide equation editing in an educational platform (math, physics, chemistry courses and exercises).
- Enable formula input only for specific roles by attaching the buttons to a restricted text format.
- Build STEM course material, quizzes, or worksheets in Drupal with inline equations.
- Publish scientific or technical articles that require notation like fractions, integrals, matrices, and Greek symbols.
- Add equation support to a "Full HTML"–style format while keeping a plain format for untrusted users.
- Migrate equation content between systems using the portable MathML representation.
- Combine with MathJax to render crisp, resolution-independent equations to site visitors.
- Offer a WYSIWYG alternative to the core CKEditor MathML/LaTeX plugins with a full palette-driven editor.
- Let authors edit an equation's font/style inline because the inserted `<mathml>` widget keeps surrounding text attributes.
- Author chemistry reaction equations and molecular formulas alongside prose in a node body.
- Provide accessible math for compliance (WCAG) by emitting MathML instead of alt-text-only images.
- Pass Wiris configuration (service parameters) per editor via the CKEditor `mathTypeParameters` config key.
- Expose the Wiris JS API (`window.WirisPlugin`) for custom front-end behavior or theming of formula images.
- Add formula editing to CKEditor 5 fields on any entity type (nodes, comments, custom blocks, paragraphs) that uses the enabled text format.
