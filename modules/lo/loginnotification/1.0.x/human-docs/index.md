# Login Notification — manual setup guide

**Login Notification** (`loginnotification`) emails a user every time their
account logs in. The message is a security alert: it tells the person that a
login happened and includes a one‑time **"close all sessions"** link they can
click if it wasn't them, immediately terminating every active session for the
account. It's a lightweight compromise‑detection signal — if you get an email
about a login you didn't make, you know to act.

The feature is **opt‑in per user**: after the module is enabled, each user turns
it on for themselves by ticking the **Login notification** checkbox on their own
profile edit page. There is no site‑wide admin settings form to configure — the
only "setting" is that per‑user checkbox.

A couple of honest caveats worth knowing. The alert is sent **synchronously
during login** (there is no queue or cron step), and the email body is a **static
message** — it does not include the IP address, time, or location of the login,
so it tells the user *that* a login happened but gives them little to judge
whether it was really them. The security fundamentals are sound, though: the
alert only ever goes to the account's **own** email address, and the
"close all sessions" link is signed with an HMAC keyed on the site's hash salt
and verified with a timing‑safe comparison, so the link cannot be forged.

Because it sends email, the module needs a working mail setup. On most sites that
means the [SMTP](https://www.drupal.org/project/smtp) module (or any other
mailing module) configured so Drupal can actually deliver mail.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and make sure mail delivery works.

There is **no configuration page** for this module — it has no admin settings
form. Each user enables notifications for themselves, described in
"How to use it" below.

## Where it lives in the admin menu

Login Notification adds no admin configuration page. The only control is the
**Login notification** checkbox on each user's own profile edit form
(**People → *(user)* → Edit**, or the user's own **My account → Edit**).

## How to use it

1. Make sure your site can send email (see Installation).
2. Each user who wants alerts edits their profile, ticks **Login notification**,
   and saves.
3. From then on, every time that account logs in, an email arrives at the
   account's own address with a link to close all sessions if the login was not
   theirs.
