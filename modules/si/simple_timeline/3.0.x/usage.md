<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Simple Timeline adds a Views **style plugin** that renders the rows of any view as a vertical timeline, with each item as a marker on a central line.

---

The module's whole surface is a single Views style plugin, `simple_timeline`
(`SimpleTimeline`, extending `StylePluginBase`, theme `views_view_simple_timeline`). You pick
"Simple Timeline" as the Format of any view; it uses row plugins and supports per-row CSS
classes but not grouping. Four options are stored in the display's `style.options`:
`position_items` (`alternate` / `left` / `right` — where content sits relative to the line),
`position_marker` (`marker-top` / `marker-center` / `marker-bottom` — vertical marker
placement), `wrapper_class` (default `wrapper-list`), and `class` (the list element class,
default `item-list`). Output is themed by `templates/views-view-simple-timeline.html.twig`
with a theme-suggestion alter, and styled by the `simple_timeline/timeline` library
(`css/timeline.css`); the timeline colour and marker look are meant to be overridden with a
few CSS rules in your own theme (e.g. `ul.timeline-list:after { background-color: … }`). The
config is validated by `config/schema/simple_timeline.views.schema.yml` (fully-validatable,
with `Choice` constraints on the two position options and a class-name regex). There is no
settings form, no configure route, no permissions, and no Drush — everything is a per-view
style configuration.

---

- Show a company "history" / milestones view as a vertical timeline.
- Render a list of events chronologically down a central line.
- Display blog posts or news as a dated timeline.
- Build a project roadmap view with alternating left/right entries.
- Put all timeline content on the left of the line for a compact single-column layout.
- Put all content on the right of the line instead.
- Alternate items left and right around the line for a classic timeline look.
- Place the marker at the top, center, or bottom of each entry.
- Create a résumé / work-history page from a view of experience nodes.
- Show a changelog or release history as a timeline.
- Present a person's activity feed as a chronological timeline.
- Reuse any view fields/row plugin (fields or rendered entity) inside timeline items.
- Add a custom wrapper CSS class to hook your own timeline styling onto.
- Add a custom list CSS class for the timeline `<ul>`.
- Override the timeline line colour with a single CSS rule in your theme.
- Restyle the marker shape/colour via CSS (`span.timeline-marker`).
- Combine with exposed filters so visitors filter the timeline by date or category.
- Combine with a contextual filter to show a timeline per taxonomy term or author.
- Use with a pager to page through a long chronological list as a timeline.
- Export the timeline view as config for deployment across environments.
- Apply the timeline to non-node entities (users, media, custom entities) via a view.
