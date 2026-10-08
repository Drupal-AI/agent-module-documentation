# Configuration

FolderShare's configuration is spread across a permission set, a small settings
form, a usage report, and cron. The **permissions are the important part** —
they are what actually controls who can see, upload, and share files.

## 1. Permissions — the control surface

Go to **People → Permissions** (`/admin/people/permissions#foldershare`) and grant
these to roles deliberately:

- **`view foldershare`** — see files and folders (subject to sharing).
- **`author foldershare`** — create folders and upload files.
- **`share foldershare`** — share folder trees with specific other users.
- **`share public foldershare`** — make files world-readable. **This is a
  separate permission for a reason:** making a file public is a distinct
  capability, not something implied by ordinary sharing. Grant it only to roles
  you genuinely want to be able to expose files beyond the site's own users.
- **`administer foldershare`** — full administration, including the
  admin-only `/foldershare/all` view. Restrict this tightly.

The single most important operational decision is **which roles hold
`share public foldershare`**, because that permission is what can expose files
publicly.

## 2. Minimal settings form

Go to **Structure → FolderShare** (`/admin/structure/foldershare`). The essentials
here are:

- **Storage filesystem** — choose Drupal's **public** or **private** filesystem
  for uploaded files. **Private is recommended.** With private storage, shared
  files are served through FolderShare's own access checks rather than being
  directly fetchable by URL — which is what makes the sharing model actually
  enforceable. Confirm your site's private file path is configured
  (`file_private_path`).
- **Allowed file extensions** — optionally restrict which file types users may
  upload.
- **Usage-report rebuild interval** — how often the usage report is regenerated.

## 3. Usage report

**Reports → FolderShare** (`/admin/reports/foldershare`) shows a usage summary for
all site users. Its data is rebuilt on the interval you set above.

## 4. Cron

FolderShare queues long-running tasks and executes them at cron run, to stay within
PHP execution-time limits. **Run cron frequently from an external source** rather
than relying on Drupal core's built-in automated cron, so queued file operations
complete promptly.

## Things to double-check

- Public sharing is granted **deliberately** — audit which roles hold
  `share public foldershare`.
- File storage is set to **private** so shared files go through access checks.
- Administration (`administer foldershare`) is restricted to trusted roles.
- Remember the design constraints: folders exist only in the database (not as
  real directories on disk), files are stored under machine-generated names for
  security, and sharing is always set at the top-most folder level.
