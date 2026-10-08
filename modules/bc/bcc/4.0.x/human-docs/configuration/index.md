# Configuration

Blind Carbon Copy is configured on its own settings form (**`bcc.settings`**),
reached under **Configuration** in the admin menu. The core of it is simple — the
address that receives a blind copy of outgoing mail — but the decision behind it
is not, so read this whole page before you enable it.

## Open the settings form

1. Log in as a user with permission to administer site configuration (an
   administrator by default).
2. Go to the Blind Carbon Copy settings form under **Configuration**
   (`bcc.settings`).

Set the **BCC address** to the mailbox that should receive the blind copies.

## Before you save — the privacy and security check

Turning this on means *every* email the site sends is also copied to that mailbox.
That includes:

- **Password reset links and one-time login links** — these are credentials.
  Anyone who can read the BCC mailbox can use them to take over accounts on the
  site.
- **Account activation emails**, order confirmations with addresses on them, and
  any message containing personal data a user submitted.

So, in order:

1. **Protect the BCC mailbox to the level of account takeover.** Use a controlled
   address with restricted access — not a shared alias that several people
   forward from.
2. **Use exclusions if the module offers them.** If you can exempt password
   resets and other credential-bearing mail from the copy, do so. If you cannot,
   decide whether the archive is worth collecting credentials into a second
   inbox.
3. **Tell people, if the copy is for compliance.** Recipients are never told a
   blind copy was taken — that is what BCC means. If you keep the archive for
   records, your privacy notice must state that outbound correspondence is
   retained, and you must set a real retention period rather than letting it pile
   up in a mailbox indefinitely.

## Save and verify

Save the form, then send yourself a test email from the site (for example trigger
a contact-form message) and confirm a copy arrives in the BCC mailbox. If you
configured exclusions, also confirm that an excluded message type — such as a
password reset — does **not** arrive there.
