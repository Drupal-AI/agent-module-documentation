# Configuration

Everything about the Call Us button is set on one form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Call Us**, or navigate directly to
   `/admin/config/user-interface/call-us`.

## The settings

- **Phone number** *(required)* — the number the button calls. It must be numeric
  and at least 10 digits; the form rejects anything shorter or non‑numeric. This is
  the only field you must fill in.
- **Button label** *(optional)* — the text shown on the button.
- **Side** — where the button floats: **Right**, **Float Right**, or **Left**.
  This controls placement via CSS classes.
- **Background colour** and **Font colour** — chosen with standard HTML5 colour
  pickers.
- **Social links** *(all optional)* — Facebook, Gmail, Twitter, LinkedIn, and
  YouTube URLs. These are plain links; leave any blank and that button simply
  won't show. The module makes no external calls with these values.

## Save

Click **Save configuration**. Settings are stored in the `callus.settings` config
object, and the floating button updates on the front end immediately. Uninstalling
the module removes that configuration.
