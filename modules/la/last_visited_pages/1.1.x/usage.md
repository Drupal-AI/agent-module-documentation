<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Last Visited Pages records the pages each user visits and provides a block that lists the title, link and time of their recent visits — a per-user "recently viewed" history.

---

Install it with `composer require drupal/last_visited_pages` and enable it (it depends on core's **Block** module); a `last_visited_pages` database table is created to hold the history. From then on an event subscriber watches every request and, for any page that has a title, stores the page's **title, path and time** against the visitor — keeping the **20 most recent** entries per user. To surface the history, place the **Last Visited Pages** block (in Block layout) in a region such as a sidebar or footer; its block settings let you choose how many links to show and the date format (a named format like *medium*, or a custom PHP date pattern), and whether to display the block label. A site-wide settings form at **Configuration** (`/admin/config/last-visited-pages-settings`, requires *Administer site configuration*) sets `max_places`, the ceiling for the "number of items" choice offered to blocks. Because the block's cache max-age is 0 it always reflects the latest visits. Bear in mind this is per-user browsing-history tracking — a privacy surface worth a deliberate decision about who is tracked and how the block is scoped before switching it on for a broad audience.

---

- Show a user their recently viewed pages in a block.
- Add a "recently viewed" navigation aid to a sidebar or footer.
- Help users retrace their steps on a content-heavy site.
- Aid navigation on a large intranet or documentation site.
- Offer a catalog "recently viewed" list for shoppers.
- List recent page titles as clickable links.
- Show the time each page was visited next to each link.
- Choose a named date format (short, medium, long) for the timestamps.
- Use a custom PHP date pattern for the visit time.
- Configure how many recent links a block shows.
- Cap the maximum links offered to blocks via the settings form.
- Place the history block using normal Block layout regions.
- Restrict where the block appears with block visibility conditions.
- Show or hide the block's label heading.
- Keep the block current with its zero cache max-age.
- Limit stored history to the 20 most recent entries per user for performance.
- Support quickly returning to frequently used documents.
- Give authenticated users a personal visit history.
- Decide whether anonymous visitors should be tracked at all.
- Treat browsing history as a privacy surface before broad rollout.
- Remove the table cleanly by uninstalling the module.
- Inspect stored history directly in the `last_visited_pages` table.
