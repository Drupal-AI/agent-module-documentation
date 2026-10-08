# jquery_ui_button — agent start

Re-provides the single jQuery UI **Button** widget asset library (removed from Drupal core)
so themes/modules can keep using it. The button widget also covers the legacy `buttonset()`
behavior — there is no separate `buttonset` library. No config UI, no permissions, no
services, no `.module` file. Depends on the base `jquery_ui` module (which registers the
library) plus `jquery_ui_controlgroup` and `jquery_ui_checkboxradio`. You just install it and
attach the library. jQuery UI is End-of-Life upstream — prefer migrating off it for new code.

## Attach the library

- [Attach `jquery_ui_button/button` and why this module exists](theming/jquery_ui_button.md)
