# Configuration

User CSV Import has **no separate settings page**. You configure each import right on
the import form, and can optionally save those options so they pre-fill next time.
This page walks through the form options and the CSV file format.

## Open the import form

1. Log in as a user with the core **Administer users** permission.
2. Go to **People** (`/admin/people`) and click the **Import users from CSV** action
   link, or navigate directly to `/admin/people/import`.

## Form options

| Option | What it does |
|---|---|
| **CSV file** | The file to upload (`.csv` only). |
| **Separator character** | The column delimiter. Default `,` — use `;` for CSVs exported from French/European Excel. |
| **Default password** | Applied to every imported account unless a per-row `pass` column overrides it. Ships as the literal `change me` — change it, and have users reset on first login. |
| **Status** | Whether new accounts are **Active** or **Blocked**. Use Active if you're sending a welcome email so users can log in. |
| **Registration email type** | Send **nothing**, or send **"Welcome (new user created by administrator)"** — the welcome email with a one-time login link. |
| **Roles** | The roles granted to every imported user. **Authenticated** is mandatory and always on. |
| **Select fields to import** | Tick which user fields the CSV columns map to. **Name** and **Email** are mandatory and always on. |
| **Save configuration** | If ticked, remembers the options above so the next import pre-fills them (see below). |

Two buttons submit the form: **Import users** runs the import, and **Generate sample
CSV** downloads a template.

## The CSV file format

- **Row 1** is the header: field machine names as column headers, lower-case, in the
  order your data columns appear — for example
  `name,mail,field_first_name,field_last_name,field_phone`.
- **Each following row** is one user, with values in the same column order.
- **`name` and `mail` are required columns.** Most core field types import; the
  known exceptions are **Image** and **Taxonomy term**.
- An optional **`pass`** column sets a per-user password (stored hashed), overriding
  the form's default password for that row.

Not sure of the exact headers? Tick the fields you want and click **Generate sample
CSV** — it downloads a `user-csv-import-sample.csv` whose header is exactly your
chosen fields, with two example rows to copy.

## What happens on import

For each data row the module:

1. Builds a **unique username** from the first column, appending `1`, `2`, … if the
   name already exists.
2. Sets the password from the row's `pass` column if present, otherwise the default.
3. **Skips** the row if a user with that email already exists (and tells you so),
   otherwise creates and saves the account.
4. Sends the chosen registration email, unless you selected "none".

Afterwards it reports "Successfully imported N users." and returns you to the People
page.

## Saved configuration

When **Save configuration** is ticked, your choices are written to the
`user_csv_import.importconfig` config object (roles, status, default password,
registration email type, and the selected fields). These values only **pre-fill** the
form next time — each import still uses whatever is on the submitted form. Read them
back with:

```bash
drush cget user_csv_import.importconfig
```
