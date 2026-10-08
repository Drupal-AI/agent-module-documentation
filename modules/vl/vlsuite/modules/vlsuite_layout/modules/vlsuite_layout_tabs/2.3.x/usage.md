<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Layout Tabs provides a tabbed section layout, so several panels of content occupy one place on the page.

---

Tabs solve a real problem — a specification, a set of FAQs, several audiences' versions of the same information — by letting a page offer more than fits comfortably in a linear scroll.

They also hide content, which is the trade. Anything in a tab other than the first is unseen by most visitors and, historically, weighted less by search engines. Putting something important on the third tab is putting it nowhere. That is a content decision the component cannot make, and the right thing for documentation to say is that the decision exists.

The accessibility requirements for tabs are well defined and specific: arrow keys move between tabs, Tab moves into the panel, the selected tab is marked with `aria-selected`, and each panel is associated with its tab. A tab implementation that is only clickable is not accessible. Verify against the shipped implementation rather than assuming — this is one of the patterns most often implemented as styled divs.

Both `vlsuite_shuttle` and `vlsuite_demo` pull it in, so it is part of the suite's baseline.

---

- Show several panels in one section.
- Present a specification in tabs.
- Group FAQs by category.
- Offer versions for different audiences.
- Fit more content above the fold.
- Avoid an over-long linear page.
- Check keyboard operation of tabs.
- Verify aria-selected on the active tab.
- Associate panels with their tabs.
- Move between tabs with arrow keys.
- Avoid putting important content on a later tab.
- Consider search visibility of hidden panels.
- Style tabs with utility classes.
- Save a tabbed section to the library.
- Audit tab implementations for accessibility.
