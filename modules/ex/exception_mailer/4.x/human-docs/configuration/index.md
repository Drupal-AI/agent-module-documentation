# Configuration

All of Exception Mailer's behavior is set on one form: whether it sends mail at all,
who receives it, which errors qualify, which to ignore, and how flood protection
behaves.

## Open the settings form

1. Log in as an administrator.
2. Go to **Administration → Development → Exception mailer config**
   (`/admin/config/development/exception_mailer`).

## Enable or disable sending

- **Enable/disable sending emails** — the master switch. Turn it on when you want
  notifications, off when you don't (for example while doing noisy maintenance).

## Choose recipients

You can send notifications to whichever is more convenient — or both:

- **Role(s)** — pick one or more roles; users assigned to those roles receive the
  emails. Because the messages can contain sensitive diagnostic detail, choose roles
  whose members should legitimately see error internals.
- **Specific email recipients** — add one or more explicit addresses. Prefer a secure,
  trusted admin inbox over a shared or external mailbox.

## Choose which errors trigger an email

- **Error level** — select which severity levels (critical, error, warning, etc.)
  should generate an email. Set this to match how much noise you can tolerate: limiting
  to *critical* and *error* keeps volume down, while including *warning* casts a wider
  net.

## Exclude noisy or expected errors

- **Excludes** — add exclude definitions so specific, known errors do not send an email.
  This is how you silence expected or repetitive exceptions without turning the whole
  module off.

## Flood protection

- **Flood protection** — the module ships with sensible flood control so the same error
  repeating rapidly does not flood your inbox with duplicates. You can customize the
  defaults here if the built-in limits don't fit your site's traffic and error
  patterns.

## Save

Click **Save configuration**. Changes take effect immediately.

## A reminder about content and volume

Exception emails may include stack traces, file paths, and context that can be
sensitive — keep recipients trusted and the inbox secure. And remember that a burst of
errors can become a burst of emails: lean on the excludes and flood protection to keep
that manageable.
