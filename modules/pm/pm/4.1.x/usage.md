<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
PM is the base module of the Drupal PM suite: a framework of content entity types and a central dashboard for project management and work tracking.

---

The base module itself is thin. It defines a shared content-entity base class (`PmContentEntityBase`), a plugin-driven dashboard (the `pm_dashboard_item` plugin type collected from `*.pm_dashboard_items.yml` files), hierarchy/config/etag helper services, a per-project auto-increment key generator (`pm.pm_key`, keyvalue-backed, produces keys like `PROJ-1`), and an outbound path processor. The actual working entities — projects, tasks, subtasks, stories, epics, features, boards, invoices, expenses, notes, personas, organizations, time tracking, priorities, statuses — live in the many bundled submodules under `modules/`, each of which is a separate installable module with its own permissions, views, REST resource config and admin links. A companion `pm_rest` submodule wires REST views for the entities and `pm_ui` provides Single-Directory Components (a pill formatter).

Operationally you enable `pm` plus the submodules you need. The dashboard lives at `/pm` and is gated only by the core `access content` permission, but it merely renders links to sub-tool overviews whose targets are individually access-checked (the dashboard filters out any link whose path fails `PathValidator::isValid`), so it exposes no data or mutation of its own; site administration is gated by the `administer pm configuration` permission (restricted). Configure entity bundles, statuses, priorities and boards through the `/admin/pm` admin section provided by the submodules.

---
- Install the PM base module to bootstrap the project-management framework.
- Enable submodules (pm_project, pm_task, pm_story, etc.) for the entity types you need.
- Visit `/pm` to see the project-management dashboard of enabled tools.
- Grant `administer pm configuration` to project administrators only.
- Create projects and set a project key prefix used to auto-number child items.
- Rely on `pm.pm_key` to generate sequential per-project keys like `PROJ-1`.
- Add tasks, subtasks, stories, epics and features and relate them hierarchically.
- Configure task types (bug, issue, task, test) shipped as default bundles.
- Track time against work items with the pm_timetracking submodule.
- Manage invoices and expenses with pm_invoice and pm_expense.
- Organize work on Kanban or Scrum boards via pm_board.
- Capture notes, personas and organizations alongside projects.
- Define custom statuses and priorities via pm_status and pm_priority.
- Expose PM entities over REST with the pm_rest submodule and its views.
- Extend the dashboard by declaring your own `*.pm_dashboard_items.yml` entries.
- Add a custom dashboard item plugin implementing `PmDashboardItemInterface`.
- Use the pill field formatter from pm_ui to render status/priority badges.
- Restrict configuration screens under `/admin/pm` to trusted roles.
- Use dynamic_entity_reference fields to link work items across entity types.
- Enforce the exclusive-child validation constraint to keep hierarchy integrity.
- Build Views reports over PM entities for reporting and burndown views.
