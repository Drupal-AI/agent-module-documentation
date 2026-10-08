Content Templates lets editors turn any existing node into a reusable "template" and then spin up new content pre-filled from that template, using Quick Node Clone under the hood.

---

The module defines a `content_template` content entity (single bundle `content_template`) whose main field `field_source` references a source node; optional `field_category` (taxonomy vocabulary `template_category`) groups templates and `field_image` gives them a thumbnail. From any saved node, editors open `/node/{node}/template` to create/edit the template that points at it (guarded by the `add content template entities` permission plus core `clone <bundle> content`). A `/node/template` landing page (permission `create content from template`) lists all published templates as cards grouped by category; picking one routes to `/template/{node}/quick_clone`, which delegates to `quick_node_clone`'s controller to clone the source node into a fresh draft. The module adds a base field `template` on every node that records which template a node was created from, exposes it as a Views field/filter (custom `template_name` exposed filter with entity autocomplete) on the Content admin view, and offers a `/node/{node}/overview` page listing all content produced from a given template. Cloned nodes keep their original title (no "Clone of" prefix) via `hook_cloned_node_alter`, and deleting a source node cascades to delete its template. There is no global settings page (`configure` is null); behavior is driven entirely by the template entities, permissions, and the Quick Node Clone dependency.

---

- Let editors create a new page/article/event pre-populated from a curated "starter" node.
- Maintain a library of boilerplate content (FAQ, news, event) editors can clone on demand.
- Turn an approved, well-structured node into an official template for a content type.
- Group templates into categories (e.g. "Landing pages", "Campaigns") via the `template_category` vocabulary.
- Give each template a thumbnail image so the "Create from template" gallery is visual.
- Offer a single "Create from template" gallery page instead of the raw node/add flow.
- Restrict who can create templates vs. who can only create content from them via separate permissions.
- Track which template a given node originated from (the `template` base field on nodes).
- Add a "Content Template" column and exposed filter to the admin Content view to audit template usage.
- List every node created from a specific template on its `/node/{node}/overview` page.
- Clone complex nodes (paragraphs, media, references) faithfully by leaning on Quick Node Clone.
- Preserve the original title when cloning from a template (no "Clone of" prefix).
- Automatically clean up templates when their source node is deleted.
- Standardize content structure across a team by seeding new content from templates.
- Speed up repetitive content entry for editorial workflows.
- Provide category-weighted ordering of templates in the creation gallery.
- Link a created node back to its template from the node edit form's meta sidebar.
- Use `view unpublished content template entities` to let reviewers preview draft templates.
- Build campaign kits where each template represents a ready-to-fill content pattern.
- Reduce editor training by replacing blank forms with concrete starting points.
