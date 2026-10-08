# Permissions

Defined in `content_model_documentation.permissions.yml`. None are auto-granted to anonymous.

| Permission | Grants |
| --- | --- |
| `administer content model documentation` | The settings form (`entity.cm_document.config_form`). |
| `view content model documentation` | View reports and view (published) cm_document entities. |
| `view content model documentation reports` | View any report/diagram page. |
| `administer content model document entities` | Entity admin permission (`admin_permission` of `cm_document`); implies edit/delete/revision management. |
| `add content model document entities` | Create cm_document entities. |
| `edit content model document entities` | Edit cm_document entities. |
| `delete content model document entities` | Delete cm_document entities. |
| `view unpublished content model document entities` | View unpublished cm_document entities. |
| `view all content model document revisions` | See the revision history. |
| `manage all content model document revisions` | Revert/delete revisions (with edit rights or admin). |

## How they gate access

- **Report & diagram routes** require `view content model documentation` **OR**
  `view content model documentation reports` (the `+` operator in routing = any-of).
- **cm_document entity operations** go through `CMDocumentAccessControlHandler::checkAccess()`:
  - `view` published → `view content model documentation`; unpublished →
    `view unpublished content model document entities`.
  - `update` → `edit content model document entities`.
  - `delete` → `delete content model document entities`.
  - create → `add content model document entities` (`checkCreateAccess`).

  Entity routes use `_entity_access: 'cm_document.<op>'`, so they honour the handler above
  rather than a bare permission string.
