<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Timeline Block provides one placeable block plugin whose items (Time, Title, Description, weight) an editor types into the block configuration form, rendered as a chronological timeline in one of 10 pure-CSS layouts.

---

Timeline Block is a self-contained block plugin (id `timeline_block`), not a Views style or a field formatter: the events live in the block's own configuration rather than in content. You place the block through Block layout (or drop it into a Layout Builder section), then in the block form you add timeline items with an AJAX "Add timeline" button. Each item has a plain-text **Time** label (e.g. a year or phase), a plain-text **Title**, a rich-text **Description** (a `text_format` field defaulting to `basic_html`), and a numeric **weight** (1-120) that controls order — items are sorted by weight on save. A block-wide rich-text **Timeline header** sits above the items, and a **Timeline layout** select chooses one of ten prebuilt arrangements (Layout 1-10: alternating two-sided rails, single-column cards, numbered steps, coloured cards, a plain ordered list, and so on). On save the item set is serialised to JSON and kept as block config (`timeline_data`, `timeline_header`, `timeline_layout`). Rendering goes through the `timeline_block` theme hook and the bundled `templates/timeline-block.html.twig`, which holds the markup for all ten layouts and branches on the stored layout value; the only asset is the theme CSS library `css/timeline.css` — there is no JavaScript and nothing loaded from a CDN. Because the content is stored in configuration, a timeline built this way is invisible to search and to editorial workflow and must be edited in the block form itself; it does not update from content the way a view of dated nodes would. The Description and header are rich text run through their stored text format at render time; images embedded in them via CKEditor are tracked as permanent file usage and released when the block or item is removed. Requires only core `block` per its info file, though it also relies on core `file`, `editor` and `filter` at runtime. Override the Twig template and CSS in your theme to change or extend the layouts.

---

- Show an organisation's history as a vertical timeline in a sidebar or page region.
- Present project milestones or a product roadmap as dated steps.
- Display a company "key dates" / about-us chronology.
- Render a founder or personal biography timeline.
- Show a product's release history block.
- Present a conference or event programme in chronological order.
- Display the phased stages of a construction or restoration project.
- Show a research project's phases and deliverables.
- Present a campaign's progress over time.
- Display a heritage site's historical periods.
- Show an anniversary retrospective ("our journey").
- Present a hiring or onboarding process as ordered steps.
- Display a legal or investigation case chronology.
- Show a course or curriculum schedule as a timeline.
- Present a charity's fundraising milestones.
- Choose among 10 layouts to match a theme without writing CSS.
- Manually reorder events using the per-item weight field.
- Embed images inside a timeline item description via the rich-text editor.
- Add a rich-text header above the timeline for a title or intro.
- Override `timeline-block.html.twig` in a theme to build a custom layout or add JS.
