<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Form Mode Manager turns Drupal's otherwise passive form modes into fully usable alternative entity add/edit forms: it generates the routes, tabs, local actions, operations links and per-mode access permissions so editors can create and edit entities through a chosen form mode without any custom code.

---

Drupal core lets you define **form modes** (display modes for edit forms) and enable them per bundle, but provides no way to actually *use* them. Form Mode Manager fills that gap with route-building event subscribers (`FormModesSubscriber`, `EnhanceEntityRouteSubscriber`) and an `EntityRoutingMap` plugin type that map each active form mode to add/edit routes for a given entity type. Once you create a form mode (*Structure > Display modes > Form modes*) and enable it on a bundle's *Manage form display* ("Custom Display settings"), the module exposes it at paths like `node/add/{type}/{form_mode}` and as an edit tab, plus contextual/operations links, and mints a dynamic permission per mode (`use <entity_type>.<form_mode> form mode`, and `use <entity_type>.default form mode`) so access can be restricted by role. Two settings forms control behavior: `/admin/config/content/form_mode_manager` excludes specific form modes from the system (config `form_mode_manager.settings` → `form_modes.<entity>.to_exclude`; user *register* and commerce *add_to_cart* are excluded by default), and `/admin/config/content/form_mode_manager/links-task` positions the generated local tasks (config `form_mode_manager.links`). Built-in `EntityRoutingMap` plugins cover node, user, taxonomy_term and block_content, with a `generic` fallback for any other content entity; you add a plugin to customize routes for a bespoke entity. Submodules extend it: **theme switcher** (theme per form mode), **user roles assign** (auto-assign roles on register form modes), and **examples** (a demo content type). It depends only on core `field`.

---

- Give editors a simplified "quick add" form for a content type via a dedicated form mode.
- Provide a separate, fuller edit form mode for power users alongside the default.
- Create nodes through a specific form mode at `node/add/{type}/{form_mode}`.
- Edit an entity using an alternative form mode from a tab on its edit page.
- Restrict a form mode to a particular role using the generated `use <entity>.<mode> form mode` permission.
- Hide the default add/edit form from a role while granting only a specific form mode (via `use <entity>.default form mode`).
- Add operations links so editors can edit content in a chosen form mode straight from admin/content.
- Exclude a form mode from Form Mode Manager entirely via the settings form.
- Keep the user *register* form mode excluded by default to avoid conflicts.
- Move a form mode's local tasks to the primary tab level for role-restricted setups.
- Build role-specific content entry workflows (e.g. a "contributor" form mode with fewer fields).
- Support custom content entities by adding an `EntityRoutingMap` plugin mapping their routes.
- Use the `generic` routing fallback to expose form modes on a contrib entity with standard routes.
- Provide different edit experiences per form mode without writing form alter code.
- Switch the admin theme per form mode with the Theme Switcher submodule.
- Auto-assign roles to users registering through a specific user form mode (User Roles Assign submodule).
- Present a taxonomy term edit form mode tailored to a specific vocabulary workflow.
- Offer a media entity form mode with a reduced field set for quick uploads.
- Expose block content form modes for structured block editing.
- Standardize multi-step-like content creation by routing users to the right form mode.
- Deploy form-mode exclusions and task positions as exported configuration.
- Drive editorial governance by mapping roles to form modes across entity types.
- Simplify onboarding by giving new editors a guided, minimal form mode.
- Try the whole feature quickly with the bundled examples submodule's demo content type.
