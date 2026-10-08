# jquery_ui_checkboxradio — agent start

Re-provides the single jQuery UI **Checkboxradio** widget asset library (removed from Drupal
core) so themes/modules can keep using it. No config UI, no permissions, no services, no
`.module` file. Depends on the base `jquery_ui` module, which registers the library. You just
install it and attach the library. jQuery UI is End-of-Life upstream — prefer migrating off it
for new code.

## Attach the library

- [Attach `jquery_ui_checkboxradio/checkboxradio` and why this module exists](theming/jquery_ui_checkboxradio.md)
