<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Layout Builder Operation Link adds a **Layout** operation link to the operations dropbutton of any entity whose bundle has Layout Builder enabled *with overrides*, so editors jump straight to an entity's layout page from listings like `/admin/content`.

---

The module implements `hook_entity_operation()` to append a single `layout` operation link (title "Layout", weight 50) to every fieldable entity it is asked about. It only adds the link when the current user actually has access to that entity's Layout Builder override route (`layout_builder.overrides.<entity_type>.view`) — an access check that returns TRUE only when the bundle is Layout Builder-enabled, per-entity overrides are allowed, and the user holds the necessary Layout Builder permissions. Because it keys off the generic entity-operation hook, the link appears for **any** entity type that exposes operations dropbuttons: nodes on `/admin/content`, taxonomy terms on the vocabulary overview, users, media, and more. When layouts are translatable (e.g. the Layout Builder Asymmetric Translation module is installed) it adds the entity language as a route option so the link targets the correct translation. A `template_preprocess_links()` hook strips the hardcoded `destination` query parameter from the link so Layout Builder's own post-save redirect wins. The module has **no configuration, settings form, permissions, or Drush commands** — enable it and the link appears wherever it applies; the only "setup" is turning on Layout Builder overrides for a bundle.

---

- Give content editors a one-click "Layout" link on `/admin/content` to open a node's Layout Builder page without first opening its edit form.
- Add a Layout operation to taxonomy term overview pages for vocabularies whose terms use Layout Builder overrides.
- Expose a Layout link on the users admin listing when user entities are Layout Builder-enabled with overrides.
- Add a Layout link to media library / media admin listings for Layout Builder-enabled media bundles.
- Speed up editorial workflows that involve frequent per-entity layout tweaks by cutting a page load out of the path.
- Provide a consistent "edit the layout" entry point across every entity type in one small module instead of custom code per listing.
- Surface Layout Builder access itself — the link only shows to users who can actually edit that entity's layout, doubling as a visibility cue for who has layout permissions.
- Let site builders confirm at a glance which bundles have per-entity layout overrides enabled (the link only appears where overrides are on).
- Jump to the layout of a just-created node from a Views-based content listing that renders an operations dropbutton.
- Give multilingual editors a Layout link that opens the layout of the specific translation they are viewing.
- Reduce editor training: "click Layout in the operations menu" instead of "open the node, then find the Layout tab".
- Add layout access to custom entity types that expose operation links, with no extra code.
- Pair with Layout Builder Asymmetric Translation so per-language layouts are reachable directly from listings.
- Keep the operations dropbutton uncluttered for non-privileged users, since the link is access-gated and simply absent for them.
- Use on editorial dashboards or custom admin Views that show entity operations, to add fast layout access.
- Avoid writing a custom `hook_entity_operation()` in a site module just to add a layout shortcut.
- Let reviewers open the layout of flagged/moderated content directly from a moderation queue that shows operations.
- Provide quick layout access on taxonomy-driven landing pages managed with Layout Builder.
- Standardize the "Layout" operation label and weight (50, so it sorts after Edit/Delete) across all listings.
- Turn Layout Builder from an edit-form tab into a first-class listing action for high-volume content teams.
