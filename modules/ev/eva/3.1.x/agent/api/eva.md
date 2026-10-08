# API — services, hooks, plugin & template

EVA is driven by core Views hooks and two small services. There is no public settings API.

## Views display plugin

`Drupal\eva\Plugin\views\display\Eva` — annotated `@ViewsDisplay(id = "entity_view")`, theme
`eva_display_entity_view`, `uses_hook_entity_view = TRUE`, `uses_attachments = TRUE`. It is a
`DisplayPluginBase` subclass (not a new plugin *type* — it implements the existing Views display
type). Notable methods: `defineOptions()` (defaults: `argument_mode` = `id`, `disable_by_default`
= FALSE, `eva_hide_empty` = FALSE), `optionsSummary()`, `buildOptionsForm()`, `validate()`
(requires an entity type), `getPath()` (returns the attached entity's canonical URL when
available), and `execute()` (renders, honoring `eva_hide_empty`).

## Services

- **`eva.view_displays`** — `Drupal\eva\ViewDisplays` (args: `@cache.default`, `@cache.render`,
  `@config.factory`).
  - `get($type = NULL)` — cached list (cache id `eva.views_list`) of EVA attachments, keyed by
    entity type. Each entry: `name`, `id`, `title`, `display`, `bundles`, `uses exposed`,
    `disable_by_default`. Pass an entity type id to get just that type's attachments. Built from
    `Views::getApplicableViews('uses_hook_entity_view')`.
  - `reset()` — clear detached fields and invalidate caches (on module enable/disable).
  - `invalidateCaches()` — invalidate the EVA list cache and delete render cache.
  - `clearDetached($remove_one = NULL, $remove_all = FALSE)` — strip stale EVA pseudo-fields
    (and their `_form` exposed-form fields) from `core.entity_view_display.*` configs.

- **`eva.token_handler`** — `Drupal\eva\TokenHandler` (arg: `@token`).
  - `getArgumentsFromTokenString($string, $type, $object)` — runs core token `replace()` on the
    slash-separated string against the entity (`sanitize => FALSE`) and returns the args array.

## Hooks EVA implements (in `eva.module`)

- `hook_help()` — module help text.
- `hook_entity_extra_field_info()` — exposes each EVA display (and its `_form` exposed form) as
  a pseudo-field on the target entity type/bundles; `visible` follows `disable_by_default`.
- `hook_entity_view()` — the render path: sets the view display, builds the entity argument
  (`id` → `[$entity->id()]`; `token` → token-replaced args), adds an argument-based render cache
  key, optionally renders the exposed form, and places the output into `$build`.
- `hook_modules_enabled()` / `hook_modules_disabled()` — call `eva.view_displays::reset()`.
- `hook_ENTITY_TYPE_presave()` (`eva_view_presave`) — removes the `eva` dependency from a view
  when it no longer has any `entity_view` displays.
- `hook_views_invalidate_cache()` — clears detached fields, invalidates caches, and clears
  cached field definitions.

## Theming

- Theme hook / template: `eva_display_entity_view` → `templates/eva-display-entity-view.html.twig`.
- `template_preprocess_eva_display_entity_view()` sets `title` (when `show_title`),
  `exposed_form_as_field`, `css_name`, `id`, `display_id`, `dom_id`, and CSS class.
- `hook_theme_suggestions_HOOK_alter()` adds per-view (`…__{view_id}`) and per-display
  (`…__{view_id}__{display_id}`) template suggestions.

## Dependencies

Requires core `views`. Optional `drupal/token` (composer `suggest`) enables the token browser on
the arguments form (uses `token.entity_mapper` and the `token_tree_link` theme element).
