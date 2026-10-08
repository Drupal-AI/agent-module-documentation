<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
DXPR Theme Helper is a companion module for DXPR Theme that adds a full-screen search block, a user-registration block, per-node page-layout fields, a set of `dxt:*` Drush commands for reading and writing DXPR Theme settings, and AI-powered color-palette and font generators.

---

The module bundles several loosely related helpers. Two **blocks**: `full_screen_search` ("DXPR Theme Full Screen Search"), which renders a toggleable full-screen search form backed by either Core Search or Search API Block (configurable via `search_provider`, `search_url`, `search_parameter`), and `dxpr_theme_helper_user_register`, which renders the user registration form (shown only to anonymous users when registration is open). Five optional **node fields** (installed as optional config) let editors override layout per page: `field_dth_page_layout` (fullwidth/boxed), `field_dth_main_content_width`, `field_dth_hide_regions` (multi-value list of regions to hide), and two media reference fields `field_dth_body_background` and `field_dth_page_title_backgrou`. A custom **theme negotiator** (`DxprThemeSettingsThemeNegotiator`, priority 1000) keeps the correct theme context on the theme-settings form. The module's headline feature set is its **Drush command suite** under the `dxt:*` namespace (aliases `dxt-*`): `dxt:config:get/set/list/export/import/reset` for schema-validated DXPR Theme settings, `dxt:palette:get/set`, `dxt:page:get/set` for node layout fields, `dxt:subtheme:create`, and `dxt:setup-ai` to install AI-assistant skill files — plus **AI generators** `dxt:generate:palette` and `dxt:generate:fonts` (services `dxpr_theme_helper.ai_palette_generator` / `ai_font_generator`) that call the optional `drupal/ai` module's chat provider to produce a validated color palette or font pairing from a natural-language prompt. Settings introspection is driven by a bundled `data/settings-schema.json`. The config-writing commands (`dxt:config:*`, `dxt:palette:*`) require a DXPR Theme (or subtheme) to be installed to target; the schema-listing commands (`dxt:config:list`) work from the bundled JSON. The module ships config schema for the search block, has no permissions of its own (routes use core's `administer themes`), and no configure route in its info.yml.

---

- Add a toggleable full-screen search overlay to a DXPR Theme site via the search block.
- Point the full-screen search block at Core Search or a Search API view (`search_provider`).
- Configure the search block's results path and query parameter (`search_url`, `search_parameter`).
- Place a user-registration form in any region with the user-registration block.
- Let editors switch a single node between full-width and boxed layout (`field_dth_page_layout`).
- Hide specific theme regions on a per-node basis (`field_dth_hide_regions`).
- Squish a node's main content column to 1/2, 1/3, 2/3, or 5/6 (`field_dth_main_content_width`).
- Set a custom body background or page-title background image per node (media fields).
- Read a DXPR Theme setting with schema metadata via `drush dxt:config:get <key>`.
- Change a DXPR Theme setting (validated, CSS rebuilt) via `drush dxt:config:set <key> <value>`.
- Introspect all valid values/ranges for a settings section: `drush dxt:config:list --section=header --detail`.
- List the available settings sections with `drush dxt:config:list --sections-only`.
- Export/import a theme's full settings as YAML (`dxt:config:export` / `dxt:config:import`).
- Reset a settings section (or all) to schema defaults with `dxt:config:reset`.
- Read/set the color palette and its Bootstrap variable mapping (`dxt:palette:get` / `dxt:palette:set`).
- Set a node's layout fields from the CLI with `drush dxt:page:set <nid> --layout=boxed`.
- Generate a color palette from a prompt like "Modern tech startup" (`dxt:generate:palette`).
- Generate a font pairing from a description (`dxt:generate:fonts`), optionally `--apply`.
- Create a DXPR Theme subtheme from the starterkit (`dxt:subtheme:create`).
- Install AI coding-assistant skill files so agents discover the `dxt:*` commands (`dxt:setup-ai`).
- Preview any state-changing command safely with `--dry-run`.
- Target a specific subtheme with `--theme=<name>` on any `dxt:*` command.
- Keep the theme-settings form on the correct theme via the custom theme negotiator.
- Automate DXPR Theme configuration in CI/deployment using the `dxt:config:*` commands.
