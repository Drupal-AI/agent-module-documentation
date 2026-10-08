# Configuration

Image WebP Converter is configured at **Configuration → Media → Image WebP
Converter Settings** (`/admin/config/media/image-webp-converter`). The same page
holds the settings and the button to start a site‑wide conversion.

> **Back up your database before running a site‑wide conversion.** The module
> rewrites source files and the references pointing at them, and the change is
> **not reversible**. Test on a copy first.

## Open the settings form

1. Log in as a user with the module's administrative permission.
2. Go to **Configuration → Media → Image WebP Converter Settings**
   (`/admin/config/media/image-webp-converter`).

## Settings, field by field

- **Converter selection** — choose the conversion tool the module should use:
  **cwebp** (the WebP command‑line binary), **Imagick**, or **GD**. Pick one your
  server actually supports; cwebp generally gives the best results when it's
  available.
- **Image quality** — a value from **0 to 100** that balances file size against
  visual clarity. Lower values compress harder (smaller files, more artefacts);
  higher values preserve detail at the cost of size.
- **Lossless conversion** — enable this if you want WebP output with no quality
  loss (larger files, exact fidelity). Leave it off for the usual lossy,
  size‑saving conversion.
- **Per‑node checkbox** — when enabled, content editors get a **Convert images to
  WebP** checkbox on the node add/edit form, so conversion can be decided per node
  rather than applied to everything automatically.

Click **Save configuration** when you're done.

## Run a site‑wide conversion

After choosing your converter settings, use the **Start Conversion** button on the
same page (`/admin/config/media/image-webp-converter`). The module processes your
existing images in batches, converting them to WebP and updating the references.

## Per‑node conversion (optional)

If you enabled the per‑node checkbox above, editors will see a **Convert images to
WebP** option on the node form. Ensure it's checked on a node to apply conversion
to that node's images.

## Automatic conversion on upload

With the module configured, newly uploaded images are converted to WebP
automatically according to your settings, including inline images embedded in
CKEditor fields.

## Verify the result

Upload an image (or run a conversion), then confirm the WebP file exists in your
files directory (for example under `public://`), and that pages reference the
`.webp` version. The module also logs conversion status, which helps with
troubleshooting.
