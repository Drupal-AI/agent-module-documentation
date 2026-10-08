<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Arguments Pros/Cons (arguments) — agent index

Defines a revisionable, translatable **`argument`** content entity that attaches **PRO/CONTRA**
arguments to a parent **node** (an "open question"/rule), and a context block that lists them
pro-vs-contra. Package **RulesFinder**. Core `^9 || ^10 || ^11`. License GPL-2.0-or-later.
Version 1.0.12.

- **Hard dependency:** `vote` (drupal/vote) — used to weight/sort arguments by vote result.
- **Optional:** integrates with `change_requests` and `history` modules only if present (no hard dep).
- No Drush commands. No config schema shipped. Permissions: yes (`arguments.permissions.yml`).

## Solution docs

- **The `argument` entity — fields, permissions, access, routes, revisions** →
  [entity/argument.md](entity/argument.md)
- **Configuration: `arguments.settings`, the settings form, enabling node types** →
  [config/settings.md](config/settings.md)
- **The Argumentation block, list/evaluating services, formatter, hooks** →
  [block/argumentation.md](block/argumentation.md)

## What it actually is (from source)

- One content entity `argument` (`src/Entity/Argument.php`, `@ContentEntityType`): base table
  `argument`, revisions + translations enabled, `admin_permission = "administer argument entities"`.
  Fields: `type` (list_integer PRO=1/CONTRA=2), `name` (title, max 80), `argument` (string_long
  body), `reference_id` (entity_reference → node), `user_id`, `status`, `created`/`changed`.
- Access handler `ArgumentAccessControlHandler` maps view/update/delete/create ops to the
  module permissions (no `_access: TRUE`, no owner-token shortcuts).
- Routes come from `ArgumentHtmlRouteProvider` (extends core `AdminHtmlRouteProvider`): canonical
  `/argument/{argument}`, add `/argument/add/{reference_id}`, edit, delete, and revision routes
  under `/admin/structure/argument/...`, plus settings `/admin/structure/argument/settings`.
- Two services (`arguments.services.yml`): `arguments.argument_list_service` (`ArgumentListService`)
  builds the two-column list; `arguments.evaluating_service` (`EvaluatingService`) counts pro/con.
- One block plugin `argumentation_block` (`ArgumentationBlock`) and one field formatter
  `attach_change_requests` (`AttachChangeRequestFormatter`, optional change_requests integration).
- Config object `arguments.settings` (install defaults only; no schema dir).
- Constants in `src/Events/ArgumentsEvent.php`: `ARG_PRO=1`, `ARG_CON=2`, `ARG_DEFAULT=1`
  (despite the "Events" namespace this is a plain constants/util class, not an event).

## Key hooks (arguments.module)

- `hook_theme()` — themes `arguments`, `argument`, `arguments__header`, `rufi_chip`, etc.
- `hook_ENTITY_TYPE_view` (`arguments_argument_view`) — on the canonical full view, 301-redirects
  to the parent node with a `#argument_{id}` fragment; otherwise tags the build with an id/class.
- `hook_rufi_meta_node_rule` — emits a "pro:contra" count chip using `EvaluatingService`.
- `hook_entity_view_mode_alter` / `hook_entity_form_display_alter` — pick teaser_pro / edit_{type}
  display variants by argument type.
