# Colorbox Drush command

Registered in `drush.services.yml` (`Drupal\colorbox\Commands\ColorboxCommands`, injected
`@library.discovery`).

## `drush colorbox:plugin [path]`
Aliases: `colorboxplugin`, `colorbox-plugin`.

Downloads and installs the external Colorbox JS library. With no argument it installs to
`DRUPAL_ROOT/libraries/colorbox`; pass a `path` to override. It fetches the archive from the
library's `remote` URL (defined in `colorbox.libraries.yml`) and skips the download if the
target directory already exists.

The module itself only integrates the plugin; the JS library must be present (via this
command or a manual download) for the lightbox to work.
