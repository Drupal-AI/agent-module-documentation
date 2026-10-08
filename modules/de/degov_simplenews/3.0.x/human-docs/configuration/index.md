# Configuration

deGov Simplenews needs to know, for each language, which page is your privacy
policy and what consent text to show next to the checkbox. Until that is set for
the current language, the signup form stays hidden.

## Open the settings

1. Log in as a user with the **administer simplenews settings** permission (an
   administrator by default).
2. Go to **Configuration → deGov → Simplenews**
   (`/admin/config/degov/simplenews`).

## Set the privacy policy and consent message per language

For **each enabled language**, configure two things:

- **Privacy policy page** — choose the node that holds your data‑protection /
  privacy policy for that language. The consent checkbox on the signup form links
  to this page so subscribers can read what they are agreeing to.
- **Consent message** — the text shown beside the required checkbox for that
  language. It is rendered using the text format you select (an
  administrator‑trusted setting).

If no privacy‑policy page is defined for a given language, the signup form is
**hidden** for visitors in that language, and administrators see an error
message. So make sure every language your site serves has both a policy page and
a consent message.

## What subscribers and admins see

Once configured:

- The subscription block and subscriber page forms show the **required consent
  checkbox** (linking to the privacy‑policy page) plus **Forename** and
  **Surname** fields.
- A subscriber cannot complete signup without ticking the consent box.
- On the admin **subscriber details** page, the stored consent is displayed —
  showing that the subscriber accepted the data‑protection regulations, and at
  what date and time — to support your GDPR record‑keeping.

## Save

Click **Save configuration**. The consent requirements apply immediately to the
Simplenews subscription forms. Remember to revisit this page whenever you add a
new language to the site.
