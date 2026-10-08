# Configuration

Database Export UI does not have a settings form in the usual sense — its
"configuration" is granting the right permission and then using the export page.
The important part is controlling who can reach it.

## Grant the permission (do this carefully)

The export page is gated by a dedicated permission, **`administer db exports`**.
Because a database export can expose the entire contents of your site, grant it
only to trusted administrators.

1. Go to **People → Permissions** (`/admin/people/permissions`).
2. Find **Administer db exports** (provided by Database Export UI).
3. Tick it **only** for roles you fully trust — typically just Administrator.
4. Save permissions.

## Use the export page

1. Go to **Configuration → Development → Database Export**
   (`/admin/config/development/db-export`).
2. Decide whether to enable **user data sanitization**. When on, the module
   strips or obfuscates basic user data before writing the dump. Treat this as a
   *basic* measure — it is intentionally minimal and may not remove every piece of
   sensitive data your project cares about, so review and extend it if you plan to
   share the dump widely.
3. Start the export. The module runs `mysqldump` and produces a compressed
   `.sql.gz` file.

## Handle the exported file safely

- A dump contains the site's data and should be treated as confidential. Store it
  in a secure location and delete it once you no longer need it.
- Grant the **`administer db exports`** permission only to trusted administrators.
- This module does not provide restore, scheduling, or remote destinations. For
  production backup needs, use **Backup and Migrate** instead.
