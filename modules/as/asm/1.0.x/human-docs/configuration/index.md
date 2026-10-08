# Configuration

Configuring Avoid sending mail means one thing: telling it which email addresses
should never receive mail from the site.

## Open the settings

1. Log in as a user with the **Administer asm email blocked** permission (an
   administrator by default). You can grant it under **People → Permissions**
   (`/admin/people/permissions`).
2. Open the module's settings form from the administration area. It is available
   to any user who holds that permission.

## Build the blocklist

The settings hold the **list of blocked email addresses**. Any outbound message
addressed to an entry on this list is suppressed rather than sent. Add the
addresses (or patterns) you want to protect — for example, on a staging site you
might block the real addresses of your actual users so a test run cannot email
them. Save the form to apply the list.

## How to use it well

- On a **staging or development** copy of a site, populate the blocklist with the
  addresses you must not email (or the domains your real users are on) so test
  activity cannot reach them.
- In **production**, either leave the module disabled or keep the list limited to
  genuinely problematic addresses you deliberately want to suppress — remember
  that anything on the list will silently *not* receive mail, including messages
  it may legitimately need.
- Because blocked mail is dropped rather than queued, treat the blocklist as a
  hard "do not send" and review it whenever you promote a site between
  environments.

## Verify it worked

Trigger an email to a blocked address (for example, request a password reset for
a test account on that address) and confirm the message is **not** delivered,
while mail to an address that is *not* on the list still goes through as normal.
