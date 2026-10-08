<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Entity Tracer is an admin/developer tool that maps how content entity types and bundles reference each other through entity-reference fields.

---

Entity Tracer adds two pages under Configuration → Development. On the settings page you pick which content entity types to include and set a maximum recursion depth; the module then builds and caches a complete reference chain from the enabled types' entity-reference (and entity_reference_revisions) field definitions. On the tracer page you choose an entity type, a bundle, and a direction — "Down" lists the reference fields on that bundle and the bundles they target (recursively), while "Up" finds the bundles that reference the selected one. Results are rendered as a nested diagram in which field names are bolded and each referenced bundle links to that bundle's Field UI page, making it easy to see and jump to the fields that form a relationship. It reads only field/bundle configuration (the site's data model), not the values of individual content entities, and it works on Drupal 8/9/10/11 so it also helps when planning migrations.

Use it to inspect and document your content model. Everything is driven from field definitions and cached, so repeated traces are cheap; the cache is invalidated automatically when field info or the module's settings change.

---

- Discover which entity-reference fields exist on a given bundle.
- See, recursively, every bundle reachable from a bundle's reference fields ("Down" direction).
- Find every bundle that references a given bundle ("Up" direction).
- Map the full entity-reference graph for a set of content entity types.
- Document a site's content model before a redesign or handover.
- Plan a content migration by understanding reference dependencies (works on D8/D9/D10/D11).
- Trace where a taxonomy vocabulary or bundle is used across content types.
- Locate the exact field that connects two bundles, then jump straight to its Field UI page.
- Audit media or file reference usage across bundles.
- Understand paragraph / entity_reference_revisions nesting on a content type.
- Identify orphaned or unexpected reference fields on a bundle.
- Estimate the blast radius of deleting or changing a bundle.
- Onboard developers by giving them a visual of entity relationships.
- Debug why an entity keeps another entity from being deleted.
- Choose which entity types to trace via the settings form (content entities only).
- Limit trace recursion with the Max Depth setting to avoid timeouts on deep chains.
- Review reference chains for a specific bundle without writing custom code.
- Cross-check that a new reference field targets the intended bundles.
- Use the cached reference chain as a quick reference-model overview for admins.
- Expose relationship inspection to trusted roles via a dedicated permission.
