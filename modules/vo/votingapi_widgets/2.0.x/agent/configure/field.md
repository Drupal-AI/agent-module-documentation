# Add a Voting API field to an entity

Field type `voting_api_field` (widget `voting_api_widget`, formatter `voting_api_formatter`).
Add it like any field: *Manage fields* on a bundle → add field → **Voting api field**.
Cardinality is forced to 1 and locked (`VotingApiWidgetsFormHooks::fieldConfigEditFormAlter`).

## Storage settings (`defaultStorageSettings`, set once, locked after data exists)
- **vote_type** — the Voting API `VoteType` entity (default `vote`).
- **vote_plugin** — which widget: `fivestar` | `like` | `useful` (default `fivestar`). This is
  the `VotingApiWidget` plugin id; see [../plugins/widgets.md](../plugins/widgets.md).
- `status` — default voting status (0 = no / 1 = closed / 2 = open).

## Instance (field) settings (`defaultFieldSettings`)
- **result_function** — default `vote_average`; typically set to a per-field derivative like
  `vote_field_average:<entity_type>.<field_name>` (see [../plugins/vote-results.md](../plugins/vote-results.md)).
- **widget_format** — default `fivestar`.
- **anonymous_window** / **user_window** — vote "rollover" in seconds: how long before a repeat
  vote from the same anon IP / user id is treated as a *new* vote vs. an edit of the existing
  one. `0` = immediately unique, `-1` = never (one vote ever), `-2` = use `votingapi.settings`
  site default. Allowed values are a fixed set (300 … 604800). Enforced in
  `VotingApiWidgetBase::getWindow()` / `getEntityForVoting()`.

## Widget settings (form display, `voting_api_widget`)
- **show_initial_vote** — on the entity edit form, expose a "Your vote" select so an initial
  vote can be seeded. The Open/Closed **status** radios and the vote select each only render if
  the user holds the matching per-field permission.

## Formatter settings (view display, `voting_api_formatter`)
- **style** — a style from the widget's `getStyles()` (fivestar: `default`, `css-stars`,
  `fontawesome-stars`, `bootstrap-stars`, `bars-horizontal/movie/pill/square`; like/useful:
  `default` only).
- **readonly** — render results but disable voting.
- **show_results** — append the results summary (themed `votingapi_widgets_summary`).
- **show_own_vote** — show the viewer's own cast vote instead of the aggregate (useful on
  add/edit forms). Only the `voting_api_formatter`'s result functions that have a derivative id
  are offered.

The formatter renders the vote form through a lazy builder (`voting_api.lazy_loader:buildForm`,
`#create_placeholder`), so per-user vote state stays out of the page cache. Result summaries can
be themed per plugin/entity-type/bundle/field via `hook_theme_suggestions_alter` (templates in
`templates/votingapi-widgets-summary*.html.twig`).
