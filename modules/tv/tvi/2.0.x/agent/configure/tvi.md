# Configure — assign Views to term/vocabulary pages

## How it works

TVI's `RouteSubscriber` (priority -200, after Views) alters the
`entity.taxonomy_term.canonical` route so its `_controller` becomes
`TaxonomyViewsIntegratorTermPageController::render`. That controller asks the
`tvi.tvi_manager` service (`TaxonomyViewsIntegratorManager`) which View + display to
render for the term, then builds it, passing the term id as a contextual argument. A
`RouteEnhancer` (route_enhancer tag) also sets `view_id`/`display_id` on the route defaults
so `current_route_match` reflects the real View (needed by Search API, Facets, etc.).

## Where settings live (config objects)

| Config object | Scope | Set from |
|---|---|---|
| `tvi.global_settings` | Site-wide default | Settings form `/admin/config/user-interface/tvi` (route `tvi.global_settings`, form `TaxonomyViewsIntegratorSettingsForm`) |
| `tvi.taxonomy_vocabulary.{vid}` | One vocabulary | Vocabulary edit form (TVI fieldset injected via `hook_form_alter`) |
| `tvi.taxonomy_term.{tid}` | One term | Term edit form (TVI fieldset injected via `hook_form_alter`) |

Per-term/per-vocabulary records are created on save only when override is enabled; if you
uncheck override the record is deleted. Records are also auto-deleted when the term or
vocabulary is deleted. All three are config objects with schema in
`config/schema/tvi.schema.yml`, so they export/deploy with `drush config:export`.

### Keys

`tvi.global_settings` (defaults from `config/install/tvi.global_settings.yml`):

| Key | Default | Meaning |
|---|---|---|
| `disable_default_view` | `false` | If true, render **no** View by default (fall through to plain taxonomy) |
| `enable_override` | `false` | If true, use the global `view`/`view_display` for all term pages |
| `view` | `taxonomy_term` | View machine id |
| `view_display` | `page_1` | View display id |

`tvi.taxonomy_term.{tid}` and `tvi.taxonomy_vocabulary.{vid}`:

| Key | Meaning |
|---|---|
| `enable_override` | Turn this scope's override on |
| `view` | View machine id |
| `view_display` | View display id |
| `inherit_settings` | Children/terms inherit this scope's View ("Child terms will use these settings") |
| `pass_arguments` | Pass all trailing URL args (after `/taxonomy/term/`) to the View; if false, the View only receives tid and tid_depth |

## Precedence (source of truth: `getTaxonomyTermViewAndDisplayId()`)

Resolved for each term, highest wins:

1. **Per-term override** — `tvi.taxonomy_term.{tid}` with `enable_override` true.
2. If no term override: **vocabulary override** (`tvi.taxonomy_vocabulary.{vid}` with
   `enable_override` **and** `inherit_settings`), then any **parent term** override with
   `enable_override` **and** `inherit_settings`.
3. **Global override** — `tvi.global_settings` with `enable_override` (its `view`/`view_display`).
4. **Core default** — `taxonomy_term` / `page_1`, unless `disable_default_view` is set
   (then no View, and the controller falls back to the standard term view builder).

If the resolved View is missing or disabled, the controller falls back to the default
core taxonomy_term view builder (`full` view mode).

## Set values with drush (example)

```
drush cset tvi.global_settings enable_override true
drush cset tvi.global_settings view my_events_view
drush cset tvi.global_settings view_display page_1
```

To make a View argument-aware, add **Taxonomy: Term ID (with depth)** and **Term ID depth
modifier** contextual filters to it (TVI passes the tid and depth by default).
