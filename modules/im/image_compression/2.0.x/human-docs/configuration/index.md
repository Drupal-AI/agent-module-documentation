# Configuration

Image Compression is driven by a small table of rules that say how hard to compress
an image based on how large it is, plus a toggle for when compression happens on
upload. A separate batch tool lets you apply the same rules to images already on the
site.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Image compression**, or navigate directly to
   `/admin/config/user-interface/image_compression`.

## Size and compression-rate rules

The heart of the form is a table where each row pairs a **file size** (in **bytes**)
with a **compression rate**:

- **File size (bytes)** — the threshold at or above which the rule applies. Sizes are
  given in bytes, so for "images larger than 100 KB" you enter `100000`.
- **Compression rate** — how aggressively matching images are re-encoded. A higher
  compression rate means a smaller file and lower visual quality.

You can add multiple rows to compress larger files more aggressively than smaller
ones — for example, a gentle rate for medium images and a stronger rate for very
large ones. Use the form's **Add** control to create additional rows and the Ajax
**Remove** button to delete a row.

## Compress before upload

The form includes a **"compress before upload"** toggle. When it is on, images are
compressed by an upload validator **before** Drupal's file-size validation runs — so
a large image can be shrunk in time to pass a field's maximum-size limit. When it is
off, compression runs through the normal file-validation step on upload.

## Save

Click **Save configuration**. From then on, images uploaded through image fields are
compressed according to your rules.

## Bulk-compress existing images

To apply your rules to images that are **already** on the site, use the batch tool at
**Configuration → Compress Existing images**
(`/admin/config/user-interface/compress_existing_images`). It scans
`sites/default/files` for `*.jpg`, `*.jpeg`, and `*.png` files and compresses the
matching managed files, updating their recorded sizes afterward.

> **This is irreversible.** Bulk compression rewrites the original files in place,
> re-encoding them at the configured quality — there is no undo, and quality lost to
> compression cannot be recovered. Take a backup of your files directory before
> running it, and consider trying it on a copy of the site first.
