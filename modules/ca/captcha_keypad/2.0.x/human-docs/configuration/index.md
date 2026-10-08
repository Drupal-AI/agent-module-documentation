# Configuration

## Open the settings form

1. Log in as a user with the module's Captcha Keypad administration permission (an
   administrator by default).
2. Go to the Captcha Keypad settings form (route `captcha_keypad.settings`).

## Settings

- **Code size (length)** — how many digits the challenge code has (default 4). Keep
  this at a normal value. **Do not set it to 99**, which triggers a built-in test
  shortcut that lets a fixed string pass the challenge.
- **Display theme** — choose the keypad layout that fits your design:
  - **Plain** — a compact floating keypad with a minimal footprint.
  - **Horizontal** — a two-column grid with the buttons and the input side by side
    (the default).
  - **Vertical** — a 3×3 button grid with the input at the top, good for narrow
    sidebars.
- **Shuffle the keys** — randomize the button positions on every page load so a bot
  cannot rely on fixed coordinates. Recommended.
- **Admin-exempt mode** — skip the challenge for user 1 and for anyone holding the
  Captcha Keypad administration permission, so site builders never lock themselves
  out.

## Assign the challenge to forms

Captcha Keypad is meant to be driven by the **CAPTCHA** module. After saving the
settings above, go to the CAPTCHA module's administration pages and assign the
**Captcha Keypad** challenge type to the forms you want to protect (registration,
login, contact, forum comments, Webforms, and so on). Driving it through CAPTCHA is
what keeps validation server-side and secure.

## A note on development environments

If you do not want to solve the keypad on your local or staging environment, the
module supports disabling it based on an environment variable (or any other
condition) rather than turning it off in configuration — useful so automated test
suites run without intervention. Never disable it in production.

## Save

Click **Save configuration**. Then verify the challenge on a real form as described
in [Installation](../installation/index.md).
