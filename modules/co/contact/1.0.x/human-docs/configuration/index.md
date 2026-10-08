# Configuration

Setting up Contact has three parts: creating one or more contact forms, tuning the global
settings (default form, flood control, personal‑form defaults), and granting the right
permissions. Optionally you can add custom fields to a form.

## 1. Create a contact form

Out of the box there is no site‑wide form, so `/contact` returns a 404 until you make one.

1. Log in as a user with the **Administer contact forms** permission.
2. Go to **Structure → Contact forms** (`/admin/structure/contact`).
3. Click **Add contact form** and fill in:
   - **Label** — the form's name (e.g. *Support request*).
   - **Recipients** — one or more email addresses that receive submissions (one per line).
   - **Auto‑reply** — an optional message emailed back automatically to whoever submits.
     Leave blank for no auto‑reply.
   - **Message** *(confirmation)* — the status message shown to the visitor after they
     submit (e.g. "Your message has been sent.").
   - **Redirect path** — where to send the visitor after submitting (e.g. `/thank-you`).
     Leave blank to return to the front page.
   - **Weight** — ordering when you have several forms.
4. Save. You can create as many forms as you need — for example separate Sales, Support,
   and Press forms routing to different teams.

Each form is reachable at `/contact/{form-id}`, and the personal user‑to‑user form lives
at `/user/{uid}/contact`.

## 2. Global settings (`contact.settings`)

A few site‑wide settings control default behavior. The **default form** and personal‑form
defaults are surfaced in the admin UI (**Configuration → People → Account settings**), and
all of them can be set from Drush:

- **Default form** — which form `/contact` shows. Important: the shipped default value is
  `feedback`, but **no form named `feedback` is installed**. So after you create your form,
  point the default at it:
  ```bash
  drush cset contact.settings default_form support -y
  ```
  Until the default points at a form that exists, `/contact` throws a 404 for regular users
  (and shows administrators an error like "The contact form has not been configured").
- **Flood control** — anti‑spam throttling. Defaults to **5 messages per 3600 seconds**
  (one hour) per user:
  ```bash
  drush cset contact.settings flood.limit 3 -y
  drush cset contact.settings flood.interval 3600 -y
  ```
- **Personal contact form default** — whether new user accounts have their personal contact
  form enabled by default (`user_default_enabled`, default on). This appears as a checkbox on
  the **Account settings** page.

## 3. Permissions

Grant these under **People → Permissions** (`/admin/people/permissions`):

- **Administer contact forms** — full access to the `/admin/structure/contact` UI, editing
  and deleting forms, and the contact‑related options on the Account settings page.
- **Use the site‑wide contact form** — access to `/contact` and `/contact/{form}`. Giving
  this to *anonymous* makes your public form reachable by visitors (the common setup), but it
  is also the main spam surface — pair it with the flood settings above and consider a CAPTCHA
  module.
- **Use users' personal contact forms** — lets a user open another user's `/user/{uid}/contact`
  form.

Personal‑form access has extra rules beyond the permission: you can't contact anonymous or
blocked accounts, each user can switch their own personal form off (a checkbox on their user
edit page), and anyone with the **Administer users** permission can reach any account's form
regardless of that preference.

## 4. (Optional) Add custom fields to a form

Because contact forms are fieldable, you can collect extra information (phone number,
department, order ID):

1. Enable Field UI: `drush en field_ui -y`.
2. On a form's edit page (**Structure → Contact forms → [your form] → Manage fields**), add
   your fields; use **Manage form display** to reorder or hide them.

Remember that submissions are **not stored** — the module's storage is a deliberate no‑op —
so any field you add travels into the notification email rather than into a saved record. If
you need to persist submissions, install a storage add‑on (such as Contact Storage), which
swaps in a real storage handler.

## Notes on the personal form

The special **personal** form (used for the user‑to‑user tab) is different from the forms you
create:

- It is not reachable at `/contact/personal` — only through the user profile tab.
- It cannot be edited or deleted through the UI. Its label and confirmation message live in
  the `contact.form.personal` config object and can only be changed with a config edit
  (`drush cset contact.form.personal …`).
- Its recipient is always the contacted user, so its recipients list is intentionally empty
  and its auto‑reply field is ignored.

## Auditing

Since messages are never stored, the record of contact activity is the recipients' mailboxes
plus the `contact` log channel (**Reports → Recent log messages**), which logs every send.
