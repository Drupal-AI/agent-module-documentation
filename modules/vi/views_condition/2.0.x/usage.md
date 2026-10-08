<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Views Condition adds a condition plugin so blocks (and anything else using Drupal's condition system) can be shown or hidden based on **whether the current page is a view page**, and optionally **which view/display** is being rendered, rather than by path.

---

Block visibility in Drupal is usually configured by request path, which breaks as soon as a view's path changes, gets an alias, or has several displays under different URLs. This module supplies a single `views_condition` condition plugin that works from the current route instead. Its configuration form has a `radios` control with three modes: **Not Restricted** (always matches), **All View Pages** (matches whenever any view page route is being served), and **Specific View Pages**. In the last mode the form lists every enabled view that has an enabled `page` display as a collapsible `details` element containing a checkbox per display, so you tick exactly the view displays you want. Evaluation reads the `view_id` and `display_id` route parameters that Views sets on its page routes — it does **not** execute or query any view, so it is cheap and path-independent (aliases and language prefixes do not matter). Because it is an ordinary core condition plugin, it appears anywhere Drupal exposes conditions: block layout visibility, Layout Builder section visibility, the Context module, and any custom code that evaluates conditions. Pair it with the condition's built-in **negate** to express "everywhere except these view pages". A small JS library adds a summary to the block-settings vertical tab. There is no configuration of its own, no permissions, no schema and no Drush.

---

- Show a block only on a specific view page.
- Show a block on every view page regardless of path.
- Hide a block on all view pages (via negate).
- Target a block at one display of a multi-display view.
- Avoid path-based block visibility that breaks on alias changes.
- Show filters help text only on the search results view.
- Add a promotional block to a single directory listing.
- Show a "back to list" block only on view pages.
- Apply Layout Builder section visibility per view display.
- Combine with other conditions for finer targeting.
- Keep visibility rules stable when a view's path changes.
- Target attachment or feed page displays specifically.
- Show a legend block on a map view display only.
- Exclude a block from every view page in one rule.
- Support multilingual sites where paths differ per language.
- Use with the Context module for site-wide rules.
- Reduce brittle path patterns in block configuration.
- Show editorial guidance blocks on admin views pages.
- Restrict a block to a curated set of view displays at once.
- Document block placement intent in terms of views, not URLs.
