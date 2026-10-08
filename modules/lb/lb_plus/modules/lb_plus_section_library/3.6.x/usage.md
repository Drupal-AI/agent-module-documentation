<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder + Section Library makes the Section Library module work inside the Layout Builder + interface.

---

Section Library lets editors save a configured section — or a whole layout — as a reusable template and drop it into another page. That is one of the more valuable Layout Builder additions, because it turns a well-built page into a pattern the rest of the team can reuse instead of rebuilding. Layout Builder + replaces the Layout Builder UI, and a replaced UI does not automatically carry another module's integration points, so this bridge exists to reconnect the two.

Install it only if you are running both. Its dependency list makes that explicit: `section_library`, `lb_plus` and `navigation_plus` are all required, and without any one of them there is nothing to bridge.

The editorial question worth raising when this is in place is governance of the library itself. A section library that anyone can add to becomes a list of near-duplicate templates within a few months, at which point editors stop using it. Decide who curates it before it fills up.

---

- Save a configured section as a reusable template.
- Reuse a section built in Layout Builder +.
- Drop a saved layout into a new page.
- Share a page pattern across an editorial team.
- Keep Section Library working after adopting Layout Builder +.
- Build a library of approved page components.
- Speed up page creation from existing patterns.
- Reuse a nested section arrangement.
- Standardise recurring page structures.
- Curate which templates editors may reuse.
- Avoid rebuilding the same layout repeatedly.
- Save a nested section arrangement to the library.
- Roll out an approved page pattern to a team.
- Reduce rebuild time for recurring campaign pages.
- Confirm section_library and lb_plus are both present.
