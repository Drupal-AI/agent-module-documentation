# Configuration

Media Thumbnails Word has one setting: the path to the **mPDF** library it uses to
convert Word documents to PDF before rasterising the first page. Until this path is
set correctly, the module logs a warning and skips thumbnail generation.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default) — this is the permission that protects the form.
2. Go to **Configuration → Media → Media Thumbnails Word settings**, or navigate
   directly to `/admin/config/media/media-thumbnails-word-settings`.

## The mPDF library path

- **mPDF path** — enter the filesystem path to the directory where the mPDF library
  is installed (typically inside your project's `vendor` directory, wherever Composer
  placed mPDF). The form **validates that the path is an existing directory** on
  submit and refuses to save a path that does not exist, so if the form rejects your
  entry, double-check the exact directory location.

## Save

Click **Save configuration**. With a valid mPDF path in place, and the Imagick
extension and PhpWord/mPDF libraries installed, thumbnails will generate
automatically the next time a `.doc` or `.docx` file is added as media. If you have
existing Word media that predate this setup, regenerate their thumbnails through the
Media Thumbnails framework to pick up the previews.
