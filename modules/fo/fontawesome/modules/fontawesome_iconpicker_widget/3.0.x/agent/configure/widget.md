# Enable the iconpicker widget

1. Add a Font Awesome icon field (field type `fontawesome_icon`) to an entity bundle.
2. Under **Manage form display**, set the field's widget to **Font Awesome Iconpicker
   Widget** (plugin id `fontawesome_iconpicker_widget`).

The widget class `\Drupal\fontawesome_iconpicker_widget\Plugin\Field\FieldWidget\FontAwesomeIconpickerWidget`
extends the base `FontAwesomeIconWidget`, so all advanced per-icon settings and the
`access fontawesome additional settings` permission still apply.

## Download the library
`drush fa:download-iconpicker` (alias `fa-download-iconpicker`), defined in the submodule's
`drush.services.yml`, fetches the iconpicker JS library locally.
