# Permissions

Defined in `image_field_to_media.permissions.yml`.

| Permission | `restrict access` | Gates |
|---|---|---|
| `create media fields based on existing image fields` | **true** | The "Clone to media" entity operation on Image fields, plus both routes (validator + conversion form). Description: "Allows to create media entities and add media fields to content entities." |

- The operation link is only added (`image_field_to_media_entity_operation`) when the current user holds this
  permission; both routes also enforce it.
- It is correctly marked `restrict access: true` because the capability creates fields and Media entities — a
  site-structure-changing operation. Grant only to trusted administrators.
