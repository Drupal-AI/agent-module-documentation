# Configuration

Mail Denylist has no site‑wide settings form to fill in — "configuring" it simply
means maintaining the list of addresses you want to block. That happens on one
page.

## Open the denylist

1. Log in as a user with permission to administer the denylist (an administrator
   by default — see the permissions note below).
2. Go to **Configuration → System → Mail Denylist**
   (`/admin/config/system/mail-denylist`).

You'll see the current denylist, with controls to add new entries and remove
existing ones.

## Add an address or domain

Add the email addresses (or domains) that your site should never send mail to.
Once an entry is on the list, any outbound message whose recipient matches it is
prevented from being delivered. Typical entries are:

- **Known‑bad or hard‑bouncing addresses** — mailboxes that no longer exist and
  keep bouncing, which drag down your delivery reputation.
- **Complaint addresses** — recipients who marked your mail as spam and should not
  be contacted again.
- **Real customer addresses on a staging site** — to make sure test sends never
  reach them.

## Remove an address

When an entry is no longer needed — for example, an address that's valid
again — remove it from the same page and mail to that recipient resumes normally.

## Permissions

Mail Denylist provides its own permission(s) for managing the list. Grant them
only to trusted administrators at **People → Permissions**
(`/admin/people/permissions`), since anyone who can edit the denylist can
effectively stop mail from reaching specific recipients.

## What it does *not* do

Keep the module's scope in mind: it blocks delivery to the exact addresses and
domains you list. It does **not** reroute blocked mail to another address, and it
does **not** support wildcard or pattern matching beyond what you enter. If you
need those behaviours, look at the Reroute Email module instead.
