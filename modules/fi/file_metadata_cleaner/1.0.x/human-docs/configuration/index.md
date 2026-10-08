# Configuration

File Metadata Cleaner is configured on a global settings form, plus a page per
file-type processor. There is also a per-file action for cleaning existing files
on demand.

## Global settings

Go to **Configuration → Media → File Metadata Cleaner**
(`/admin/config/media/file-metadata-cleaner`). The key choice here is:

- **Clean metadata automatically on upload** — when enabled, every uploaded file
  of a supported type has its metadata stripped the moment it is uploaded. Turn it
  off if you prefer to clean files manually.

Accessing this form requires the **edit file metadata cleaner settings**
permission.

## Processors

Metadata handling is delegated to file-type **processors** (a plugin system).
Three ship in the box — **JPEG**, **JPG**, and **PDF** — and each declares the
MIME types it supports.

- **Processor overview** —
  `/admin/config/media/file-metadata-cleaner/processors` lists the discovered
  processors so you can see which file types are covered.
- **Per-processor settings** —
  `/admin/config/media/file-metadata-cleaner/processor/{plugin}` lets you tune an
  individual processor. Each can strip everything, or strip everything *except* a
  set of tags you tell it to keep — so, for example, you can remove GPS and author
  data from JPEGs while preserving colour-profile tags, and configure the PDF
  processor's behaviour independently.

Under the hood, stripping runs `exiftool -overwrite_original -all=` (plus any
"keep" arguments the processor configures) through Symfony's Process with an
argument array, so there is no shell-injection surface.

## Cleaning an existing file manually

To clean a file that is already on the site:

1. Open the file's metadata page at
   `/admin/content/files/metadata/{file}` (reachable via the files overview). It
   shows the current metadata table and the file's `metadata_cleaned` status.
2. Use the **Clean Metadata** action, which takes you to a confirmation form at
   `/admin/content/files/metadata/{file}/clean`.
3. Confirm, then re-open the metadata page to verify the metadata was removed.

## Permissions

Grant these on **People → Permissions**:

| Permission | What it allows |
|------------|----------------|
| `edit file metadata cleaner settings` | Access the settings and per-processor configuration pages. |
| core `access files overview` | Required (in addition to the above) to reach the per-file read/clean pages. |

The per-file read/clean pages also apply a custom access check that only grants
access when a processor plugin actually supports the file's MIME type, so the
clean action never appears for file types the module cannot handle.

## Extending it

Developers can add support for a new file format by implementing a `@FileProcessor`
plugin (extending `FileProcessorBase`), declaring the MIME types it supports, and
reusing the module's ExifTool service — no change to the core module required.
