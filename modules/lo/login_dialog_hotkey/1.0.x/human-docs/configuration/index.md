# Configuration

The settings form is where you pick the shortcut, choose how the dialog looks, and
decide where users go after logging in. All of these are safe presentation
settings — the login itself always runs through Drupal's standard, protected login
form.

## Open the settings form

1. Log in as a user who holds the **Configure login dialog hotkey** permission (or
   an administrator).
2. Go to **Configuration → User interface → Login Dialog Hotkey**, or navigate
   directly to `/admin/config/user-interface/login-dialog-hotkey`.

## The trigger key and modifiers

- **Key** — the trigger key that opens the dialog. The settings page shows the key
  currently chosen so you can confirm your selection.
- **Alt / Ctrl / Meta / Shift** — the modifier flags that must be held together
  with the key. Requiring one or more modifiers (the default combination is
  **Ctrl + Meta + L**) avoids the dialog opening by accident when someone simply
  types the letter on a page.

## Dialog type

- **Dialog type** — choose whether the login form opens as a **modal** (a centred
  overlay) or as an **off‑canvas** panel (sliding in from the side of the screen).
  You can preview the off‑canvas style as an administrator at
  `/admin/login-dialog-hotkey/offcanvas-example`.

## Post‑login redirect

- **Redirect type** and **Redirect destination** — control where the user is sent
  after they successfully log in through the dialog. Use these if you want visitors
  to land on a specific page rather than the default post‑login location.

## Save

Click **Save configuration**. Because these settings are attached to anonymous
page requests, edits invalidate the relevant cached pages automatically. To check
your changes, log out (or use a private window) and press the new shortcut.

## Scripting the configuration (optional)

There are no custom Drush commands, but because everything is stored in the
`login_dialog_hotkey.settings` configuration object, you can set the values with
`drush config:set` or manage them through a configuration import as part of a
deployment.
