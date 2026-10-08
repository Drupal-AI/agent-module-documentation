# Reusable image sets (config entity)

Config entity type `webform_image_select_images` — a named, exportable gallery of image
options reused across forms. Entity class `src/Entity/WebformImageSelectImages.php`
(`admin_permission = "administer webform"`).

## Manage in the UI
Collection: **Admin → Structure → Webform → Options → Images**
(`/admin/structure/webform/options/images/manage`). Add / edit / duplicate / delete forms
live under that path; a filter form (`src/Form/WebformImageSelectImagesFilterForm.php`) helps
find sets. A default example set `dogs` ships in `config/install`.

## Shape
`config_export` keys: `id`, `uuid`, `label`, `category`, `images`. The `images` value is YAML/text
parsed into an associative array of `value: { text, src }` entries (source-form field). Because
it is a config entity it is exportable and deployable like any Webform options config.

## Use a set on an element
Set the image-select element's `#images` property to the set's machine name (e.g. `dogs`).
The storage handler (`WebformImageSelectImagesStorage`) resolves and returns the parsed images.

Config schema for both the element and the entity: `config/schema/webform_image_select.schema.yml`.
