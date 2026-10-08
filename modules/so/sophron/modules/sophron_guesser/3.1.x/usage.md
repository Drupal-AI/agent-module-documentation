Sophron guesser swaps Drupal core's extension-based MIME type guesser for Sophron's much more complete FileEye/MimeMap-backed mapping, improving file type detection everywhere in the site.

---

Drupal core guesses a file's MIME type from its extension using a built-in, limited map. Sophron guesser (`sophron_guesser`) is a tiny submodule that, once enabled, transparently replaces core's `MimeTypeMapInterface` service with a Sophron-backed implementation via a service provider `alter()`. It has no configuration and no UI — enabling it is the entire action. From then on, every part of Drupal that guesses MIME types from filenames (file uploads, managed file storage, media handling, download headers) uses Sophron's richer, configurable map, including any custom mappings you added in the main Sophron settings. It depends on the main Sophron module for the map manager and factory. Use it whenever core mis-detects file types or when you need consistent, extended MIME detection across the whole platform.

---

- Improve MIME detection for uploaded files site-wide.
- Fix core mis-detecting modern image formats (AVIF, HEIC, WebP variants).
- Apply your custom Sophron map commands to core's file guessing.
- Serve correct Content-Type headers for downloaded managed files.
- Make media library type detection more accurate.
- Ensure file field validation uses the extended MIME map.
- Get consistent MIME guessing between custom code and core.
- Support less common or industry-specific file extensions in uploads.
- Replace the core guesser without writing any custom service provider.
- Enable richer MIME detection with zero configuration.
- Keep MIME handling consistent across a multisite install.
- Back antivirus/security checks with accurate extension-to-type mapping.
- Correct wrong types returned for office/document formats.
- Provide reliable types to image toolkits and derivative generation.
- Align remote/cloud storage uploads with correct MIME types.
