<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Table presents tabular data as a block.

---

Tables are the right answer for data with two dimensions — a price list, a comparison, a schedule — and they are consistently the hardest component to make work on a phone.

**Two things determine whether the table is usable.** Real table markup with proper header cells is what lets a screen reader announce "Price, £40" instead of reading a stream of numbers; a table built from divs is a grid of unlabelled values. Check that headers are `<th>` with the right `scope`, and that the table has a caption or an accessible name saying what it contains.

And **the responsive strategy is a design decision with no universally right answer**: horizontal scrolling keeps the structure and hides columns off-screen; collapsing each row into a stacked card keeps everything visible and loses comparison, which is usually the reason for a table. Whichever the component does, know which it is, because the wrong one makes the data harder to use than a list would have been.

Editorially, a table an editor maintains by hand in a WYSIWYG drifts; a table as a structured component at least keeps its shape.

---

- Present a price list.
- Show a comparison table.
- Publish a schedule.
- Keep tabular data structured.
- Use real table markup.
- Mark header cells with th and scope.
- Give the table an accessible name.
- Let a screen reader announce cell context.
- Choose a responsive strategy deliberately.
- Scroll horizontally to keep structure.
- Stack rows to keep everything visible.
- Preserve comparison on small screens.
- Avoid hand-maintained WYSIWYG tables.
- Translate table content.
- Audit tables for header markup.
