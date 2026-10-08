# jquery_ui_accordion — agent start

Thin library-provider: exposes the **jQuery UI Accordion** widget as a Drupal asset
library. Depends on the base `jquery_ui` module (which ships the jQuery UI assets).
No config UI, no permissions, no plugins, no services, no drush.

Enable it only as a compatibility bridge for legacy code that still needs jQuery UI
Accordion on Drupal 9/10/11.

- Attach the accordion library & initialize the widget → [api/attach-library.md](api/attach-library.md)
