# jquery_ui_effects — agent start

Re-provides the deprecated jQuery UI **Effects** asset library (removed from Drupal core) so
themes/modules can keep using jQuery UI animations. Depends on the base `jquery_ui` module.
No config UI, no permissions, no services, no `.module`. You just install it and attach the
library ids. jQuery UI is End-of-Life upstream — prefer migrating off it for new code.

## Attach the effects libraries

- [Effects library ids, `#attached`, dependency & the effects it provides](api/jquery_ui_effects.md)
