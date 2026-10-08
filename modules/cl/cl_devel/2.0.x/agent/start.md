<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# CL Devel (cl_devel) — agent index

A **developer tool for Single Directory Components (SDC)**. It adds an admin **Component Audit**
page plus per-component **detail** pages that read Drupal core's SDC plugin manager
(`plugin.manager.sdc`) and show, for every discovered component, its path, template presence,
declared assets, fork/override status, README, thumbnail, props and slots. Package `Components`.
Core `^10.3 || ^11`. License GPL-2.0-or-later. Version 2.0.0. Read-only inspection only.

## Dependencies

- No Drupal module dependencies. Uses **core SDC** (the `Drupal\Core\Theme\ComponentPluginManager`
  service `plugin.manager.sdc`) and `file_url_generator`.
- Composer `require`: **`league/commonmark ^2.4`** (renders component READMEs) and `ext-json`.

## What it provides (from source)

- **2 routes**, both `_permission: 'administer site configuration'` — see
  [routes/audit.md](routes/audit.md):
  - `cl_devel.registry` → `/admin/config/user-interface/sdc/registry` →
    `ComponentAudit::audit()`.
  - `cl_devel.component_details` → `/admin/config/user-interface/sdc/registry/{component_id}` →
    `ComponentDetails::details()`.
- **2 controllers** in `src/Controller/`: `ComponentAudit`, `ComponentDetails`.
- **1 theme hook** `cl_label_with_link` (`cl_devel.module`, template
  `templates/cl-label-with-link.html.twig`).
- **1 alter hook** `hook_cl_component_audit_alter(&$card_build, Component $component)`
  (`cl_devel.api.php`).
- **2 SDC components** it ships in `components/`: `component-details`, `image-with-fallback`
  (used to build the detail page) — see [components/sdc.md](components/sdc.md).
- **1 asset library** `cl_devel/cl_registry` (`src/assets/css/cl-registry.css`).
- **Config**: config object `sdc.settings` (single `debug` boolean), schema in
  `config/schema/cl_devel.schema.yml` — see [config/settings.md](config/settings.md).
- A menu link (`Single Directory Components` under Config → UI) and a local task tab
  (`Component Audit`, base route `sdc.settings`).
- **No** own permissions, **no** Drush commands, **no** plugin types, **no** entities.

## Solution docs

- [routes/audit.md](routes/audit.md) — the audit + details pages, what each computes, the alter hook.
- [config/settings.md](config/settings.md) — install/enable, the `sdc.settings` config + schema.
- [components/sdc.md](components/sdc.md) — the two shipped SDC components and the theme hook.
