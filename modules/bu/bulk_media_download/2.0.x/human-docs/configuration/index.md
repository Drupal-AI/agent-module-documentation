# Configuration

## Choose which media bundles to include

1. Log in as a user with the core **Administer site configuration** permission
   (an administrator).
2. Go to `/admin/config/bulk_media_download/settings` (route
   `bulk_media_download.settings`).
3. Select the media bundles that should be included in the archive, and save.

This settings form is the part of the module that works as designed.

## The download button — currently non-functional

The intended flow is that a **download button** is injected onto the admin media
list at `/admin/content/media`, and that clicking it (which reaches the endpoint
`/admin/config/bulk_media_download/button`, route `bulk_media_download.button`)
streams a ZIP of the configured bundles' files.

In the shipped 2.0.x code this does not work. The controller behind that endpoint
(`BulkDownloadController::downloadMedia()`) is a development stub that dumps debug
output and halts, so no archive is produced. The actual zipping routine — which
loads media of the configured bundles, resolves each bundle's file field, builds
the file URLs, and streams a ZIP with `ZipArchive` and `readfile()` — lives in a
procedural helper in the module's `.module` file but is not wired up to a working
route.

## What this means for you

- You can configure the bundle selection today, but you **cannot** get a working
  ZIP download from the module as shipped.
- Making it work requires a **code fix** to replace the stub controller with a
  call to the real zipping logic. Treat the module as incomplete until then.
- On the security side, the routes are admin-only and the file URLs are built
  from admin-configured bundles (not from request input), so this is a case of
  incomplete/buggy code rather than an exposed download.
