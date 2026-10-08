<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access, routes and reaching the analyzer

## Permission

- `access seo analyzer` — title "Access SEO Analyzer", "Allows users to analyze the SEO of a node"
  (`seo_analyzer.permissions.yml`). Single permission; not marked `restrict access`. Grant it with
  `drush role:perm:add <role> 'access seo analyzer'`.

## Routes (`seo_analyzer.routing.yml`)

| Route name | Path | Controller method | Requirement |
| --- | --- | --- | --- |
| `entity.node.seo_analyzer` | `/node/{node}/seo-analyzer` | `SeoAnalyzerController::generateAnalyzerPageFromNode` | `_permission: 'access seo analyzer'` |
| `entity.canvas_page.seo_analyzer` | `/canvas_page/{canvas_page}/seo-analyzer` | `SeoAnalyzerController::generateAnalyzerPageFromCanvasPage` | `_permission: 'access seo analyzer'` |

Both routes carry `_admin_route: TRUE`, `_node_operation_route: TRUE`, and upcast the `{node}` /
`{canvas_page}` slug to a loaded entity (`options.parameters`). Access is the single permission check
above — there is no per-entity/per-bundle access rule, so anyone holding `access seo analyzer` can run
the analyzer against **any** node (or canvas page) id, including unpublished ones. The
`entity.canvas_page.seo_analyzer` route only resolves when the Canvas / Experience Builder module is
installed (its controller type-hints `Drupal\canvas\Entity\Page`).

## How editors reach it

`seo_analyzer_entity_operation()` adds an **SEO Analyzer** operation (weight 100) to the operations
list of every saved `node` and `canvas_page`, and `seo_analyzer.links.task.yml` adds a matching local
task tab (`base_route` = the entity's `canonical`). Both point at the routes above, so the link only
shows/works for users with the permission.

## Query parameter

The keyword to score against is read from `?keyword=` (see
[../forms/keyword-form.md](../forms/keyword-form.md)); no other input drives the page. The analyzed URL
itself is derived server-side from the entity's canonical route — it is not taken from the request.
