<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Accordion presents a set of collapsible panels — the standard FAQ pattern.

---

An accordion suits content that is a list of independent questions: FAQs, policy sections, specification categories. Each panel is self-contained, most readers want one of them, and showing all of them at once would make the page unreadable.

It suits content that is a narrative badly, because collapsing prose hides the thread.

**The accessibility requirements are specific and frequently missed.** Each header must be a button, not a styled div; it needs `aria-expanded` reflecting state and `aria-controls` pointing at its panel; the panel must be reachable by keyboard; and the whole thing must work without JavaScript in the sense of leaving content reachable. A click-only accordion is content a keyboard user cannot open.

Worth also deciding whether panels start open or closed. Everything closed is tidy and hides content from search-result snippets and from readers who are scanning; the first panel open is a reasonable default that signals the pattern.

---

- Present a set of FAQs.
- Show policy sections collapsibly.
- Group specification categories.
- Fit a long list of questions on one page.
- Avoid collapsing narrative prose.
- Make accordion headers real buttons.
- Set aria-expanded to reflect state.
- Point aria-controls at the panel.
- Ensure keyboard operation.
- Keep content reachable without JavaScript.
- Decide whether the first panel starts open.
- Consider search snippet visibility.
- Style the accordion with the theme.
- Translate panel content.
- Audit accordions for accessibility.
