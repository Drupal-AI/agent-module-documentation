<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Link Target — agent index

Adds one field widget, **"Link with target"** (`link_target_field_widget`), for core's Link
field type. Selecting it on *Manage form display* gives editors a per-item **"Select a
target"** dropdown (`_self` / `_blank` / `parent` / `top`) next to each link's URL/title. No
settings form/configure route of its own (`configure: null`), no formatter, no service, no
permissions, no Drush, no hooks — it is a single widget plugin class.

- **Switch a link field to this widget, restrict which targets are offered, and read the
  per-link target value back** → [configure/widget-settings.md](configure/widget-settings.md)
- **How the plugin works internally (`LinkWidget` subclass, `available_targets` setting,
  where the chosen target is actually stored)** → [api/mechanism.md](api/mechanism.md)

Key fact: the widget-level restriction (`available_targets`) lives in
`core.entity_form_display.<entity>.<bundle>.<form_mode>` →
`content.<field>.settings.available_targets` (plain widget settings, not third-party
settings). The per-link target an editor picks is **not** config at all — it's written into
that link's own field value at `options.attributes.target` on the entity, the same place
core's Link field already stores any link attributes.
