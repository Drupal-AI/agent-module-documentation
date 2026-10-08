# Configuration

Exif Manipulate works automatically once enabled: it strips EXIF metadata from
images **as they are uploaded**, with nothing you need to configure. Everything on
this page is **optional** and concerns cleaning up images that were already on the
site before you turned the module on.

## The conversion form

New uploads are handled for you, but images uploaded *before* the module was
enabled still carry their original EXIF data. The conversion form lets you apply
the module's cleaning logic to those existing files retroactively.

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → Exif Manipulate**, or navigate directly to
   `/admin/config/media/exif_manipulate`.
3. Choose the file‑system location(s) you want the module to process, and run the
   conversion.

The module then walks the selected location and strips EXIF metadata from the
images it finds there, just as it would for a fresh upload.

> **Back up first.** Retroactive processing rewrites your existing image files in
> place. Before running the conversion across a real site, make sure you have a
> current backup of the affected files so you can recover if anything unexpected
> happens.

Remember that orientation metadata is intentionally preserved, so images continue
to display the right way up after conversion.
