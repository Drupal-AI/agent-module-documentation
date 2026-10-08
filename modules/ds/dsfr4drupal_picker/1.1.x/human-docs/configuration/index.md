# Configuration

The module has a global settings form, but the configuration you will use most is
**per field instance**, where you decide which icon or pictogram categories a
field offers.

## The module settings form

A settings form exists at route `dsfr4drupal_picker.settings`, reachable from the
module's **Configure** link on the **Extend** page (`/admin/modules`). Settings
here are stored through Drupal's configuration system and export with the rest of
your site config. Because icon and pictogram detection is automatic, there is
normally nothing you must change here after a DSFR library update.

## Per‑field configuration (the main task)

Add a DSFR **icon** or **pictogram** field to a content type (**Structure →
Content types → *(type)* → Manage fields → Add field**), then configure that
field instance:

- **Choose which categories** of icon (or pictogram) the field activates. You can
  limit a field to one or more specific categories, keeping editors on the right
  subset for that field.

Save the field settings, and editors will see the icon/pictogram picker
(FontIconPicker) constrained to those categories when creating or editing
content.

## Inserting icons in CKEditor

With the module enabled, CKEditor gains **two toolbar buttons** for inserting
icons and pictograms directly into rich‑text content. If they are not visible,
add them to the toolbar at **Configuration → Content authoring → Text formats and
editors** (`/admin/config/content/formats`) by editing the relevant format and
dragging the buttons into the active toolbar.

## Custom pictograms (Media submodule)

If you enabled the **Media** submodule (`dsfr4drupal_picker_media`), a
**Pictogram** media type is created automatically. Use it under **Content →
Media** (`/admin/content/media`) to contribute your own custom pictograms
alongside the official DSFR set.
