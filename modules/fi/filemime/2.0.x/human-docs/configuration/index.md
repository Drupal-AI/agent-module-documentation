# Configuration

File MIME's settings let you adjust the mapping Drupal uses to turn a file's
extension into a MIME type. You can seed the mapping from the server's own
`mime.types` file, add or override individual mappings by hand, and apply your
changes retroactively to files that were already uploaded.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Media → File MIME**, or navigate directly to
   `/admin/config/media/filemime`.

## The mapping settings

The form gives you two complementary ways to change the mapping, plus a retroactive
option:

- **Extract from the server's `mime.types`** — pull the MIME‑type mapping from the
  server's `mime.types` file so Drupal benefits from the fuller, more current list
  the operating system already ships. Use this to catch modern formats core's
  built‑in list misses.
- **Custom mapping (text field)** — enter your own extension‑to‑MIME mappings to
  add types the server list doesn't cover, or to override a specific type. This is
  where you'd, for example, serve `.flac` files as `audio/flac` rather than
  `application/x-flac`, or force a PDF to display rather than download by making
  sure it is recorded as `application/pdf`.
- **Apply retroactively to existing files** — when you turn this on, saving the
  form re‑applies the new mapping to files that were **already uploaded**, not just
  future uploads. Use it to fix the recorded type on content that predates your
  change (for example after a migration left files as `application/octet-stream`).

## Save

Click **Save configuration**. New uploads immediately use the updated mapping; if
you chose the retroactive option, previously uploaded files are updated too.

## A note on safe mappings

Remember that the MIME type is only a **label** — it becomes the `Content-Type`
header on download, but it does not verify the file's actual contents. Keep your
real upload safety in the file field's **allowed extensions** and size limits, and
avoid mapping an unexpected or risky extension to a permissive type, since that can
let one kind of file slip past a check meant for another. Use File MIME to correct
honest mismatches (fonts, video, modern image formats, office documents), not to
loosen upload validation.
