# Configuration

There's one settings form, and it's short.

## Open the settings form

1. Log in as a user with the **Administer toolbar visibility** permission. (This is the
   only permission the module defines; it gates nothing beyond this form.)
2. Go to **Configuration → User interface → Toolbar Visibility**, or navigate directly
   to `/admin/config/toolbar-visibility`.

## The settings

- **Themes** — a checkbox for every installed theme. **Tick a theme to remove the
  toolbar on it.** For the common "hide on the front end" setup, tick your public
  front-end theme (e.g. *Olivero*) and leave your admin theme (e.g. *Claro*) unticked.
- **Domains** — this multi-select only appears when the contrib **Domain** module is
  enabled. Select the domains on which the toolbar should be removed.

Click **Save configuration** to apply. On any page rendered with a flagged theme (or,
with Domain, a flagged domain), the toolbar simply isn't rendered.

Remember this is a rendering toggle, not an access restriction — it hides the toolbar's
output, nothing more.

## Setting a value without the UI

The form stores each checked theme's machine name as both the key and the value, so:

```bash
# Hide the toolbar on the "olivero" theme.
ddev drush config:set toolbar_visibility.settings themes.olivero olivero -y
```
