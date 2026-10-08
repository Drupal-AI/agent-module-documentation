<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Site Studio Per Component Library - agent index

Auto-attaches theme libraries named after Site Studio (Cohesion) component UIDs on node pages. Version **1.0.1** (1.0.x), core `^8.8.0 || ^9 || ^10`. Depends on `cohesion`.

- `site_studio_per_component_libs_page_attachments_alter()` loads the current node, finds `cohesion_entity_reference_revisions` fields, decodes canvas JSON and collects component UIDs (recursing into children).
- For each UID it calls `library.discovery` on the active theme (and base theme) for a library named `{theme}/{uid}`; matches are attached.
- No routes, permissions, services or config. Pure hook-driven asset attachment.

No security surface: reads existing node/component config and attaches theme-declared libraries only. Sound.
