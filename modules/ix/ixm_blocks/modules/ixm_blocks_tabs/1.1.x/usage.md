<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
IXM Blocks Tabs shows several panels of content in one place, one at a time.

---

Tabs suit parallel alternatives — versions of the same information for different audiences, a specification split by category, a product's description, reviews and delivery information.

**They hide content, and that trade should be stated rather than discovered.** Anything on a tab other than the first is unseen by most visitors and historically weighted less by search engines. Putting something important on the third tab is putting it nowhere; the pattern is for alternatives, not for a way to fit more in.

**The ARIA tab pattern is well defined and specific**: arrow keys move between tabs, Tab moves into the panel, the selected tab carries `aria-selected`, and each panel is associated with its tab. This is one of the patterns most often shipped as styled divs with a click handler, which is not accessible — verify against what the block actually renders rather than assuming.

---

- Show alternatives in one place.
- Split a specification by category.
- Offer versions for different audiences.
- Present description, reviews and delivery.
- Avoid putting important content on a later tab.
- Consider search visibility of hidden panels.
- Move between tabs with arrow keys.
- Move into a panel with Tab.
- Set aria-selected on the active tab.
- Associate panels with their tabs.
- Verify the ARIA tab pattern.
- Avoid a click-only implementation.
- Style tabs with the theme.
- Translate tab content.
- Audit tabs for accessibility.
