<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Headings Menu builds an in-page navigation menu from the headings on the page.

---

Long landing pages need a way to skip to a section, and building that by hand means maintaining a list of anchors that drifts from the content the first time someone reorders a section.

Generating it from the headings removes that maintenance. The menu reflects what is actually on the page, and reordering sections reorders the menu.

It is one of the components `vlsuite_shuttle` and `vlsuite_demo` both pull in, which suggests the project considers it part of the baseline rather than an extra.

The accessibility angle is worth naming because it is the component's strongest argument. An in-page navigation built from real headings is useful to everyone and especially to screen reader users, who navigate by heading structure anyway — which also means the component is only as good as the heading hierarchy beneath it. If editors are using headings for visual size rather than structure, the generated menu will show it, which is a diagnostic as much as a feature.

---

- Add in-page navigation to a long page.
- Let visitors skip to a section.
- Generate anchors from headings automatically.
- Keep the menu in step when sections move.
- Avoid maintaining a hand-written anchor list.
- Support screen reader heading navigation.
- Diagnose a broken heading hierarchy.
- Show the page's structure to readers.
- Style the headings menu with utility classes.
- Place the menu in a sidebar section.
- Make a long report navigable.
- Sticky-position an in-page menu.
- Audit heading use across landing pages.
- Encourage semantic heading use.
- Translate generated menu labels.
