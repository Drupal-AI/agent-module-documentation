# Configuration

Mother May I has a small settings form: you define the **secret word** that new
registrants must enter, and an optional **hint** to help genuine members guess it.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to the Mother May I settings page (route `mothermayi.settings`), under
   **Configuration**.

## The settings

- **Secret word** — the word or phrase a new user must type on the registration
  form before their account request is accepted. **If you leave this empty, the
  module does nothing** and registration proceeds normally. Choose something your
  intended audience can be told out-of-band but an outsider won't guess.
- **Hint** — an optional message displayed on the registration form. Make it
  descriptive enough that a legitimate member (say, someone in your organisation)
  can work out the secret word, but not so obvious that a stranger can. For
  example, a hint like "the name of our founder" works if that's known internally
  but not publicly.

## Save

Save the form. The gate takes effect immediately: the registration form now shows
the secret-word field and hint, and incorrect attempts are logged to **Reports →
Recent log messages**.

## Keep its limits in mind

- The secret word is a **shared, low-entropy** gate — anyone who learns it can
  register, and there is no built-in limit on guessing. Rotate the word if you
  suspect it has leaked.
- Mother May I protects **only the registration form**. For other spam targets
  (contact form, comments, webforms), add a general solution such as
  [Honeypot](https://www.drupal.org/project/honeypot) or
  [CAPTCHA](https://www.drupal.org/project/captcha).
- Remember the module is **unsupported** with revoked security coverage — prefer
  a maintained alternative where you can.
