# Configuration

Magic Code works through the **Verification API**, so most of its behaviour is
about the *codes* themselves — how long they live and how aggressively guessing
is throttled — plus the two submodules that expose the login and verify flows.
This page focuses on the settings that matter for security.

## Get the mail path right first

Codes are delivered by email, and the code **is** the credential. Before you turn
on passwordless login, make sure your site sends mail over a **secure (TLS)
transport** and that login pages are served over **HTTPS**. Anyone who can read a
user's inbox — or intercept an unencrypted message — can use the code. This is the
inherent trade‑off of any magic‑code system: account security becomes email
security.

## Code lifetime (expiry / TTL)

Each code is stored with a **time‑to‑live** after which it can no longer be used.
Keep this **short** — long enough for a user to switch to their inbox and type the
code, but no longer. A short expiry limits the window in which a leaked or
intercepted code is useful. A code is also **single‑use**: once it has verified a
user it is invalidated, so it cannot be replayed even within its lifetime.

## Flood control (anti‑brute‑force)

This is the setting that makes short codes safe. Magic Code enforces
**flood limits** modelled on Drupal core's `basic_auth`:

- independent **per‑IP** and **per‑user** limits;
- applied to both **code creation** and **code verification**;
- by default on the order of **~50 failed verifications per hour per IP**;
- checked **before** any code lookup, so failed guesses are counted and blocked
  regardless of whether the code exists.

Together with the CSPRNG‑generated codes, this is what mitigates brute force. If
you tune these limits, do not loosen them casually — raising the allowed attempt
count directly widens the brute‑force window. If anything, tighten them for
high‑value accounts.

## Scope of a successful verification

A verification only succeeds when a **non‑expired, active** code matches the exact
**user + email + operation + client** it was issued for. This scoping means a code
minted for one operation cannot be reused for another, and a code for one user
cannot verify a different user.

## Managing issued codes

Magic Code provides a **backend UI** for managing the codes it has issued (the
entry appears in the admin menu once the module and submodules are enabled). Use
it to review or invalidate outstanding codes when needed.

## The login and verify flows

The user‑facing behaviour comes from the submodules:

- **Magic Code Email Login** (`magic_code_email_login`) provides the passwordless
  email login flow.
- **Magic Code Verify Form** (`magic_code_verify_form`) provides a form where a
  user enters a code to verify an action.

The module also exposes **tokens for user email templates**, so the emails that
carry codes can be customised through Drupal's normal token and mail mechanisms.
Keep those templates from ever logging or exposing a code in plaintext anywhere
other than the recipient's message.
