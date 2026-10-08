<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Utility Classes lets an editor apply a controlled set of CSS classes — spacing, alignment, colour, visibility — to a block, section or layout.

---

The recurring tension in page building is that editors need some control over appearance and giving them arbitrary CSS is how a design system dies. Utility classes are the compromise: a fixed vocabulary defined by the theme, offered as options in the editing UI, applied per instance.

That keeps two things true at once. An editor can add space above a section or centre a heading without asking a developer, and the values they can choose are ones the design actually supports — no arbitrary pixel margins, no off-palette colours.

Nearly every other VLSuite submodule depends on this, which tells you how central it is: blocks, layouts and the Layout Builder UI all offer utility classes because that is where per-instance adjustment belongs.

The governance question is the size of the vocabulary. A short list is a design system; a long one is inline styles with extra steps. Review what the theme exposes periodically, because the list only ever grows unless someone prunes it.

---

- Add spacing above a section.
- Centre a heading in a block.
- Apply a background colour from the palette.
- Hide a component at mobile width.
- Give an editor controlled styling options.
- Avoid arbitrary CSS in content.
- Keep choices within the design system.
- Adjust a component per instance.
- Apply classes to a layout section.
- Define the vocabulary in the theme.
- Prune the utility class list.
- Standardise spacing across a site.
- Avoid a new block type per visual variation.
- Audit which classes editors actually use.
- Document the class vocabulary for editors.
- Review the list before it becomes inline styles.