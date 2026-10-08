<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
VLSuite Block Paragraph places paragraph entities inside the suite's block-and-layout structure.

---

Plenty of Drupal sites built their page composition on Paragraphs before Layout Builder was viable, and those sites have years of content in paragraph entities. A suite that ignores them forces a migration before anything can be adopted.

This component is the bridge: paragraphs render inside a VLSuite layout, so a site can adopt the suite for new pages while existing paragraph content keeps working, and migrate at whatever pace it chooses.

It is also useful in the other direction. Paragraphs remain a good fit for repeatable structured content *within* a component — a list of steps, a set of statistics, a table of specifications — where Layout Builder's per-instance placement would be overkill. Using both for what each is good at is a legitimate architecture, not a transitional compromise.

The thing to avoid is the third state: some pages built with paragraphs, some with Layout Builder, no rule about which. That is where editors stop knowing where to add content and where a template change has to be made twice.

---

- Render existing paragraph content in a layout.
- Adopt the suite without migrating paragraphs first.
- Migrate paragraph pages gradually.
- Use paragraphs for repeatable structured content.
- Nest a list of steps inside a component.
- Show a set of statistics as paragraphs.
- Combine Paragraphs and Layout Builder deliberately.
- Avoid an unplanned mix of both.
- Keep a template change in one place.
- Plan a migration path off Paragraphs.
- Reuse existing paragraph types.
- Translate paragraph content in a layout.
- Audit which pages use which approach.
- Document the composition rule for editors.
- Decide where each approach applies.
