<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Login Notification sends users an email notification when their account logs in.

---

Login Notification **emails a user when their account logs in** — a security alert plus a one-time
"close all sessions" logout link, so users can notice and respond to unexpected logins. It is in the User
interface package.

Use it as a compromise-detection signal. This is a **security-positive** feature, and it is implemented safely
(reviewed): the alert goes to the account's **own email only** (`$account->getEmail()`), and the "close all
sessions" link is an **HMAC keyed with the site's `hash_salt`** (`Crypt::hmacBase64(..., getHashSalt())`)
verified with the timing-safe **`hash_equals()`** before destroying sessions. Two minor caveats: the email is
sent **synchronously in the login hook** (no cron), and the body is a static message with **no IP / time /
location** — so it tells the user *a* login happened but gives nothing to judge whether it was theirs; adding
context would make it a stronger signal. It has no access-control role. Enable login notifications.

---

- Email the user on account login.
- Send a security alert.
- Include a one-time close-all-sessions link.
- Send to the account's own email only.
- Key the link HMAC with hash_salt.
- Verify it with hash_equals().
- Provide compromise detection.
- Note the alert lacks IP/time/location.
- Send synchronously (no cron).
- Have no access-control role.
- Enable login notifications.
- Handle login alerts.
- Notify on login.
- Configure notifications.
- Alert on logins.
- Handle the alert.
- Detect compromise.
- Email on login.
- Close sessions.
- Provide login alerts.
