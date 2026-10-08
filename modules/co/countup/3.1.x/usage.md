<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
CountUp is a CKEditor 5 plugin that lets editors insert animated "count-up" numbers into rich-text content — a figure that animates from zero to its value as it scrolls into view, the staple of a stats or impact section.

---

Marketing and impact pages love the animated statistic: "10,000+ members", "98% satisfaction", counting up as the reader arrives. Building it usually means a custom field or a block and some JavaScript. CountUp makes it an editor action inside CKEditor 5 — insert a count-up element, set the target number and options, and the rich text carries the animated figure without a developer.

It depends on core **CKEditor 5** and **editor**, and it is exactly as broad as it sounds: a content-authoring nicety for a specific visual effect. Because it inserts markup and attaches an animation script, the usual filtered-text consideration applies — the text format's allowed HTML must permit the element the plugin inserts, or the filter will strip it on render. That is the most common reason such a plugin "does not work": the editor inserts it, the filter removes it.

For pages that want animated numbers, it puts the effect in editors' hands. Confirm the text format allows the plugin's markup so it survives filtering.

---

- Insert an animated count-up number.
- Add a stats section figure.
- Animate a statistic on scroll.
- Show '10,000+' counting up.
- Let editors add count-up numbers.
- Build an impact section.
- Add animated figures in CKEditor 5.
- Insert a counter without code.
- Set a count-up target value.
- Animate numbers from zero.
- Enhance a marketing page.
- Add a satisfaction percentage counter.
- Allow the plugin markup in the text format.
- Confirm the filter keeps the element.
- Provide an editor-driven animation.
- Add impact figures to a landing page.
- Use CountUp in rich text.
- Insert a scroll-triggered counter.
- Depend on CKEditor 5.
- Author animated stats inline.