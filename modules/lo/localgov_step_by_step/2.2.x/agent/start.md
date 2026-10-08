<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# LocalGov Step by step (localgov_step_by_step) — agent index

Sequential "journey" content: an overview node owning ordered step pages, plus a *part of* block.
No `configure` route, no permissions of its own, no config schema, no Drush. Requires
`localgov_core` and **`preview_link`**, plus core `path`, `text`, `views`.

Key facts:
- Bundles: **`localgov_step_by_step_overview`** (field `localgov_step_by_step_pages` — ordered
  references, defines step order) and **`localgov_step_by_step_page`** (field
  `localgov_step_parent`).
- Sync is **one-way**, unlike LocalGov Guides: `hook_node_insert()` delegates to
  `hook_node_update()`, which returns immediately unless the bundle is
  `localgov_step_by_step_page`, then:

  ```php
  $overview = $page->localgov_step_parent->entity ?? FALSE;   // nothing to do if unset
  // append $page->id() to $overview->localgov_step_by_step_pages unless already referenced
  $overview->save();
  ```

  Failures are caught and logged to the **`localgov-step-by-step`** logger channel — the page save
  itself still succeeds. There is no reverse pass on the overview, so a page whose parent is
  cleared is **not** removed from the old overview's list automatically; tidy that by editing the
  overview.
- View `localgov_step_by_step_navigation` renders the step list;
  `hook_preprocess_views_view_list()` adjusts its markup for the numbered journey presentation.
- Block plugin `StepPartOfBlock` — shows the containing journey and position on a step page.
- `PreviewLinkAutopopulate` plugin `StepBySteps` — a preview link on an overview covers its steps.
- `hook_modules_installed()` imports optional config for `localgov_services_navigation` /
  `localgov_topics` (skipped during config sync).
- `hook_localgov_roles_default()` grants editor/author permissions for both bundles, including
  `view scheduled transitions node localgov_step_by_step_overview` / `…_page` when Scheduled
  Transitions is in use.

Building a journey:

```bash
drush php:eval '
$o = \Drupal\node\Entity\Node::create(["type" => "localgov_step_by_step_overview", "title" => "Report a pothole"]);
$o->save();
foreach (["Find the location", "Describe the damage", "Submit"] as $t) {
  \Drupal\node\Entity\Node::create([
    "type" => "localgov_step_by_step_page", "title" => $t, "localgov_step_parent" => $o->id(),
  ])->save();
}'
```
