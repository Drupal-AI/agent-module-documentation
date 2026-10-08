# Configuration

Sync Files is configured from its settings page, which you open as a privileged
administrator. There is very little to it — the module is deliberately tiny.

## Set the source server

Enter the address of the server you want to pull files **from** — typically your
production site. Sync Files uses this address to rewrite the file URLs stored in
your local database: it takes each file's URL, replaces the domain with the
source domain you entered here, and uses the result as the download source. For
that to work, the source server's files must be reachable from your environment
over **HTTP or HTTPS**.

## Run the sync

With the source set, click the **sync** button. The module walks the file URLs
from your database and fetches the corresponding files from the source into your
local (public/managed) file system, so your environment mirrors the source site's
files. This is exactly the step that fills in the media and document files that a
database-only clone is missing.

## Things to keep in mind

- **Credentials and channel.** If the source requires credentials to reach its
  files, store them securely and connect to a **trusted source over an encrypted
  (HTTPS) channel**.
- **Treat imported files as external content.** The files come from another
  system, so apply your normal file hygiene and avoid syncing untrusted files
  into an environment where they could be served without sanitisation.
- **Run it as an admin.** Sync Files is an administration/devops tool with no
  access-control role of its own; keep it restricted to trusted, privileged
  users.
