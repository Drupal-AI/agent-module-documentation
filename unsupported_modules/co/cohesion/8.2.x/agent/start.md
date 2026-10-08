<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Studio core (cohesion) — agent index

Base module of **Acquia Site Studio** (formerly Cohesion): entities, API layer, admin controllers
and Drush commands for the low-code page-building system. Installed release **8.x-8.2.6**,
core `^10.2.2 || ^11`. Requires `contextual`, `imce`, `token`, `entity_reference_revisions`,
`rest`, `ckeditor5`, `jquery_ui`.

> **Commercial product.** Site Studio needs an Acquia licence/API key for its build service;
> without valid credentials the module installs but cannot compile styles or templates.

Key facts:
- Large surface: ~**460 routes**, its own permission set (`administer cohesion settings`
  (restrict access), `administer cohesion`, `administer front end settings`, …), config
  `cohesion.settings` and `cohesion.frontend.settings`.
- **Drush commands** (`src/Drush/Commands/Dx8Commands.php`, annotation style):

  | Command | Purpose |
  |---|---|
  | `cohesion:import` | Import Site Studio definitions (run on a new environment) |
  | `cohesion:rebuild` | Rebuild generated styles/templates — **the post-deploy command** |
  | `sitestudio:cleanup-orphans` | Remove orphaned Site Studio entities |

- Base classes worth knowing: `CohesionConfigEntityBase`, `EntityJsonValuesInterface` (Site Studio
  entities store their definition as JSON), `ContentIntegrityInterface`,
  `CohesionEntityAutocompleteMatcher`, `CohesionSettingsInterface`.
- **Submodules** (17): `cohesion_elements`, `cohesion_templates`, `cohesion_custom_styles`,
  `cohesion_base_styles`, `cohesion_style_guide`, `cohesion_style_helpers`,
  `cohesion_website_settings`, `cohesion_sync` (package export/import),
  `cohesion_breakpoint_indicator`, `sitestudio_page_builder` (in-page editor),
  `sitestudio_governance`, `sitestudio_data_transformers`, `sitestudio_claro`,
  `sitestudio_legacy_ckeditor`, plus `example_custom_component`, `example_custom_select`,
  `example_element`.
- **Alter hooks come in pairs** — a modern `sitestudio_` name and a legacy `dx8_` alias
  (`cohesion.api.php`):
  - `hook_sitestudio_api_outbound_data_alter()` / `hook_dx8_api_outbound_data_alter()`
  - `hook_sitestudio_ENTITY_TYPE_drupal_token_context_alter()` / `hook_dx8_…`
  - `hook_sitestudio_ENTITY_TYPE_drupal_field_prefix_alter()` / `hook_dx8_…`
  - `hook_sitestudio_ENTITY_TYPE_drupal_field_variable_alter()` and the
    `ENTITY_TYPE_BUNDLE` variant, each with a `dx8_` twin.
  Implement the `sitestudio_` names; the `dx8_` ones exist for backwards compatibility.

Deployment checklist:

```bash
drush cohesion:import          # first time on a new environment
drush cohesion:rebuild         # after every deploy that changes Site Studio config
drush sitestudio:cleanup-orphans
```

Forgetting `cohesion:rebuild` after a deploy is the classic Site Studio failure mode — styles and
templates are generated artefacts, not config.
