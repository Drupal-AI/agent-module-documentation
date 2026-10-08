Flysystem GCS registers Google Cloud Storage as a Flysystem adapter, so a GCS bucket becomes a Drupal `gcs://` stream wrapper usable as the default file system or per file/image field.

---

The module is the adapter half of a Flysystem setup: it declares an `@Adapter(id = "gcs")` plugin (`Drupal\flysystem_gcs\Flysystem\GoogleCloudStorage`) that builds a `Google\Cloud\Storage\StorageClient`, selects a bucket, and wraps them in `GoogleCloudStorageAdapter` (a subclass of `superbalist/flysystem-google-storage`'s `GoogleStorageAdapter`). Once the Flysystem module has that plugin, Drupal treats the remote bucket like any other scheme — `gcs://` behaves as `public://` does, and image styles, file fields, and media all work through the same core file APIs. There is no admin form: configuration lives entirely in `settings.php` under Flysystem's own `$settings['flysystem']` array, where each scheme names `driver: gcs` plus a `config` block (bucket, projectId, keyFilePath, requestTimeout) and optional `_localConfig` (path `prefix`, CNAME `uri`) and `cache`. Choosing GCS is usually a scaling or portability decision: ephemeral container disks, multiple web nodes that must share one files store, or a policy that uploads live in object storage. You can adopt it site-wide as the default scheme or selectively per field, which is the safer way to start.

The plugin's `getExternalUrl()` decides how each file is served: an object whose GCS visibility is public is linked directly at its bucket URL (optionally rewritten to a CNAME via `_localConfig.uri`), while anything not public is served back through Drupal's own Flysystem download route. Image-style derivatives under `styles/` are generated on demand before the URL is returned. The release is **8.x-1.0-beta3** with a `^8 || ^9 || ^10 || ^11` core range — a statement of intent rather than proof of Drupal 11 testing — so verify uploads, image derivative generation, and private-file handling on a copy of the site before switching production.

---

- Store user uploads in a Google Cloud Storage bucket instead of local disk.
- Use GCS as the site's default download method for the File system.
- Point a single image or file field at a `gcs://` scheme while others stay local.
- Serve one shared files store across several web nodes / autoscaled instances.
- Keep uploaded files out of an ephemeral container filesystem.
- Migrate an existing `sites/default/files` directory into object storage.
- Generate and store image-style derivatives against a remote bucket.
- Back media entities with GCS-hosted source files.
- Reduce a site's local disk footprint and backup size.
- Satisfy a compliance policy that user content must live in cloud storage.
- Configure the whole adapter from `settings.php` with no exportable config.
- Supply the GCS service-account key path from an environment variable read with `getenv()`.
- Front the public bucket with a CDN by setting a custom CNAME `uri` in `_localConfig`.
- Namespace all objects under a sub-path with the `_localConfig.prefix` option.
- Cache remote filesystem metadata by setting `cache: true` on the scheme.
- Tune the GCS API timeout per scheme with `requestTimeout`.
- Run separate buckets per environment (dev/stage/prod) by varying the scheme config.
- Keep private files private by letting non-public objects route through Drupal's download controller.
- Verify image derivatives and private-file delivery on a staging copy before production cutover.
- Roll back to local storage by pointing the field or File system scheme back at `public://`.
