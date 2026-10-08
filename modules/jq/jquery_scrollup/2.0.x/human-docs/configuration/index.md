# Configuration

The settings form lets you tune how the "back to top" button looks and behaves.
The defaults give you a working button, so treat these as refinements.

## Open the settings form

1. Log in as a user with the **Access jQuery ScrollUp settings** permission.
2. Go to **Configuration → User interface → jQuery ScrollUp**, or navigate
   directly to `/admin/config/user-interface/jquery_scrollup`.

## Settings

The form exposes the ScrollUp plugin's options through Drupal's UI, including:

- **Button text or image** — choose what the button shows. You can display a text
  label (for example "Back to top") or use an image instead, depending on the
  style you want.
- **Scroll distance** — how far down the page the visitor must scroll before the
  button appears. A larger value keeps the button hidden until it's genuinely
  useful; a smaller value shows it sooner.
- **Scroll animation** — the animation style used when gliding back to the top,
  controlling how the smooth scroll feels.
- **Theme / appearance** — the visual style applied to the button, so it fits your
  site's design.

## Save

Click **Save** to store your changes. Reload a front‑end page, scroll down, and
confirm the button reflects your new settings.

## For developers

The module documents alter hooks (in its `jquery_scrollup.api.php`) if you need to
customize the button's behavior beyond the settings form.
