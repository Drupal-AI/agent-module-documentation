# Configuration

Password Reset Code has two configuration touch points: its own settings form for
the reset policy and messages, and the core account‑settings email template where
the code is inserted into the reset email.

## Open the settings form

1. Log in as a user with the **Administer password reset codes** permission.
2. Go to **Administration → Configuration → People → Password reset by code**.

## Reset code policy

On the Password reset by code form you control how the codes behave. Set these
deliberately — they are the difference between a safe reset flow and a weak one:

- **Code expiration time** — how long a verification code stays valid before it
  expires (by default the module follows Drupal's `password_reset_timeout`, 24
  hours). Keep this **modest**: a shorter window narrows the time an intercepted
  code is useful.
- **Maximum code attempts** — how many wrong guesses are allowed before the code is
  rejected (default **5**). This is what stops a short numeric code from being
  brute‑forced, so keep it **low**.

An expired code, and a code that has been used successfully, is deleted — codes are
single‑use.

## User messages

The same form lets you customize the messages users see for a **successful** and a
**failed** password reset. Word these clearly so users understand what happened and
what to do next.

## The reset email template

The email that carries the code is edited with the other account emails at
**Administration → Configuration → People → Account settings**. The template uses
two tokens that are replaced at send time:

- `[one-time-reset-login-link]` — the reset login link.
- `[one-time-verification-code]` — the verification code the user must enter.

A typical template reads something like:

```
Hi [user:display-name],

Forgotten your password? Click the link below to reset it. The link is only
available for 24 hours.

Click here to reset your password: [one-time-reset-login-link]
Your verification code: [one-time-verification-code]

[site:name] team
```

Make sure both tokens appear in the template, or users will not receive the pieces
they need to complete the reset.

## Managing active reset codes

From the **Password reset by code** area, administrators can also **view active
reset codes** and **revoke or extend** them, in addition to configuring the policy
above.

## A note on safety

The code‑based reset is only as trustworthy as the email path it travels. Combined
with a low attempt limit and a modest expiry, ensure your outbound mail is
delivered securely — as with any emailed secret, whoever can read the mailbox can
complete the reset.
