Toolbar Visibility removes the Drupal administration toolbar on selected themes (and, when the Domain module is present, selected domains), so the toolbar stays on the admin theme but disappears on the front-end theme.

---

The module is a small `hook_page_top` implementation: on every page it reads `toolbar_visibility.settings`, compares the currently active theme name against the configured `themes` map, and if the active theme is flagged it `unset()`s `$page_top['toolbar']` so core's toolbar is never rendered. When the contrib `domain` module is enabled it does the same check against the active domain id via `domain.negotiator`. Configuration is a single settings form at `/admin/config/toolbar-visibility` (menu under *Configuration → User interface*), gated by the module's own `administer toolbar visibility` permission. The form lists every installed theme as checkboxes and, if `domain` is available, a multi-select of domains. It depends on the core `toolbar` module; there is no config schema shipped, no plugins, no Drush, and no services. The only permission it defines simply gates its own settings form.

---

- Hide the admin toolbar on the public front-end theme while keeping it on the admin theme.
- Remove the toolbar for anonymous-facing themes to avoid rendering overhead on cached pages.
- Turn off the toolbar on a specific custom theme without disabling the toolbar module.
- Hide the toolbar on one domain in a Domain Access multi-site while leaving it on others.
- Keep the toolbar visible only on the administration theme for editors.
- Remove the toolbar on a marketing/landing-page theme.
- Suppress the toolbar on a decoupled/preview theme.
- Hide the toolbar for a specific brand/affiliate domain.
- Toggle toolbar visibility per theme from a single settings screen.
- Grant a non-admin role control of toolbar visibility via the `administer toolbar visibility` permission.
- Prevent the toolbar from appearing on a theme used for print/PDF output.
- Clean up the front-end for logged-in members who should not see admin chrome.
- Remove the toolbar on a kiosk or embedded-display theme.
- Hide the toolbar on a mobile-specific theme.
- Keep the toolbar off a theme used for email-preview or webform-embed pages.
- Disable the toolbar on a subsite domain that has its own navigation.
- Export the theme/domain visibility choices as config for deployment across environments.
- Remove the toolbar on a demo/sandbox theme shown to stakeholders.
