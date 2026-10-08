# Configuration

## 1. Route your mail through Backery Mails

Backery Mails registers itself as a mail plugin, and it only captures messages that are
actually sent through it. Go to the **Mail System** settings
(`/admin/config/system/mailsystem`) and point the mail formats/plugins you want to
archive at Backery Mails. From then on, mail those formats send is copied into the
archive and then delivered as normal.

## 2. Browse the captured mail

Go to **`/admin/config/backerymails/mails`** to see the Views list of stored messages.
Open any entry to read the full message — subject, body, headers and recipients — which
is exactly what the site sent, without needing a real inbox to check.

## 3. Settings

The settings form at **`/admin/config/backerymails/settings`** controls capture
behaviour. Adjust it to suit how much you want to keep.

## 4. Clearing the archive

Because every outgoing message is stored, the archive grows over time — and it can
contain sensitive content (password‑reset links, personal data in notifications). Purge
it from **`/admin/config/backerymails/clear`**, which removes all stored mail at once.

## Access and privacy

All of the admin pages require the `administer backerymails` permission, and individual
stored messages are additionally protected by a per‑entity access check. Because the
archive holds the real content of every email — potentially including one‑time links
and personal data — keep the permission tightly restricted, and don't leave a
long‑lived archive enabled on a production site unless you genuinely need it.
