<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Statistics presents a row of headline figures with labels.

---

The pattern is familiar from every organisation's about page: three or four large numbers with a short label under each — members served, years operating, projects delivered. It works because a number is the fastest claim to read and the easiest to remember.

Two things are worth being deliberate about, and both are editorial rather than technical.

**A figure without a source is an assertion.** On a charity, public-sector or research site, headline statistics are exactly what a sceptical reader checks, and a component that offers nowhere to put a source or a date encourages numbers that cannot be defended. If the component has no field for it, the page around it should.

**Animated counters are motion.** If the numbers count up on scroll, that needs to respect `prefers-reduced-motion`, and the final value must be present for anyone who never triggers the animation — a screen reader user or a visitor with JavaScript disabled should get the number, not an empty element or a zero.

---

- Show headline figures on an about page.
- Present three key numbers with labels.
- Make a claim readable at a glance.
- Provide a source for a statistic.
- Date a figure so it can be checked.
- Avoid indefensible headline numbers.
- Respect reduced-motion for counters.
- Ensure the final value is always present.
- Avoid an empty element without JavaScript.
- Give screen readers the number.
- Style figures with the theme.
- Translate labels and units.
- Update figures when they go stale.
- Audit statistics for sourcing.
- Document this component's conventions for the team.
- Review it during a component audit.
- Verify its behaviour after a theme change.
