# Configuration

Adminimal Admin Toolbar works the moment you enable it — the dark styling needs no
configuration. There is exactly one option, and most sites never touch it.

## Open the settings form

1. Log in as a user with core's **Administer site configuration** permission.
2. Go to **Configuration → User interface → Adminimal Admin Toolbar**, or navigate
   directly to `/admin/config/user-interface/adminimal_admin_toolbar`.

## The single setting

### Avoid loading Open Sans font

By default the module loads the **Open Sans** webfont for the toolbar's
typography. Open Sans doesn't cover every writing system well — for example
Japanese and other CJK languages render poorly in it. Tick this checkbox to stop
the module from loading the Open Sans font; the toolbar then falls back to your
site's normal fonts, which is usually what you want for those languages.

- **Unchecked** *(default)* — Open Sans is loaded and used for the toolbar.
- **Checked** — the font is not loaded; the toolbar keeps the Adminimal layout and
  colors but uses your existing fonts.

*(Config key: `avoid_custom_font` in `adminimal_admin_toolbar.settings`, default
`FALSE`.)*

## Save

Click **Save configuration**. The change applies on the next page load.

## Doing it from the command line

The setting is a config value, so you can toggle it with Drush and deploy it as
exported configuration:

```bash
drush config:set adminimal_admin_toolbar.settings avoid_custom_font true -y
```

## A note on access

The module defines no permissions of its own. Whether the styling loads for a
given user is decided by core's **Access toolbar** permission (so it never loads
for anonymous visitors), and the settings form above is gated by core's
**Administer site configuration** permission.
