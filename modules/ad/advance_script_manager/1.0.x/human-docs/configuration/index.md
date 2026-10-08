# Configuration

> **Security first.** Everything on this page injects code that runs in your
> visitors' browsers. The `advance_script_manager_settings` permission is marked
> *restricted* for exactly this reason. Grant it only to administrators you fully
> trust, and treat adding a script with the same care you would treat editing
> live site code.

## Open the script manager

Log in as a user with the `advance_script_manager_settings` permission and go to
the module's management screen (route
`advance_script_manager.advance_script_controller_build`). This is where you add,
edit, enable, and disable your script snippets.

## Add a script

For each snippet you typically set:

- **The script itself** — the code (for example a tracking or analytics tag) that
  will be added to the page head.
- **Enabled / disabled** — new scripts are **disabled by default**. A script does
  nothing until you deliberately enable it, which prevents half-finished snippets
  from going live.
- **Visibility** — per-script rules controlling which pages the snippet is
  injected on, so a tag can be scoped rather than loaded everywhere.

Enabled scripts are added to matching pages via Drupal's page-attachments
mechanism.

## Enable, disable, and review

Use the enable/disable toggle to turn snippets on and off without deleting them —
handy for temporarily pausing a tag. Review the list periodically: because these
snippets run for every visitor, an out-of-date or unnecessary tag is worth
removing.

## Privacy and consent

Most snippets managed here are tracking or marketing tags that set cookies or
send data to third parties. That carries GDPR/ePrivacy obligations — pair these
scripts with a cookie-consent tool so they only run when the visitor has agreed.
