# Services, hooks & the vote-submission flow

## Services (`votingapi_widgets.services.yml`)
- `plugin.manager.voting_api_widget.processor` → `VotingApiWidgetManager` — the widget plugin
  manager (see [../plugins/widgets.md](../plugins/widgets.md)). Class-name alias available.
- `voting_api.lazy_loader` → `VotingApiLazyLoader` (autowired) — `TrustedCallbackInterface`
  lazy builder. `buildForm($plugin_id, $entity_type, $bundle, $entity_id, $vote_type,
  $field_name, $settings)` instantiates the widget and returns its `buildForm()` render array.
  This is the `#lazy_builder` callback the formatter registers so each user gets their own
  (uncacheable) vote form while the host entity stays cacheable.
- Hook service classes (autowired): `VotingApiWidgetsEntityHooks`,
  `VotingApiWidgetsFormHooks`, `VotingApiWidgetsHelpHooks`.

## Hook classes (`src/Hook/*`, OOP `#[Hook]` + `#[LegacyHook]` shims in the .module)
- **`VotingApiWidgetsEntityHooks`**
  - `entity_base_field_info` — adds a `field_name` base field to the `vote` entity so votes can
    be tied back to the widget field they came from.
  - `entity_type_build` — for every widget plugin, registers form class
    `Form\BaseRatingForm` as the `votingapi_<plugin_id>` operation form on the `vote` entity.
- **`VotingApiWidgetsFormHooks::fieldConfigEditFormAlter`** — on a `voting_api_field` config
  edit form, forces cardinality to 1 and hides the cardinality control.
- **`VotingApiWidgetsHelpHooks`** — `hook_help` text.
- `.module` also has `hook_theme` (`votingapi_widgets_summary`),
  `hook_theme_suggestions_alter` (per plugin/entity/bundle/field summary templates), and a
  preprocess that zeroes an empty result count.

No `hook_*.api.php` file and no Drush commands ship with the module.

## Vote-submission flow
1. Formatter (`VotingApiFormatter::viewElements`) emits a `#lazy_builder` pointing at
   `voting_api.lazy_loader:buildForm` with the field's plugin id + host entity coordinates +
   serialized formatter settings.
2. Lazy loader instantiates the `VotingApiWidget` plugin and calls `buildForm()`, which calls
   `VotingApiWidgetBase::getForm()` → builds `BaseRatingForm` (a `ContentEntityForm` on a `vote`
   entity) via the entity form builder.
3. `BaseRatingForm::buildForm()` adds a `value` select (options = widget `values`), a
   `#type => 'button'` with an `#ajax` click callback (`ajaxSubmit`), the results container,
   and cache contexts `user.permissions` + `user.roles:authenticated`. The select is disabled
   when the formatter is read-only or `canVote()` is FALSE.
4. `ajaxSubmit()` → `save()` → **only persists if `$plugin->canVote($entity)`**, i.e. the user
   holds the field's `vote on …` (or `edit own vote on …`) permission; then rebuilds the form
   with fresh results. Vote identity/rollover is resolved in `getEntityForVoting()`.

The host entity coordinates come from the server-rendered formatter, not from client input, and
the form is a standard Form-API form (CSRF token); saving is permission-gated in `save()`.
