# Path File permissions

Defined in `path_file.permissions.yml` (all gate the `path_file_entity` content entity):

| Permission | Gates |
|---|---|
| `administer path file entity entities` | Entity admin (`admin_permission`); also unlocks the extra publish/unpublish save buttons on the edit form. `restrict access: true`. |
| `add path file entity entities` | Create Path Files (`checkCreateAccess`). |
| `edit path file entity entities` | Update / edit (operation `update`). |
| `delete path file entity entities` | Delete. |
| `access path file entity overview` | (Declared for the overview page.) |
| `view published path file entity entities` | View a **published** Path File — i.e. download it. |
| `view unpublished path file entity entities` | View an **unpublished** Path File. |

## Access logic (`PathFileEntityAccessControlHandler`)

- `view`: published → needs *view published…*; unpublished → needs *view unpublished…*.
- `update` → *edit…*; `delete` → *delete…*; create → *add…*.
- Results are cached per permissions and per the entity.

## Default grants at install

`path_file_install()` grants **`view published path file entity entities`** to both the
**anonymous** and **authenticated** roles, so published downloads work for everyone out of the box
(the module documents this as a deliberate node-like exception to "don't auto-grant in hook_install").

To make downloads private, revoke that permission from anonymous/authenticated and grant it only to
trusted roles (and/or unpublish the entity and use *view unpublished…*).
