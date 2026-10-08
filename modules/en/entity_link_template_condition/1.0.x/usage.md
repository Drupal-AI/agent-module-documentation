Adds a "Entity Link Template" visibility condition that is met when the current request is one of an entity type's link-template routes (canonical, edit-form, delete-form, etc.).

---

Entity Link Template Condition ships a single Drupal condition plugin (`id: entity_link_template`, label "Entity Link Template") that inspects the current route and matches when that route corresponds to an entity link template. It works with any entity type that declares link templates, so you can target "any canonical page" across all entity types, or an exact combination such as "node canonical" or "taxonomy_term edit-form". Because it is a standard condition, it plugs into every place Drupal exposes visibility conditions — most commonly block visibility in the Block layout UI, and any other consumer of the condition plugin system. It depends on the Entity Route Context module, whose route helper maps the current route match to an entity type and link-template key. The condition has no routes, permissions, services, or admin settings form of its own; its two settings (`link_templates_any` and `link_templates`) are stored on the host configuration (for example the block config) and edited inline in that host's condition UI.

---

- Show a block only on the canonical (view) page of any entity type.
- Show a block only on the edit-form of any entity type.
- Show a block only on the delete-form of any entity type.
- Restrict a block to node canonical pages exactly (`node:canonical`).
- Restrict a block to node edit forms exactly (`node:edit-form`).
- Show a "related content" block only on taxonomy term pages (`taxonomy_term:canonical`).
- Show a moderation/help block only on entity edit forms across the site.
- Hide a marketing block on all entity edit and delete forms (via the condition's "negate" option).
- Target user profile pages via the user entity's canonical link template.
- Show a block only on media entity edit forms (`media:edit-form`).
- Display contextual help only on the add/version-history link templates of an entity type.
- Combine with other block conditions (path, role) so a block appears only on, e.g., node canonical pages for a given role.
- Build a sidebar that appears on all "view" pages regardless of entity type by selecting the `canonical` key under "any entity type".
- Provide edit-mode-only tooling blocks by matching all `edit-form` link templates.
- Scope a block to a single content entity type's revision pages via its revision link template key.
- Reuse the condition anywhere Drupal collects `condition` plugins (block visibility, and other condition-driven features).
- Match multiple link-template keys at once (each selected checkbox is OR-combined).
- Distinguish "any entity type on this link template" from "this exact entity type on this link template" using the two separate checkbox groups.
- Keep block placement rules declarative in exported configuration (settings live in the block's `visibility` config).
- Avoid custom preprocess/route-subscriber code that would otherwise be needed to detect "am I on an entity edit form".
