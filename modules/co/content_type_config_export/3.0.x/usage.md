<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Adds an admin-UI export action that packages a single content type, block type, paragraph type, vocabulary, or all user roles into a downloadable ZIP of YAML configuration files.

---

Entity Type Config Export (machine name `content_type_config_export`) gives site builders a per-bundle configuration export instead of a full site config export. From the "Export" tab or operations link on a content type, block type, paragraph type or vocabulary — and from a dedicated `/admin/people/export` page for user roles — it collects that object's own configuration (the bundle definition, its field instances, field storage, and, in Full mode, its form and view displays) and returns them as separate `*.yml` files inside a single ZIP. Paragraph reference fields recursively pull in their referenced paragraph types. Two modes are offered per bundle: "Selected fields only" (chosen fields plus storage, displays excluded) and "Full" (everything). Each export type has its own restrict-access permission, and the export action only appears in the operations dropdown when the current user holds the matching permission. The module does not touch content, create bundles, or import anything — it is a one-way, scoped export tool for moving structural config between environments and projects.

---

- Export a single content type's config (`node.type.*`, field instances, storage, displays) as a ZIP.
- Export just a few chosen fields of a content type without dragging in unrelated config.
- Do a Full export of a content type including form and view displays for a complete replica.
- Export a block content type's configuration for reuse on another site.
- Export a taxonomy vocabulary's definition, term fields, storage and displays.
- Export a paragraph type's config, fields and displays from the Paragraph types admin page.
- Export all user roles at once as YAML from `/admin/people/export`.
- Move one bundle's structure between dev, staging and production without a full `drush cex` diff.
- Share a reusable content type or paragraph type definition across separate Drupal projects.
- Keep a version-controlled snapshot of a specific bundle's field configuration.
- Recursively capture paragraph types referenced by a content type's paragraph reference fields.
- Grab field storage config alongside a field instance so the export imports cleanly elsewhere.
- Avoid exporting the entire site config when you only need one content type.
- Give a specific role permission to export only vocabularies, not other config, via the granular permissions.
- Add an "Export" operation link to bundle admin listings for one-click access.
- Produce a focused config bundle to hand to another developer for a feature.
- Export a bundle's config before a risky refactor as a lightweight backup of its structure.
- Reproduce a content model on a fresh install by importing the exported YAML files.
- Export block types for a design-system component library shared across sites.
- Export a vocabulary's term reference fields to replicate a taxonomy structure.
- Bootstrap a new environment's structural config from selectively exported bundles.
- Document a bundle's current field/display setup by inspecting the exported YAML.
- Restrict who can export each entity type independently through the five custom permissions.
