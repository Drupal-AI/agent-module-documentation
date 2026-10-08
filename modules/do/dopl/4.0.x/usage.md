<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
A text-format filter that turns short shorthand tokens (e.g. `views.module`, `345196.issue`) in body text into resolved links to Drupal.org projects, nodes, issues, groups and users.

---

Drupal.org project link filter (dopl) provides a single filter plugin (`filter_dopl`, class `Drupal\dopl\Plugin\Filter\FilterDopl`) that scans processed text for shorthand tokens and rewrites them as anchors. Project shorthands (`name.module`, `name.theme`, `name.translation`, `name.installprofile`, `name.project`) all resolve to `drupal.org/project/name`; numeric shorthands resolve nodes (`nid.do`, `nid.issue`), groups.drupal.org nodes (`nid.gdo`) and users (`nid.user`). For each token the filter calls the public Drupal.org `api-d7` JSON endpoints (or scrapes the groups.drupal.org page `<title>`) at render time to fetch the real title and canonical URL, caches that result permanently, and emits a link whose visible text is the fetched title (or an optional author-supplied label via the `|"custom text"` suffix). Issue tokens additionally get a status-colored wrapper span styled by the bundled `dopl/dopl` CSS library. It depends only on core `filter`, ships no settings form or permissions of its own (you enable it per text format on the core Text formats page, `filter.admin_overview`), and supports Drupal 9.3, 10 and 11. This documents the 4.x dev branch, which has no tagged stable release.

---

- Link to a Drupal.org project by writing `pathauto.module` in body text.
- Use `zen.theme` shorthand to link a theme's project page.
- Use `fr.translation` to link a translation project.
- Use `uberdrupal.installprofile` to link an install profile project.
- Use `name.project` as a generic project-page shorthand.
- Link a Drupal.org issue with `345196.issue` (renders `#nid: Title` with a status color).
- Link an arbitrary Drupal.org node with `345196.do`.
- Link a groups.drupal.org node with `345196.gdo`.
- Link a Drupal.org user account with `48488.user`.
- Give a link custom visible text with the `token|"My label"` suffix.
- Auto-resolve each token's real project/node/user title from the Drupal.org api-d7.
- Show issue status (Active, Fixed, Needs review, etc.) via a colored wrapper span.
- Write blog posts about Drupal modules without hand-writing project URLs.
- Cross-reference modules in community/documentation site content.
- Reference issues in changelog or release-notes content.
- Standardize how authors cite Drupal.org resources across a site.
- Enable the filter only on trusted text formats (e.g. Full HTML) for editors.
- Reduce broken/incorrect project URLs by resolving canonical links automatically.
- Cache resolved links permanently so repeated tokens do not re-fetch.
- Combine with other filters, ordering it in the text format's filter processing order.
- Provide contributors a quick shorthand for linking during code review write-ups.
- Read the built-in help (hook_help renders README.txt) at `/admin/help/dopl`.
- View author-facing token syntax via the filter's `tips()` on the text-format form.
