# Configuration

The module has a global settings form, but the configuration you will use most is
**per field instance** (and per CKEditor toolbar), where you decide which icon or
pictogram categories are offered.

## The module settings form

A settings form lives at route `dsfr4drupal_picker.settings`
(`/admin/config/user-interface/dsfr4drupal-picker`), reachable from the module's
**Configure** link on the **Extend** page (`/admin/modules`). Its one option is
the **widget theme** for the FontIconPicker UI (Bootstrap, Dark grey, Grey, or
Inverted). Settings are stored through Drupal's configuration system and export
with the rest of your site config. Because icon and pictogram detection is
automatic, there is normally nothing else you must change here after a DSFR
library update. (Saving this form flushes caches so the theme change takes
effect.)

## Per-field configuration (the main task)

Add a DSFR **icon** or **pictogram** field to a content type (**Structure →
Content types → *(type)* → Manage fields → Add field**), then configure that
field instance:

- **Choose which categories** of icon (or pictogram) the field activates. You can
  limit a field to one or more specific categories, keeping editors on the right
  subset for that field.
- **Enable search** on the widget — useful when a category contains many icons;
  the search matches on the icon class name.

On the display side, the **icon formatter** lets you pick a render **size** (extra
small, small, medium, or large). The chosen icon/pictogram is rendered through a
Single-Directory Component.

Save the field settings, and editors will see the icon/pictogram picker
(FontIconPicker) constrained to those categories when creating or editing content.

## Inserting icons in CKEditor

With the module enabled, CKEditor 5 gains **two toolbar buttons** for inserting
icons and pictograms directly into rich-text content. If they are not visible, add
them to the toolbar at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`) by editing the relevant format and
dragging the buttons into the active toolbar. Each button has plugin settings
(allowed categories, search) mirroring the field widget. The corresponding
**filters** (“Embed a DSFR icon”, “Embed a DSFR pictogram”) turn the stored
`<dsfr-icon>` / `<dsfr-pictogram>` tags into the rendered iconography on display —
make sure they are enabled on the format.

## Custom pictograms (Media submodule)

If you enabled the **Media** submodule (`dsfr4drupal_picker_media`), a
**Pictogram** media type is created automatically, together with a
**Pictograms custom categories** taxonomy vocabulary. Add your own SVG pictograms
under **Content → Media** (`/admin/content/media`), optionally assigning a
category term; they then appear in the pictogram picker alongside the official
DSFR set.

## Extending the sets in code

Developers can add to or alter the available sets with the module's alter hooks
(see `dsfr4drupal_picker.api.php`): `hook_dsfr4drupal_picker_icons()` /
`_icons_alter()`, `hook_dsfr4drupal_picker_pictograms()` / `_pictograms_alter()`,
`hook_dsfr4drupal_picker_pictogram_path_alter()`, and
`hook_dsfr4drupal_picker_group_label_alter()`.
