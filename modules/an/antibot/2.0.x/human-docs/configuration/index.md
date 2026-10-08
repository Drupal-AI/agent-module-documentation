# Configuration — choose which forms to protect

Antibot has a single settings page where you list the forms it should guard. Each
form is identified by its **form ID**, and you add one ID per line. Out of the box
Antibot already protects the most commonly abused forms; you can add your own,
exclude specific forms, and use a debug mode to look up any form's ID.

## Open the settings page

1. Go to **Configuration → User interface → Antibot**
   (`/admin/config/user-interface/antibot`).

![The Antibot settings page](../images/settings.png)

## Form IDs — the forms Antibot protects

The **Form IDs** box lists every form that Antibot protects. Enter **one form ID
per line**. Wildcard (`*`) characters are allowed, so a single line like
`comment_*` covers every comment form on the site at once.

Antibot ships with a sensible default list already filled in, covering the forms
that attract the most spam:

- `comment_*` — every comment form.
- `user_pass` — the password-reset (forgotten password) form.
- `user_register_form` — the user registration form.
- `contact_message_*` — site and personal contact forms.
- `webform_submission_webform_*` — Webform submissions.

To protect an additional form — for example a custom newsletter signup or a login
form — add its form ID on its own line.

## Excluded form IDs — the forms Antibot leaves alone

The **Excluded form IDs** box is the opposite list: any form ID you put here is
**never** protected, even if it matches a wildcard in the Form IDs box. This is how
you carve out an exception — for instance, keep `comment_*` protecting every comment
form while excluding one specific comment form that must work without JavaScript.
The same rules apply: one ID per line, wildcards allowed.

## How to find a form's ID

If you do not know a form's ID, turn on the built-in debug mode:

1. Tick the **Display form IDs** checkbox near the bottom of the settings page.
2. Click **Save configuration**.
3. Browse to the page that contains the form you want to protect. Antibot now
   prints each form's ID on the page — along with whether Antibot is currently
   protecting that form — for any user who has permission to reach these settings.
4. Copy the form ID you need.
5. Return to the Antibot settings page, **untick Display form IDs**, and save
   again. This debug mode should only be turned on temporarily.

Common targets people add or keep are the **user login and registration forms**,
the **password-reset form**, and **comment forms** — the anonymous-accessible forms
that bots hit most often.

## Save

Once your Form IDs and Excluded form IDs lists are set, click **Save
configuration**. Protection takes effect immediately: the next time a matching form
is rendered, Antibot guards it, and a visitor without JavaScript will be unable to
submit it.
