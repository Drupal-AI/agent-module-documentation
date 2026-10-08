# facets_demo — agent start

Facets submodule. A **demo/starter package**: installs a full working faceted-search example
(Search API DB index + view with exposed facets + sample content) and the suggested contrib
modules. Not for production — enable on a scratch/dev site to learn the recommended setup.

Pulls in `facets`, `facets_exposed_filters`, `search_api`, `search_api_db`,
`better_exposed_filters`, `views_ajax_history`, `views_filters_summary`, `default_content`.
Ships example config + sample nodes/terms (`default_content` UUIDs in the info.yml); assets
and templates under `assets/`, `content/`, `config/`, `templates/`.

No config UI, permissions, hooks, services, or plugin types of its own — it is pure example
configuration. See the main facets docs to understand what it demonstrates.
