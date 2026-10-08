# Configuration

Configuring Registration codes has three parts: the **settings** that decide how
codes behave, **generating** a batch of codes, and **managing** the codes you've
created. All of it lives under **Configuration → People** and requires the
**Administer registration codes** permission.

## Open the settings form

1. Log in as a user with the **Administer registration codes** permission.
2. Go to **Configuration → People → Registration codes → Settings**, or navigate
   directly to `/admin/config/people/regcode/settings`.

## The settings that decide whether codes are a control

Two settings matter most, and they're worth setting deliberately rather than
leaving at their defaults:

- **Require a code to register** — turn this on so the registration form actually
  demands a valid code. Without it, codes exist but registration is still open.
- **Single-use codes** — decide whether a code can be used once and then is spent,
  or can be reused by many people. This is the setting that decides whether one
  **leaked** code opens the door indefinitely: a code posted in a public forum
  thread is a code everyone has. For invitation flows, single-use is almost always
  what you want.
- **Expiry** — whether (and when) codes expire. This decides how long a leaked
  code stays useful. Even for reusable codes, an expiry limits the damage of a
  code getting out.

Set these, then click **Save configuration**.

## Generate codes

1. Go to **Create codes** (`/admin/config/people/regcode/create`).
2. Choose how many codes to generate and any options the form offers (such as
   length or an expiry date for this batch).
3. Generate the batch. The new codes appear in the code list.

## Manage codes

The code list at **Manage codes** (`/admin/config/people/regcode/manage`) is a
View, so you can filter and sort it and **export** a batch — for example to a CSV
to distribute to attendees. You can also revoke a code here if it leaks.

## Handling codes responsibly

A few principles that follow from what a code actually is:

- **A code is not authentication.** It only establishes that someone *had* a code,
  not *who* they are. Anything downstream that matters — role assignment, access to
  restricted content — should not treat "registered with a code" as identity.
- **Where a code grants a role**, that is a privilege decision made by whoever
  distributes the codes. Be explicit about who is allowed to hand codes out.
- **Treat codes like passwords in transit** — generate them randomly, send them
  over a channel you trust, and don't leave a batch sitting in a spreadsheet that
  everyone can read.
- **Revoke a leaked code** promptly, and use the code list to **audit** which codes
  have been used.
