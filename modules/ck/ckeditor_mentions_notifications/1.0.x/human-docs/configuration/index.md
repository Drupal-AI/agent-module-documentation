# Configuration

There are two parts to configuring this module: the administrator sets the email
that goes out when someone is mentioned, and each user can decide whether they
want to receive those emails.

## Configure the notification email (administrator)

The module provides a settings form where you compose the notification email. Open
it from the module's entry (via the **Extend** page's configure link, or from
**Configuration**), and fill in:

- **Subject** — the subject line of the notification email. You can include
  **tokens** so the subject is personalized (for example, who did the mentioning).
- **Body** — the message body, also token‑aware, so you can include details such
  as the mentioning user's name and a link to the content where the mention
  occurred.

Use the token browser (where shown) to insert valid tokens rather than typing them
by hand, then save the form. These values are used for every mention notification
the site sends.

## Per‑user opt‑out

Each user can control whether they receive mention notifications from their own
**profile edit** page, which gains a checkbox for enabling or disabling mention
notifications. Respect this preference: if a user turns notifications off, they
will not be emailed even when mentioned. This is what keeps the feature from
becoming an unwanted source of email.

## A privacy reminder

A notification tells the recipient that they were referenced, and it typically
reaches them by email. Make sure the email is sent only to the intended recipient
and that using it fits your site's email and privacy practices.
