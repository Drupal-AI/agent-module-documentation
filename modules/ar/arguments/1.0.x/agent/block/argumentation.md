<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Argumentation block, services, formatter & hooks

## Block: `argumentation_block`

`src/Plugin/Block/ArgumentationBlock.php` (`@Block id="argumentation_block"`, category
"RulesFinder", context `node = entity:node`). Injects `entity_type.manager`, `config.manager`,
`arguments.argument_list_service`, `current_user`.

- `blockForm()`/`blockSubmit()` store one config key `introduction` (textfield, maxlength 128).
- `build()` reads the current `node` context. It renders arguments **only** if the node is not new
  and its type is enabled in `arguments.settings:arguments.arguments_node_types`.
- Renders: an "Add Argument" link (from `ArgumentListService::getAddArgumentLink`, itself gated by
  `add argument entities`), a client-side vote sorter `div` (`data-votejsr`), and the two-column
  list from `ArgumentListService::render($node->id())`.
- If `history` module is enabled and the user is authenticated, attaches
  `comment/drupal.comment-new-indicator` and a `data-history-node-id` for "mark as new".
- Cache: tags `['rufi_block']`, contexts `['user.roles:authenticated']`.

## Service: `ArgumentListService` (`arguments.argument_list_service`)

`src/ArgumentListService.php`. Constructor args: `@module_handler`, `@entity_type.manager`,
`@current_user`, `@vote.votingapi`.

- `load($reference_id)` → `getEntityIds()` runs an **access-checked** entity query
  (`->accessCheck()`) filtered by `reference_id`, sorted by id.
- `render($reference_id)` builds the `#theme => 'arguments'` structure with `pro`/`con` buckets,
  splitting by `type` (PRO/CONTRA). Each item = `buildItem()` → teaser view + operations +
  a vote-derived `#weight` from `getWeight()`.
- `getWeight($id)` calls `vote.votingapi` `getResults('argument', $id, TRUE)` and returns
  `round(abs * -100)`.
- `getOperations()`/`getDefaultOperations()` build edit/revisions/delete links, each guarded by
  the entity's own `access('update'|'view'|'delete')` check with cacheable dependencies.
- `getAddArgumentLink()` returns the add link only if the user has `add argument entities`.

## Service: `EvaluatingService` (`arguments.evaluating_service`)

`src/EvaluatingService.php`, arg `@database`. `getRuleArgumentCounts($id)` runs a parameterized
`select('argument_field_data')` filtered by `reference_id` and `status = 1`, tallying PRO vs CON.
Used by `arguments_rufi_meta_node_rule()` to emit a "pro:contra" count chip. Query uses
`->condition()` bindings (no string concatenation).

## Field formatter: `attach_change_requests` (optional)

`src/Plugin/Field/FieldFormatter/AttachChangeRequestFormatter.php`. `@FieldFormatter` for
`entity_reference` fields, but `isApplicable()` restricts it to fields whose `target_type == 'patch'`.
It references `Drupal\change_requests\Events\ChangeRequests` — usable **only when the separate
`change_requests` module is installed** (not a declared dependency). Settings: `display_modal`,
`display_add_link`, `show_empty_field`. Renders change-request links as `rufi_chip_set` chips,
optionally in an AJAX modal (`core/drupal.dialog.ajax`). The add link needs `add patch entities`.

## Theme hooks (`arguments.module`)

- `arguments_theme()` registers `arguments`, `argument`, `arguments__header`, `argument__teaser`,
  `argument__teaser_pro`, `change_request__list_item`, `rufi_chip_set`, `rufi_chip`.
- `arguments_argument_view()` — on the canonical **full** view of an argument, 301-redirects to
  the parent node with fragment `#argument_{id}` (internal redirect to the referenced node's own
  URL); on other views adds an `argument_{id}` id + `argument-{type}` class. Also rewrites the
  operations into a `drop_menu` render element.
- `arguments_entity_view_mode_alter()` swaps teaser → `teaser_pro` for PRO arguments;
  `arguments_entity_form_display_alter()` swaps to an `edit_{type}` form display if defined.
- `template_preprocess_argument()` (`argument.page.inc`) exposes `argument` + `content` vars.

## Libraries (`arguments.libraries.yml`)

`arguments.list` (css only) and `arguments.teaser` (css + `js/argument-teaser.js`, deps
`core/jquery`, `core/drupal`). No external/CDN assets.
