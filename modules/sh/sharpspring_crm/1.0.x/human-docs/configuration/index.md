# Configuration

Setting up SharpSpring CRM has two parts: enter your SharpSpring credentials on the
module's settings form, then attach one of its handlers to the webform(s) you want to
sync.

## Enter your SharpSpring credentials

1. Log in as a user with the **Administer sharpspring settings**
   (`administer sharpspring settings`) permission — keep this restricted to marketing
   administrators.
2. Go to **Configuration → SharpSpring CRM → settings**
   (`/admin/config/sharpspring_crm/settings`).

On this form (config object `sharpspring_crm.settings`) you fill in:

- **Account ID** (`account_id`) — your SharpSpring account ID.
- **Secret key** (`secret_key`) — your SharpSpring Public API secret key. Note that
  this is stored in ordinary module configuration and, as explained in the main
  guide, is sent to SharpSpring over plain HTTP in the request URL — treat it as
  exposed on the wire.
- **Backup email address** (`backupEmailAddress`) — an address that is emailed, with
  a link to the submission, whenever a lead fails to reach SharpSpring, so failures do
  not go unnoticed.

Save the form. You can sanity-check the credentials later: when you configure a Lead
handler it tries to load your SharpSpring field list, and an invalid account
ID/secret pair shows a "no relevant fields" message instead of the fields.

## Attach a handler to a webform

The actual syncing happens through two Webform handler plugins. Edit the webform you
want to connect, go to its **Settings → Handlers** (in the Webform UI, under
Emails/Handlers), click **Add handler**, and choose one:

### SharpSpring Lead Handler

Use this to create a SharpSpring **lead** from each submission.

- Its configuration form loads your active SharpSpring lead fields and shows a text
  field for each one. In each, you enter the **machine name of the webform field**
  whose value should be mapped into that SharpSpring field.
- Required SharpSpring fields can be marked required in the mapping.
- When a form is submitted, the handler builds the mapped values and creates the lead
  in SharpSpring. If the call fails, it emails your backup address with a link to the
  submission.

### SharpSpring List Handler

Use this to add the submitter to a SharpSpring email **list**.

- Choose one of your SharpSpring active lists.
- On submission, the handler adds the submitter's email address to that list — ideal
  for newsletter or event-registration signups. You can route different webforms to
  different lists by adding the handler to each with a different list selected.

Both handlers need a valid account ID and secret key to function; without them the
handler configuration form cannot load your SharpSpring fields or lists.

## Operating notes

- Grant `administer sharpspring settings` only to trusted marketing admins.
- You can disable a handler to pause syncing without deleting its field mapping.
- API errors are logged to the `sharpspring_crm` log channel, so check
  **Reports → Recent log messages** if submissions are not reaching SharpSpring.
- Because credentials travel over plain HTTP, put an HTTPS-terminating egress proxy in
  front of the outbound traffic if you can, and rotate the secret key if it may have
  been exposed.
