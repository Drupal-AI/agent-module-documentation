# Configuration

Media Upload needs configuration before the bulk upload form does anything useful:
you must tell it which media bundle each file type should be saved into, and set
the size limits. Until at least one file‑type bucket is mapped to a bundle, the
upload form has no allowed extensions and will reject everything.

## Open the settings form

1. Log in as a user with the **`administer media_upload configuration`**
   permission.
2. Go to **Configuration → Media → Media upload**, or navigate directly to
   `/admin/config/media/upload`.

## Map each file type to a media bundle

The form offers four buckets — **Image**, **Video**, **Document**, and **Audio** —
and each can be mapped independently (you only need to configure the ones you
actually upload). For each bucket you configure:

- **The media bundle** the uploaded files of that type should become (for example
  route images to your "Image" media type).
- **The file‑reference field** on that bundle that will hold the uploaded file.

From the field you pick, Media Upload automatically reads the **allowed file
extensions** and the **maximum file size**, and stores them read‑only into its own
settings. This is why the target field's configuration matters so much: the upload
form's accepted extensions are the union of the extensions configured on the fields
you map here.

> **Keep the mapped fields safe.** Because extension validation on upload relies
> entirely on the media field's allowed‑extensions list (there is no additional
> filename munging on the final write), make sure none of the mapped fields allow
> executable or markup extensions such as `php`, `phtml`, `html`, or `svg`.

## Size limits

The form also lets you set overall limits that apply on top of the per‑field
maximum:

- A **maximum size per file** — any single uploaded file larger than this is
  skipped (and reported), while the rest of the batch still imports.
- A **maximum total size** for one upload batch — the combined size of all files
  submitted at once.

Set these with your server's own upload limits in mind (PHP's `upload_max_filesize`
and `post_max_size`), since those apply first at the web‑server level.

## Save

Click **Save configuration**. The upload form at `/media/upload` will now accept
the extensions from your mapped fields and route each dropped file to the bundle
you chose. Test it by uploading a file of each type you configured and confirming
the resulting media entities land in the expected bundles.
