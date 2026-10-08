<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Access Conditions Field Group — agent orientation

Adds access-model-driven visibility to Field Group elements.

Key file: `access_conditions_field_group.module`
- `..._form_..._display_edit_form_alter` / `..._field_ui_display_form_alter()` — injects the `access_models` entity_autocomplete into a field group's format settings and adds a summary line.
- `..._field_group_pre_render_alter()` — loads referenced `access_model` entities, evaluates via `access_conditions.access_checker`, sets `#access = FALSE` when none grant, and manages `#cache` contexts/tags/max-age.

Security posture: sound and cache-aware. It is a *display* visibility feature — note in docs that visually hiding a group is not a substitute for real field/entity access on truly sensitive data. No routes/permissions of its own; relies on Access Conditions.
