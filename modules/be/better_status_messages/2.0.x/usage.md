<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Better Status Messages restyles Drupal's core status/warning/error messages on front-end pages and adds a per-message close button.

---

Better Status Messages overrides the rendering of Drupal core's `status_messages` theme hook on non-admin pages, wrapping messages in its own Twig template, CSS and JS. Normal messages are shown with white text on a green background and errors with white text on a red background; each message box gets a close (X) button whose click removes the whole message wrapper from the page via a small jQuery behavior. A configuration form (Configuration > Development > Better Status Messages, permission `administer site configuration`) lets an administrator change five color values that are passed into the template as inline styles: status background, status text, error background, error text, and the close-button SVG fill. The module needs no configuration to work and has no non-core dependencies. It does not change which messages are generated, message text, or any access behavior — it is purely presentational, and it deliberately leaves admin pages (and node/term edit forms) using core's default message markup.

---

- Restyle core status messages with a colored box on front-end pages.
- Give error messages a distinct red background separate from status green.
- Add a close/dismiss button to each rendered message group.
- Let users remove read messages from the page for a tidier interface.
- Apply a consistent branded message color scheme via the settings form.
- Change the status message background color site-wide.
- Change the status message text color.
- Change the error message background color.
- Change the error message text color.
- Change the close-button SVG fill color.
- Keep admin pages on Drupal's default message rendering while styling the front end.
- Style status/warning/error message types (warning falls back to the status colors).
- Improve message presentation without writing a custom theme override.
- Provide dismissible messages without a contrib toast/JS library.
- Enable styled messages out of the box with zero configuration.
- Center message text within a max-width column for readability.
- Preview chosen colors live inside the settings form fields.
- Add message styling on Drupal 8, 9, 10 or 11 sites.
- Give a lightweight message UX upgrade with only jQuery + core/drupal.
- Reset message colors by leaving the settings form defaults in place.
