Assignments defines a custom "assignment" content entity type (with configurable "assignment_type" bundles) and standard per-operation CRUD permissions, managed from the Drupal admin UI.

---

Assignments is a base, scaffold-generated module that adds a fieldable content entity `assignment` and a matching config-entity bundle type `assignment_type`. Each assignment stores an author reference, a required string field (labelled "Channel", max 50 chars), and created/changed timestamps, and is administered under Content (`/admin/content/assignment`) and Structure (`/admin/structure/assignment_type`). It provides a `SqlContentEntityStorage` handler, an `EntityViewsData` integration for building Views listings, a dedicated `AssignmentAccessControlHandler`, list builders, admin HTML route providers, and Twig templates for the canonical view and the add-list page. All access is gated by six operation permissions (`add`/`edit`/`delete`/`view published`/`view unpublished`) plus the `administer assignment entities` admin permission; bundle management is gated by `administer site configuration`. There are no services, external API calls, or Drush commands. It is meant to be extended (e.g. by assignments_hootsuite), and some scaffolded form/template code refers to a `node` field and helper methods not defined by this module's own entity. Supports Drupal 10 and 11.

---

- Define a reusable "assignment" content entity type with Field UI.
- Add fields to assignments via Manage fields (Field UI, base route `entity.assignment_type.edit_form`).
- Create Assignment-type bundles at `/admin/structure/assignment_type`.
- List and manage assignments at `/admin/content/assignment`.
- Model records that need an author, a name/channel, and timestamps as first-class entities rather than nodes.
- Build Views reports over assignments (Views data integration).
- Serve as the entity foundation for an extension project such as assignments_hootsuite.
- Gate creation with the `add assignment entities` permission.
- Gate editing with the `edit assignment entities` permission.
- Gate deletion with the `delete assignment entities` permission.
- Gate viewing with the `view published assignment entities` permission.
- Reserve `administer assignment entities` and `view unpublished assignment entities` for trusted roles.
- Restrict bundle creation/editing to holders of `administer site configuration`.
- Autofill the assignment author from the current user on create (`preCreate`).
- Provide custom Twig templates (`assignment.html.twig`, add-list) and theme suggestions per bundle/view-mode/id.
- Deep-link assignment creation from a node context via a `?node=<nid>` query parameter.
- Track created/changed times on each assignment automatically.
- Export bundle definitions as configuration (`assignments.assignment_type.*`).
- Use the collection list builder to link each row to its edit form.
- Integrate assignment records into custom admin dashboards.
- Extend the entity with additional base fields in a custom module.
- Provide a starting scaffold to learn Drupal content/config entity APIs.
- Support multilingual sites (translatable author field, langcode key).
