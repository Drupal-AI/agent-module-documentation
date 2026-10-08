# Configuration

Setting up Json Users Import happens in two steps: first you tell the module which
JSON keys correspond to which user fields (and, optionally, how to email new
users), then you paste your JSON and run the import.

## Step 1 — Map your JSON to user fields

Go to **Configuration → People → Json users import configuration**
(`/admin/config/people/json_users_import_config`). The form lists the core and
custom fields on your user accounts so you can line them up with the keys in your
JSON data.

- **Email field key** — the JSON key that holds each user's email address. Email
  is required, so this must be mapped.
- **Username field key** — the JSON key that holds each user's username. The
  username is also required. If your JSON has no obvious username, map whichever
  key you want to serve as the account name.
- **One entry per additional user field** — for every extra field on your user
  accounts (the custom fields you've added), the form shows a text box where you
  enter the JSON key that should populate it.

### Welcome email options

- **Send E-Mail to users** — tick this to email each newly created account. Leave
  it off if you don't want any mail sent.
- **Subject** — the email subject line. It supports tokens, so you can
  personalise it.
- **What to send** — choose one:
  - **Send one-time login URL** — the email contains a one-time login link the
    user clicks to set their own password.
  - **Send password** — the email contains the random password the module
    generated for the account.
- **Content** — the body of the email for whichever option you chose (a one-time
  login body or a password body), also token-aware.

Click **Save** when the mapping and email settings are as you want them. Remember
that sending mail depends on the SMTP module being installed and configured.

## Step 2 — Run the import

Go to **People → Json users import** (`/admin/people/json_users_import`), paste a
JSON **array of user objects** into the text area, and click **Import**.

- The input must be a valid JSON array; otherwise the form reports **"Not a valid
  Json!"**.
- The import runs as a batch, so large lists are processed in chunks.
- For each row it validates the username (checking for spaces, length, and illegal
  characters), **skips** any row whose email or username already exists, and
  otherwise creates the account.
- Each created account is set **active** with a random password, its email and
  username taken from the keys you mapped, and any extra mapped fields filled in.
- If you enabled welcome emails, each new user receives the one-time login link or
  password you configured.

Afterwards the new accounts appear in the normal user list at
**People** (`/admin/people`).

## Important reminders

- **These are real, active accounts.** Anyone who can reach this form can create
  login-enabled users in bulk — treat it as a sensitive capability and only
  import trusted data. Because the accounts are active immediately, review the new
  entries after each import.
- **No roles are ever assigned.** Imported users hold only the authenticated role;
  the import cannot create admin or otherwise elevated accounts.
- **You are handling personal data.** The JSON you paste typically contains real
  people's names and email addresses — handle and store it accordingly, and be
  mindful of privacy obligations when importing and when sending welcome mail.
