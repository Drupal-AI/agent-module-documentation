Sophron provides an extensive MIME type management API for Drupal, wrapping the FileEye/MimeMap PHP library to map file extensions to MIME types (and back) far more completely than Drupal core.

---

Sophron exposes a `MimeMapManager` service that answers questions like "what MIME type is this extension?", "what extensions belong to this type?", and lets you enumerate the full type/extension registry backed by the `fileeye/mimemap` library. It supports pluggable "maps": you can use MimeMap's default map, Drupal's core map, or a custom map class, and further tune the active map with a list of ordered commands (add/remove type-extension mappings) configured in the settings form at Admin → Configuration → System → Sophron. Map initialization fires a `MapEvent::INIT` event so other modules can programmatically extend or correct the mapping, and the module reports configuration gaps and errors through the status report. A JSON feed of all known MIME types is published at `/sophron/mime-types.json` for external consumers, gated by a dedicated permission. The optional `sophron_guesser` submodule replaces Drupal core's extension-based MIME type guesser with Sophron's, so uploads and file handling across the whole site benefit from the richer mapping. Sophron is primarily a developer/building-block dependency used by media, file, and image modules that need accurate MIME detection.

---

- Look up the MIME type for a file extension in custom code.
- Find all file extensions associated with a given MIME type.
- Replace Drupal core's limited MIME guesser site-wide (via sophron_guesser).
- Get accurate `image/*` types for less common formats (AVIF, HEIC, etc.).
- Enumerate every known MIME type and extension for a settings UI.
- Add a custom extension-to-type mapping through the settings form.
- Remove or override an incorrect default mapping with a map command.
- Switch between the MimeMap default map and the Drupal core map.
- Use a custom map class for a specialized deployment.
- Expose a JSON feed of MIME types to an external service.
- Restrict access to the MIME types JSON feed with a permission.
- Detect and report gaps between two map classes on the status report.
- Correct MIME mappings programmatically by subscribing to the map init event.
- Ensure uploaded files get the right type for validation and storage.
- Improve media library detection of file types.
- Provide correct Content-Type headers when serving managed files.
- Validate that an upload's extension matches its declared MIME type.
- Support antivirus/security modules that key off accurate MIME types.
- Feed correct MIME data to remote/cloud storage integrations.
- Standardize MIME handling across a multisite platform.
- Diagnose why core mis-detects a file type by comparing maps.
- Extend the mapping for proprietary or industry-specific file formats.
- Build a report of which extensions map to which types.
- Give image toolkits reliable format information.
