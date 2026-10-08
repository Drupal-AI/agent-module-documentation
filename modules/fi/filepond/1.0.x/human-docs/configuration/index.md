# Configuration

FilePond works immediately after enabling, so this page is about tuning it: a global
settings form for site‑wide defaults, and per‑field setup where you actually attach
the uploader.

## Global settings

1. Log in as a user with the **Administer site configuration** permission.
2. Go to **Configuration → Media → FilePond**, or navigate directly to
   `/admin/config/media/filepond`.

This form holds the **global defaults** for the uploader, which individual widgets
can then override. The settings you're most likely to touch:

- **Load libraries from CDN** — on by default, which is what lets FilePond work with
  no library installation. Turn it **off** if you want to serve the FilePond
  JavaScript and plugins yourself; then install them locally as described in
  [Installation](../installation/index.md#choosing-cdn-or-self-hosted-libraries).
- **Media Library integration** — optionally replace core's Media Library upload
  widget with FilePond, so the drag‑and‑drop experience appears wherever the Media
  Library is used.
- **Uploader defaults** — the form exposes global defaults controlling many aspects
  of the uploader (previews, chunked uploads, and similar behaviour). These act as
  the baseline; individual field widgets can override them per element.

Click **Save configuration** when done.

## Applying FilePond to a field

The global form sets defaults, but you turn FilePond on for real content on a
bundle's display:

1. Go to **Structure → Content types (or any fieldable entity) → *(bundle)* →
   Manage form display**.
2. For an image or file field, set the **Widget** to the **FilePond** widget.
3. Use the widget's settings (the gear icon) to override the global defaults for
   just that field where needed.
4. Save the form display.

If you enabled the **Crop** submodule, a cropping image widget is available for
single‑value image fields; the **Entity Browser** submodule adds a widget for
creating Media entities via Entity Browser.

## Keep uploads safe

FilePond's client‑side validation (allowed types, size) is a convenience for the
user, **not** a security control. The real protection stays where core puts it, so:

- Set the field's **Allowed file extensions** to only what you need — never permit
  executable or script types.
- Enforce sensible **maximum upload sizes**.
- Store sensitive or non‑public files in the **private** file system.
- Grant FilePond's upload permissions only to trusted roles.
