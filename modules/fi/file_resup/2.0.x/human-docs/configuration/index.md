# Configuration

File Resumable Upload is configured in two places: a small **global settings page** that
applies site-wide, and a **per-field section** where you actually switch resumable upload on
for each file field. There's also a chunk-size option that has no form (you set it with
Drush), and a permission that controls who can reach the global form.

## Who can change the settings

The global settings form is gated by the **Administer file resup** permission
(`administer file resup`), which is marked as a restricted (security-sensitive) permission.
Grant it at **People → Permissions** only to trusted administrators. Note this permission
controls the *settings form* — it does not, by itself, decide who may upload files; that is
governed by the normal content/field permissions on whatever form the field lives on.

## Enable resumable upload on a field (per-field settings)

This is the step that actually turns the feature on. Resumable upload does nothing until it
is enabled on a specific **file field**.

1. Go to the file field's settings/edit form — for example **Structure → Content types →
   [type] → Manage fields → [your file field] → Edit**, or the equivalent for a media type.
2. Find the **Resumable Upload Settings** section and configure:

   - **Enable resumable upload** — the master switch. When ticked, the module layers its
     chunked uploader onto whatever file widget the field already uses. When unticked, the
     field behaves like a normal Drupal file field.
   - **Maximum upload size** — an optional per-field cap, written as a size such as `512`,
     `80 KB`, or `2 GB`. This only *raises* the effective limit when it's larger than the
     field's existing file-size limit — it's how you allow uploads bigger than the site's
     PHP limits. Leave it blank to use the field's normal limit.
   - **Start upload on files added** — when ticked, uploading begins as soon as files are
     dropped or selected, with no separate "Upload" click.

3. Save the field.

You do **not** need to change anything on *Manage form display*; the module attaches itself
to the field's existing widget automatically once *Enable resumable upload* is on.

## Global settings page

Open **Configuration → System → File Resup settings**
(`/admin/config/system/file-resup-settings`). It has one option:

- **Prevent Duplicates** — when enabled, after a file finishes uploading its tracking record
  keeps a reference to the resulting file. If the same file (same generated upload id) is
  uploaded again, the module reuses the existing file instead of re-uploading it. When
  disabled, the tracking record is simply cleaned up after each successful upload.

You can also set this from Drush:

```bash
drush cset file_resup.settings prevent_duplicates 1 -y
```

## Chunk size (advanced, no UI)

Files are sent in fixed-size chunks — **2 MB by default**. There is no form field for this;
if you need a different chunk size (for example smaller chunks on flaky networks, or larger
chunks on fast connections), set it with Drush on the `file_resup` config object:

```bash
drush cset file_resup default_chunk_size 5242880 -y   # 5 MB chunks
```

The value is in bytes (5 MB = 5 × 1024 × 1024 = 5242880). Note this lives on the
`file_resup` config object, not `file_resup.settings`, and has no shipped default — the code
falls back to 2 MB when it isn't set.

## Where in-progress uploads are stored

While an upload is underway, its chunks are written to a private temporary directory
(`file_resup_temporary`) under the field's storage scheme, protected by an automatically
written `.htaccess` deny rule. The file only becomes a real, validated file entity when the
actual content form is submitted — at which point core's file validators run again and any
risky executable extension is neutralized (renamed with a `.txt` suffix), mirroring Drupal
core's own upload protections.
