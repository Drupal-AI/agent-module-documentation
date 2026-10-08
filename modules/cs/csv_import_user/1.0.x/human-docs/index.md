# CSV Import Users — manual setup guide

**CSV Import Users** (`csv_import_user`) provides an administrative form to
**import Drupal user accounts in bulk from a CSV file**. It maps columns in the
file to user properties, assigns roles from the file, and creates the accounts —
saving you from creating many users by hand during onboarding or a migration. It
depends on core's **User** and **File** modules and supports Drupal 10.3 and 11.

The import lives at a single admin form and is gated by the **Administer users**
(`administer users`) permission — the same privilege you'd need to create users
and grant roles manually — so it is correctly restricted to user administrators.

Because this tool **creates accounts and can grant roles** from spreadsheet data,
treat every import deliberately. A few things to keep in mind:

- The CSV is **untrusted input that becomes real accounts and personal data**
  (usernames, email addresses, and any profile fields you map). Validate the file
  before importing, and handle it in line with your privacy obligations.
- Be careful which **roles** the file grants — don't hand out privileged roles
  unintentionally by leaving a stray value in the role column.
- Think about **account status and passwords** for imported users (whether
  accounts are active, and how credentials or password‑reset flows are handled)
  before you run a large import.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module's UI is a single **import form** rather than a settings page, so there
is no separate configuration to fill in — you go straight to the import form,
described in "How to use it" below.

## Where it lives in the admin menu

Once enabled, the importer is available at **Configuration → People → User import**
(`/admin/config/people/user-import`, config route `csv_import_user.import_form`),
to users with the **Administer users** permission.

## How to use it

1. Prepare a **CSV file** with a header row. The documented format uses these
   columns: `username`, `email`, `role`, `field_address`, and `field_company` —
   for example:

   ```
   username,email,role,field_address,field_company
   jdoe,jdoe@example.com,administrator,street123,xyzcompany
   ```

   Map the columns to the user properties and fields you actually want to populate,
   and double‑check the `role` values so you don't grant more than intended.
2. Go to **Configuration → People → User import**
   (`/admin/config/people/user-import`).
3. Upload your CSV file and run the import.
4. Review the created accounts under **People** (`/admin/people`) to confirm the
   usernames, emails, roles, and fields imported as expected.
