# Configuration

Delay Submit does nothing until you tell it which forms to slow down. You do that
on its settings page, form by form.

## Open the settings

1. Log in as a user with the **administer delay submit settings** permission (an
   administrator by default).
2. Go to **Configuration → People → Delay Submit**
   (`/admin/config/people/delay-submit`).

## Add the forms to delay

- **Form IDs** — add the ID of each form you want the delay applied to. A form‑ID
  autocomplete helps you find likely candidates (it suggests Webform and a few
  common core forms such as login, registration, and password reset). Form IDs
  are matched flexibly, so either the underscore form (`user_login_form`) or the
  hyphen form (`user-login-form`) works.
- **Delay time** — set the delay, in **milliseconds**, for each form. This is how
  long the submit button stays hidden before it appears.
- **Fade‑in duration** — a global setting controlling how smoothly the submit
  button fades into view once the delay has elapsed.

## Save

Click **Save configuration**. On the forms you listed, the submit button is now
hidden and then revealed after the configured delay — no further setup is needed,
and the delay applies automatically from then on.

## Good to know

- **It is a client‑side, cosmetic delay.** The timing runs in the browser, so it
  is a UX / nuisance‑mitigation measure rather than a hard security control. A
  determined bot that ignores your JavaScript is not blocked by it.
- **Pair it with real anti‑spam.** For actual protection, combine Delay Submit
  with Honeypot and/or CAPTCHA/reCAPTCHA. Delay Submit's role is to stop the
  premature submissions that would otherwise trip *those* tools' "too fast"
  rules.
- Good candidate forms include contact, login, registration, and Webform forms —
  the autocomplete suggests several of these.
