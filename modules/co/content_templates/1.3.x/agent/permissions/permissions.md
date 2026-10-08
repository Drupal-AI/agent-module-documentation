# Content Templates — permissions

From `content_templates.permissions.yml`. Only `administer content template entities` is
`restrict access: true` (trusted admin); the rest are grantable to editorial roles.

| Permission | Gates |
|---|---|
| `add content template entities` | Create `content_template` entities. Also required (with core `clone {bundle} content`) to reach `/node/{node}/template`. |
| `administer content template entities` | Admin form for the entity type. **restrict access: true.** |
| `delete content template entities` | Delete template entities. |
| `edit content template entities` | Edit template entities. |
| `view published content template entities` | View published templates (view op on published). |
| `view unpublished content template entities` | View unpublished/draft templates. |
| `create content from template` | Reach the `/node/template` gallery and create new content from a template. |
| `access content from template overview` | Reach `/node/{node}/overview` listing content created from a template. |

Notes:
- Creating a template from a node requires BOTH `add content template entities` AND core Quick Node
  Clone's per-bundle `clone {bundle} content` permission (checked in `TemplateController::createAccess`).
- The actual clone route uses core `_entity_access: node.clone`, so cloning still respects node access.
- None of these permissions crosses a trust boundary beyond normal content authoring/cloning.
