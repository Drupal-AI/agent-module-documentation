# PET — permissions

From `pet.permissions.yml` and `PetAccessControlHandler`:

| Permission | `restrict access` | Gates |
|---|---|---|
| `add PET entity` | no | Create templates (`checkCreateAccess`). |
| `view PET entity` | no | View a template AND reach the interactive send form `/pet/{pet}` (`pet.preview`) and the template collection. |
| `edit PET entity` | no | Edit templates (`update`). |
| `delete PET entity` | yes | Delete templates. |
| `administer PET entity` | yes | The settings form `/admin/config/system/pet/settings`. |
| `administer previewable email templates` | yes | Reveals the From/CC/BCC/recipient-callback "Additional options" group on the template form. |
| `use previewable email templates` | no | Defined in `pet.permissions.yml`; not referenced by any route. |

## Interactive sending

The interactive send route `pet.preview` (`/pet/{pet}`) requires `view PET entity`, so grant it
only to roles that should be able to send template email.
