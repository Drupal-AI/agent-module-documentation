# Configuration

Add to Homescreen has a single settings form that controls the install prompt
shown to mobile visitors.

## Open the settings form

1. Log in as a user with the **administer add to homescreen** permission.
2. Go to **Configuration → User interface → Add to Homescreen**, or navigate
   directly to `/admin/config/user-interface/addtohomescreen`.

## What you can set

The form controls how the invitation prompt behaves and looks:

- **Prompt / invitation text** — the wording shown when the site invites the
  visitor to add it to their homescreen. Set your own message here.
- **Timing and display frequency** — when the prompt appears and how often it is
  shown to a returning visitor, so it stays unobtrusive rather than nagging on
  every page.
- **Appearance** — the presentation options offered by the add-to-homescreen
  library for how the prompt looks.

When you save, the module attaches the add-to-homescreen library to your front-end
pages and shows the prompt to mobile visitors according to these settings. Because
everything runs client-side from the bundled library, no external service is
involved.

To confirm it worked, visit the front end of the site on a mobile browser (or a
device emulator) and the install invitation should appear according to the timing
you configured.
