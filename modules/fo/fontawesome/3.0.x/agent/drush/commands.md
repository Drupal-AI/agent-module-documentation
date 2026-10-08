# Drush commands

Defined in `drush.services.yml` → `\Drupal\fontawesome\Commands\FontawesomeCommands`.

- `fa:download [path]` (aliases `fadl`, `fa-download`) — download and extract the Font
  Awesome library locally. Defaults to `DRUPAL_ROOT/libraries/fontawesome`; pass an optional
  path. Skips if a `css/` dir already exists there. Pair with `use_cdn: false` in
  [configure/settings.md](../configure/settings.md).

(The `fontawesome_iconpicker_widget` submodule adds a parallel `fa:download-iconpicker`.)
