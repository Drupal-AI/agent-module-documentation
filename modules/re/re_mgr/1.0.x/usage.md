<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Real Estate Manager (re_mgr)

Real Estate Manager provides a structured data model for managing property portfolios. It
defines four **hierarchical custom content entity types**:

- **Estate** → **Building** → **Floor** → **Flat**

Each type is bundleable (has its own *type* config entities), revisionable, and governed by
granular per-entity permissions (view/add/edit/delete/administer). A dedicated
entity-reference **autocomplete widget** links the levels together (e.g. a Floor references its
Building), reusing core's signed selection-settings mechanism.

The project ships three submodules:
- **re_mgr_presentation** — a block for presenting the data.
- **re_mgr_visualization** — a block that presents data visually (depends on presentation,
  webform, media).
- **re_mgr_demo** — installs demo data.

Administration lives under `/admin/re-mgr` (content, configuration, and a *Purge data* form).

---

## Installation & configuration

- Requires the contrib `entity` module (and, for visualization, `webform` and core `media`).
- Install with `drush en re_mgr` (and optionally the submodules).
- Manage content at *Admin → Real Estate Manager → Content*; manage bundles at
  *Configuration → Entities configuration*.
- Grant the appropriate per-entity permissions; *administer module* and the `administer *
  entity* permissions are marked restricted.
- Use the *Purge data* form (`/admin/re-mgr/config/purge`, permission *administer module*) to
  remove all module data.
- The autocomplete route `/re-mgr-entity-reference-autocomplete/...` is `_access: TRUE` but is
  protected by core's HMAC-signed `selection_settings_key` (same model as core entity
  autocomplete).

---

## Use cases

- Model a property portfolio as estates, buildings, floors and flats.
- Manage multi-building developments with per-floor and per-flat records.
- Track availability or status per flat as structured content entities.
- Use bundles to distinguish property categories within each level.
- Keep revision history of property records.
- Delegate access with fine-grained per-entity-type permissions.
- Link floors to buildings and buildings to estates via autocomplete.
- Exclude "final" floors from selection where appropriate.
- Present portfolio data in blocks via the presentation submodule.
- Build visual dashboards of the portfolio via the visualization submodule.
- Seed a demo dataset for evaluation with the demo submodule.
- Integrate property data with Webform-driven enquiry flows.
- Attach media to visual presentations of properties.
- Purge all module data cleanly when decommissioning.
- Extend behaviour via the `hook_entity_bundle_after_create` hook.
- Provide a structured back office for real-estate agencies.
- Organise administration under a dedicated `/admin/re-mgr` section.
