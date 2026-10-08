A Paragraphs-based "Stats" component that renders a row of impact numbers (each with a number, label/text, optional icon image and link) plus an optional heading and intro text, in one of three predefined layouts.

---

Extra Paragraph Types (EPT): Stats adds two Paragraphs types — `ept_stats` (the container, with Title, Text and a repeatable stats field) and `ept_stats_item` (one stat: number, text, image, link) — so editors can build "500+ clients / 20 years / 99% uptime" style blocks anywhere Paragraphs are allowed (nodes, other paragraphs, Layout Builder via paragraph reference). It is part of the EPT family and reuses ept_core's shared EPT settings widget for design options (spacing, background, container width) and a style selector offering "Stats with vertical dividers", "Stats in squares", and "Stats in column". The module is display-only: it ships paragraph types, fields, view/form displays, three component CSS libraries and two Twig templates. It defines no routes, permissions, services (beyond a hook wrapper), or Drush commands, and stores no configuration object of its own — all sitewide EPT design settings live in ept_core.

---

- Add a "clients / projects / years" statistics band to a landing page
- Show company milestones as big numbers with short captions
- Display product metrics (users, downloads, uptime) in a marketing section
- Build an "our impact" section for a nonprofit or NGO page
- Present KPIs on a dashboard-style content page
- Create a fundraising progress row (amount raised, donors, days left)
- Show event stats (attendees, speakers, sessions, sponsors)
- Add a results/outcomes strip to a case-study node
- Render conference or course numbers (hours, modules, certificates)
- Display team size, office locations, and countries served
- Build a "by the numbers" block reusable across multiple pages
- Present portfolio counts (projects delivered, awards won)
- Add an at-a-glance metrics row to an About page
- Show SaaS plan comparison headline figures
- Present survey or research findings as headline percentages
- Add icons next to each figure using the per-item image (Media Image)
- Link each stat to a detail page via the per-item link field
- Choose a vertical-divider layout for a clean multi-column band
- Choose a "squares" layout to render each stat inside a card
- Choose a "column" layout to stack stats vertically on narrow content
- Reuse ept_core design controls to set background color/image and spacing
- Nest a Stats paragraph inside other EPT paragraphs (e.g. columns/containers)
- Place Stats blocks in Layout Builder through a paragraph reference field
- Localize numbers and captions where content translation is enabled
- Standardize statistics presentation across a multi-editor site without custom code
