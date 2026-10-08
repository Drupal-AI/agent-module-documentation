# Configuration

File Inspector has two screens — a **settings** page that controls what the scan
looks at, and a **report** that shows the results — plus a carefully separated set
of three permissions.

## Scan settings

Go to **Configuration → Media → File Inspector**
(`/admin/config/media/file-inspector`), which requires the **Administer file
inspector** permission. Here you tell the scan which parts of the file system to
consider:

- **Excluded folders** — directories the scan should skip because they are
  legitimately outside Drupal's model.
- **Excluded MIME types** — file types you don't want reported.
- **Stream wrappers** — which stream wrapper(s) the scan walks (for example
  `public://`, `private://`).
- **Embedded web folders** — folders that hold embedded web apps such as
  flipbooks or microsites. When you declare one, File Inspector records only the
  entry file and ignores the supporting assets, keeping them out of your deletion
  candidates.

## Running the scan and reading the report

The report at **Reports → File Inspector** (`/admin/reports/file-inspector`)
runs the two-phase inspection (walk the file system, then classify each file as
managed or unmanaged against `file_managed`) as a batch job, so it copes with very
large file systems. Results are stored in a dedicated table for fast, scalable
querying and full Views integration, which means the report supports status,
MIME-type, and date filters, per-row actions, and bulk operations.

From the report you can:

- **Inspect** a file before doing anything with it;
- **Import** an unmanaged file into the Media library in one click (this creates a
  managed File plus a Media entity, and the row links to the Media item it
  produced so the import is traceable — requires core Media); and
- **Delete** an orphaned file permanently, through a confirmation form with path
  validation.

## Permissions — three separated levels of trust

Grant these on **People → Permissions**. They are deliberately kept apart, and
that separation is the point:

| Permission | What it allows |
|------------|----------------|
| `view file inspector` | See the report. |
| `import unmanaged files` | Bring an unmanaged file into the Media library. |
| `administer file inspector` | Configure the scan (excluded folders, MIME types, stream wrappers). Marked restrict access. |

Two cautions when deciding who gets `view file inspector`:

- The report is essentially a **directory listing of the site's file system,
  including private files**. Knowing a file exists at a path is often most of the
  way to reading it — for `public://` it is all of the way — so grant viewing only
  to trusted administrators.
- **Deletion here is irreversible.** A file Drupal never tracked has no revision,
  no unpublish, and no reference explaining its purpose. Scan and inspect first,
  and treat any bulk delete as a backup-first operation.
