Entity Clone adds a "Clone" operation to Drupal entities so editors can duplicate any content or configuration entity — nodes, terms, users, menus, fields, view displays and more — as a starting point for new items.

---

Entity Clone attaches a clone handler to every content and configuration entity type via `hook_entity_type_build()`, exposing a `clone-form` link template and a "Clone" entity operation/local task/contextual link. When an editor clones an entity, a `createDuplicate()` copy is made and its clonable reference fields can be recursively cloned too (so a node with paragraphs or referenced entities can be deep-copied). Special handlers exist for files, users, taxonomy terms, menus (copying child links), fields, and Layout Builder view displays, and generic base handlers cover everything else. A settings page (`/admin/config/system/entity-clone`) controls global options — whether to append a "(cloned)" suffix, whether the current user takes ownership, and per-entity-type/bundle defaults such as which reference fields clone by default or are hidden — plus a separate page to mark which entity types are cloneable. Access is governed by a granular permission per entity type (`clone {entity_type} entity`) generated dynamically, plus an "administer entity clone" permission. Developers can hook into the process through `EntityCloneEvents::PRE_CLONE` / `POST_CLONE` events, or register a custom clone/clone-form handler for a specific entity type. The bundled **entity_clone_extras** submodule extends this with bundle-level clone permissions for nodes and media.

---

- Add a "Clone" button to nodes so editors can duplicate an article as a template.
- Duplicate a complex landing page (with paragraphs) and edit the copy.
- Clone a taxonomy term, optionally copying its children.
- Copy a menu and all of its links to build a variant navigation.
- Duplicate a content type / node type as a base for a new bundle.
- Clone a field configuration onto a new bundle.
- Copy a Layout Builder view display and tweak the layout.
- Duplicate a user account as a template for similar accounts.
- Clone a Webform or other config entity to reuse its structure.
- Deep-clone an entity and its referenced entities recursively.
- Give a specific role permission to clone only nodes, not other entities.
- Restrict cloning to certain bundles using the extras submodule.
- Append a "(cloned)" suffix automatically to duplicated labels.
- Make the cloning user the owner of the new entity.
- Mark only selected entity types as cloneable to declutter the UI.
- Configure which reference fields are copied by default per entity type.
- Hide certain reference fields from the clone form.
- Provide a contextual "Clone" link on entity rows/operations lists.
- Bulk-duplicate content by cloning a proven example repeatedly.
- Speed up data entry for repetitive, similar content items.
- Clone a block content entity to reuse a built block.
- React to clone events to reset fields (e.g. clear publish date) via a subscriber.
- Log or audit every clone through the POST_CLONE event.
- Register a custom clone handler for a bespoke entity type.
- Copy a contact form or comment type configuration.
