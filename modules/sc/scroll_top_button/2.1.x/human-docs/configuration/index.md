# Configuration

All of the module's behavior lives in one settings form. There is no block and
no per-page control — whatever you set here applies to the whole front end of
your active theme.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Scroll To Top Button**, or navigate
   directly to `/admin/config/user-interface/scroll_top_button`.

## The settings, field by field

- **Enabled** — the master on/off switch. The module ships **off**, so this is
  the first thing to change. Nothing appears on the front end until it is
  enabled and you save the form.
- **Show on admin pages** — off by default, which keeps the button on the
  public-facing side of the site only. Turn it on if editors would find a
  "back to top" control useful on long admin pages too.
- **Button text** — the label shown on the button (default *Scroll to top*).
  Change it to something shorter like *Top* or *Back to top* if you prefer.
- **Button style** — how the control looks. Choose one of:
  - **Image** *(default)* — the bundled arrow/image button.
  - **Link** — a plain text link.
  - **Pill** — a modern rounded, pill-shaped button.
  - **Tab** — a tab anchored to the edge of the screen.
- **Button animation** — how the button reveals itself when the visitor scrolls
  far enough: **Fade** *(default)*, **Slide**, or **None** for an instant show.
- **Button animation speed** — how long the fade/slide-in takes, in milliseconds
  (default **200**). Lower is snappier, higher is more gradual.
- **Scroll distance** — how many pixels the visitor must scroll down before the
  button appears (default **100**). Increase it so the button never shows up on
  short pages; lower it to reveal the button sooner.
- **Scroll speed** — how long the smooth scroll back to the top takes, in
  milliseconds (default **300**).

## Save

Click **Save configuration**. Changes take effect on the next page load — there
is no cache rebuild needed. Open a long front-end page, scroll down past your
chosen distance, and the button should appear.
