# Configuration

**Read this page — the module does nothing useful until you configure it.** As
shipped, the error threshold is `0` and "block submit" is off, so a freshly
installed Pwned Passwords only warns and never blocks. This form is where you turn
it into an actual policy.

## Open the settings form

1. Log in as a user with the **administer pwned_passwords** permission (an
   administrator).
2. Go to **Configuration → People → Pwned Passwords**
   (`/admin/config/people/pwnedpassword`).

## The settings, field by field

- **Which forms to check** — choose where the breach check runs:
  - **User registration form** — check the password a new account chooses.
  - **User profile / account edit form** — check when an existing user changes
    their password.
  - **User login form** (optional) — warn a user at login that their current
    password appears in a breach. Enabling it adds a synchronous outbound request
    to each login.
- **Breach-count threshold** — how many times a password must appear in the breach
  corpus before the module reacts. This is the setting that actually gives the
  module teeth. Leaving it at the shipped `0` means no policy is enforced; set it to
  **1 or higher** so that a password seen in any breach is flagged.
- **Block submission on a match (error vs. warning)** — decide whether a matched
  password produces a blocking **error** (the form cannot be submitted until the
  user picks a different password) or a non-blocking **warning** (the user is told,
  but may proceed). For registration and profile changes, blocking is the stronger
  choice.
- **Validate all passwords** — a global option that is intended to check every
  password field on the site. Prefer the per-form options above.

## How the check protects privacy

Whatever you configure, the check never transmits the password. Drupal hashes the
password with SHA-1 locally, sends only the first five characters of that hash to
HIBP's range API, and compares the full hash against the returned candidates on
your server. This is the k-anonymity model — the plaintext and the full hash both
stay on your site.

## Save and test

Click **Save configuration**. Then test on the form(s) you enabled: try setting a
well-known breached password (for example `password`) and confirm you get the
warning or blocking error you configured, and that a strong, unique password is
accepted.
