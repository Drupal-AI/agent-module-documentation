<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Ping-Pong alternates image and text left-to-right down the page.

---

The zigzag: an image on the left with text on the right, then reversed, then reversed again. It is the standard way to present a sequence of features or steps at length without the page becoming a wall of text, and the alternation gives the eye a rhythm that a stack of identical rows does not.

**The thing that goes wrong is reading order on mobile.** At narrow widths the columns stack, and whether the image or the text comes first depends on how the alternation is implemented — visually reversing rows with CSS can leave the DOM order intact, so a row that reads image-then-text on desktop reads text-then-image on mobile, or the same order for every row regardless of the visual alternation. Neither is wrong exactly, but it should be a decision rather than an accident, and it should be consistent.

Worth checking at mobile width with real content before this goes on a template, and worth checking with a screen reader, which follows DOM order rather than the visual arrangement.

---

- Present features in an alternating layout.
- Show a sequence of steps.
- Break up a long page of text.
- Give the page a visual rhythm.
- Pair each point with an image.
- Check reading order at mobile width.
- Decide whether image or text comes first when stacked.
- Keep stacking order consistent across rows.
- Verify DOM order with a screen reader.
- Test with real content lengths.
- Style the alternation with the theme.
- Translate paired content.
- Order the sequence deliberately.
- Audit stacking behaviour on a template.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
