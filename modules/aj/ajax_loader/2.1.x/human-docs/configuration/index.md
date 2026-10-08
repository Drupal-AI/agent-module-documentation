# Configuration

Everything is on one settings form, stored in the `ajax_loader.settings`
configuration object.

## Open the settings form

1. Log in as a user with the **Administer ajax loader** permission
   (`administer ajax loader`).
2. Go to **Configuration → User interface → Ajax loader**
   (`/admin/config/user-interface/ajax-loader`).

## Choose a throbber

The **throbber** select lists twelve built-in animations, with a live preview on
the form:

- **Pulse**
- **Wave**
- **Circle**
- **Fading circle**
- **Chasing dots**
- **Double bounce**
- **Three bounce**
- **Rotating plane**
- **Cube grid**
- **Folding cube**
- **Wandering cubes**
- **Swing**

Pick the one that suits your design. (If the throbber value is left empty or set
to an unknown plugin, the module simply falls back to Drupal's core throbber.)

## The other options

- **Hide ajax message** *(off by default)* — suppress the core "loading…" AJAX
  message so the animation stands alone.
- **Always fullscreen** *(off by default)* — always render the throbber as a
  full-screen overlay, useful for long operations where you want visitors to wait
  without clicking again.
- **Show on admin paths** *(off by default)* — also show the custom throbber on
  admin pages. Leave it off to keep the core throbber on admin listings and only
  brand the public site. (The throbber never appears on the Ajax loader settings
  form route itself.)
- **Throbber position** *(default `body`)* — a CSS selector for the element the
  throbber is injected into. The default `body` places it on the page; target a
  specific selector to put it next to a particular form, region, modal, or
  off-canvas container instead.

## Save and clear caches

Click **Save configuration**. The form rebuilds all caches on submit because the
chosen throbber's CSS is compiled into the module's asset libraries — but if you
change the config any other way (for example via Drush), run `drush cr` yourself
so the new throbber takes effect.

## Setting it from the command line

```bash
drush cset ajax_loader.settings throbber throbber_pulse -y
drush cset ajax_loader.settings hide_ajax_message true -y
drush cset ajax_loader.settings always_fullscreen false -y
drush cset ajax_loader.settings show_admin_paths false -y
drush cset ajax_loader.settings throbber_position body -y
drush cr
```

Because all settings live in `ajax_loader.settings`, you can export the config and
deploy the same loader choice across several sites.
