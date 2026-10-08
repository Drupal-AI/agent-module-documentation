# jquery_ui_controlgroup — agent start

Thin library-provider: exposes the **jQuery UI Controlgroup** widget as a Drupal asset
library (`jquery_ui_controlgroup/controlgroup`). Depends on the base `jquery_ui` module,
which ships the jQuery UI assets and actually registers this library on the module's behalf
(the module itself contains only an `.info.yml` — no `*.libraries.yml`, PHP, config,
permissions, plugins, services, or drush).

Enable it only as a compatibility bridge for legacy code that still needs jQuery UI
Controlgroup on Drupal 9/10/11. No config UI (`configure` route is null).

- Attach the controlgroup library & initialize the widget → [api/attach-library.md](api/attach-library.md)
