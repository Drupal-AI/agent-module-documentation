# Configuration

The module's settings control the code‑based verification flow. Because this is a
security feature guarding account creation, it's worth understanding what the
settings govern rather than just accepting defaults.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → People → OTP**, or navigate directly to
   `/admin/config/people/otp`.

## What the settings govern

The form configures how the verification code is generated, delivered, and
checked during registration. When you set it up, pay attention to the properties
that actually determine how strong the verification is — these are the levers to
review for your site and to confirm on the specific release you install:

- **Code length and alphabet** — this sets the search space an attacker would have
  to cover. A longer code, or one using letters as well as digits, is far harder
  to guess than a short numeric one.
- **Attempt limit** — a cap on how many wrong guesses are allowed per account is
  what makes the code's length meaningful. A six‑digit code with unlimited guesses
  is only a million tries against a single account; with a low attempt limit it is
  genuinely strong.
- **Expiry** — how long a code stays valid. A short window bounds the time an
  intercepted or guessed code is useful.
- **Send throttling (flood control)** — a limit on how often codes can be
  requested. Without it, the registration form can be abused to make your site
  email arbitrary addresses.

Configure these to suit your risk tolerance, save the form, and then run a test
registration to confirm the end‑to‑end flow (code delivered, entry required,
account activated on success).

## A note on the open verification route

The verification form at `/user/register/otp` is necessarily reachable without
login — the person using it doesn't have an account yet. That's expected and
correct; it just means the strength of the whole feature rests on the settings
above (code strength, attempt limit, expiry, and send throttling) rather than on
route access.
