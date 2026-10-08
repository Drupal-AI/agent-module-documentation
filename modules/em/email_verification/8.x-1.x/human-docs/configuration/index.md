# Configuration

Email Verification is configured on a single settings form. You should set it up
before relying on the flow — in particular, set a strong verification key.

## Open the settings form

1. Log in as a user with the **Administer users** permission (an administrator by
   default).
2. Go to **Configuration → People → New User Email Verification**, or navigate
   directly to `/admin/config/people/userverify`.

## The settings

- **Random key to generate verify email hash** — a random string (up to 32
  characters) used as the salt when the module builds the hash embedded in each
  verification link. **Set this to a long, unpredictable value of your own** and
  treat it like a secret.

- **User Verification Email Template** — the body of the email that carries the
  verification link. Write your own message and include the module's tokens so the
  link is inserted:
  - `[user:emailtoverify]` — the address being verified.
  - `[user:emailverificationlink]` — the verification link the visitor must
    follow.

- **User Verification Help text** — guidance shown to the visitor on the
  verification request form (`/user/emailverify`), explaining what to do.

Click **Save configuration** when done.

## How the flow behaves once configured

- An anonymous visitor who tries to register is redirected to `/user/emailverify`
  to enter their email address first.
- The module emails a verification link (of the form
  `/user/register?email=…&verify=…`) built from your configured key.
- When the visitor follows the link, they land on the real registration form with
  the email field **pre‑filled and read‑only**, so they can only register the
  address they verified.
- Logged‑in users are not affected — the check applies to anonymous registration
  only.

> **Note:** the module stores no separate verification log; the whole check is
> carried in the link's hash. This is exactly why the verification key matters so
> much — keep it strong and private.
