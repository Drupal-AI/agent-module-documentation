PWA Add to Home Screen provides a placeable block containing an intro text and a button that prompts visitors to install the site as an app on their home screen.

---

This submodule of PWA adds a single block plugin, `pwa_add_to_home_screen` ("PWA Add to Home Screen", category "PWA"). When placed, the block renders configurable introduction text (a formatted-text field) and an install button whose label comes from the block's `button_text` setting (default "Install app"). The block attaches the `pwa_a2hs/pwa_a2hs_prompt` JavaScript library and passes `button_text` to the browser via `drupalSettings.pwaA2hs`; the script hooks the browser's install-prompt flow so clicking the button triggers the native "add to home screen" prompt where supported. Configuration is per block instance (the block's settings form has an "Introduction text" rich-text field and a "Button text" textfield), stored in the block config entity (`block.settings.pwa_add_to_home_screen` schema adds `button_text`). It depends on the base `pwa` module and has no admin settings page of its own.

---

- Add an "Install app" call-to-action block to the sidebar or footer of a PWA site.
- Prompt mobile visitors to add the site to their home screen from a visible button.
- Customize the install button label (e.g. "Get the app", "Add to phone").
- Add introductory rich text above the install button explaining the benefit.
- Place the prompt only on specific pages using core block visibility conditions.
- Show the A2HS block only to authenticated users via block role visibility.
- Reinforce app installability alongside the browser's own install affordance.
- Provide a branded install experience rather than relying on browser UI alone.
- Position the install prompt in any theme region as a standard Drupal block.
- Localize the button text and intro per language via block translation.
- Offer the install prompt on a campaign landing page only.
- Pair with pwa_extras/pwa_service_worker for a fuller app-like experience.
- Hide the block on admin pages while showing it on the public frontend.
- Give editors control over the prompt copy without code.
- Use multiple instances with different copy in different regions.
