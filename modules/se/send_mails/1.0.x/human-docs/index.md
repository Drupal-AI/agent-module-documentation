# Send Mails — manual setup guide

**Send Mails** (`send_mails`) gives your Drupal site a simple, Gmail‑style form for
composing and sending email straight from the site. It presents a **To** address
field, a **Subject** field, and a **Message body** field, and it supports full
HTML messages so you can send styled text. You can attach a file to a message, and
you can also send role‑based emails — that is, send one message to everyone in a
chosen role. Under the hood it also provides an API/service layer so other code
can send mail in a consistent way.

The module works through two permissions and a block rather than a settings form.
Grant **Access Send Mails Service** to let a user reach the send form, and
**Access Advanced Send Mails Service** to unlock the advanced options such as
role‑based sending. The send form itself lives at `/send-mails/send`, and there is
a **Send Mails Block** you can place in a region from the Block Layout page.
Optionally, enabling a WYSIWYG editor module gives the message body rich‑text
styling. Send Mails runs on Drupal 9, 10, and 11, and *is* covered by Drupal's
security advisory policy.

A word of caution, since this is an email‑sending tool: anything that can send mail
is powerful. Grant its permissions — especially the advanced, role‑based option —
only to trusted operators, so the form can't be turned into a spam or relay vector,
and treat recipient lists as personal data. There is a 5 MB cap on attachments,
and only a fixed list of file types is accepted (zip, tar, gz and similar
archives, common image formats, and office/PDF documents).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and grant the permissions.

## How to use it

Send Mails has no central settings page. After enabling it, set it up like this:

1. **Grant permissions** at **People → Permissions**
   (`/admin/people/permissions`): give *Access Send Mails Service* to users who
   may send basic email, and *Access Advanced Send Mails Service* to those allowed
   the advanced role‑based options.
2. **Open the send form** at `SITE_URL/send-mails/send`. Fill in the recipient,
   subject, and (HTML) body, attach a file if needed, and send. With the advanced
   permission you can instead target a role.
3. **Optionally place the block** — go to **Structure → Block layout**
   (`/admin/structure/block`) and position the **Send Mails Block** in a region so
   the compose form is reachable from a page.
4. **Optionally add a WYSIWYG editor** so the message body field gets rich‑text
   styling.
