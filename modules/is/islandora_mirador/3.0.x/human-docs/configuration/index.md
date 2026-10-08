# Configuration

All of Islandora Mirador's settings are on one form.

## Open the settings form

Go to **Configuration → Media → Mirador** (`/admin/config/media/mirador`). Access is
gated by core's **Administer site configuration** permission — the module adds no
permission of its own. Settings are stored in `islandora_mirador.settings`.

## The settings, field by field

| Setting | Default | What it does |
|---|---|---|
| **Library installation type** | `remote` | `remote` loads the compiled Mirador build from a jsDelivr CDN; `local` loads it from `/libraries/mirador/dist/main.js` in your webroot (which you must place yourself). |
| **Library minified** | off | Only used with `local` — marks your local build as minified so it loads correctly. |
| **Language support** | off | When on, the viewer UI uses the current interface language; adds a per-language cache context. |
| **Enabled plugins** | Image Tools + Text Overlay | Which Mirador plugins' window config to switch on (see below). |
| **Selected theme** | `light` | `light`, `dark`, or `system` (`system` follows the visitor's OS preference in the browser). |
| **Light theme primary / secondary color** | `#1967d2` / `#1967d2` | The light theme's primary and secondary palette colors (hex). |
| **Dark theme primary / secondary color** | `#4db6ac` / `#4db6ac` | The dark theme's palette colors (hex). |
| **IIIF manifest URL** | `[node:url:unaliased:absolute]/manifest` | A node-token pattern for the manifest URL Mirador loads. Required, max 256 characters. |

### Notes on specific settings

- **Manifest URL** — it is validated as a token pattern (node tokens only). For
  paged content / books, point it at a `.../book-manifest` view path instead of the
  default single-item manifest.
- **Theme and colors** — only `light`, `dark`, or `system` are accepted; colors
  must be valid 3- or 6-digit hex values.
- **Local library** — switching to `local` means you supply the compiled build
  yourself (the output of `npm run webpack` of `mirador-integration-islandora`) at
  the webroot path `libraries/mirador/dist/main.js`.
- **Enabled plugins** — the checkboxes only flip flags in Mirador's `window`
  configuration. The plugin code itself must already be compiled into the Mirador
  build you are serving. Two plugins ship:
  - **Mirador Image Tools** — enables the brightness/contrast/invert image tools.
  - **Text Overlay** — makes OCR'd (hOCR) text selectable and accessible to screen
    readers.

## Configuring with Drush (optional)

```bash
ddev drush config:set islandora_mirador.settings mirador_selected_theme dark -y
ddev drush config:set islandora_mirador.settings mirador_library_installation_type local -y
ddev drush config:get islandora_mirador.settings
```

## Placing the viewer

The settings above control *how* the viewer looks and loads; you still place it in
one of two ways:

- **As a block** — place the **Mirador** block through **Block layout**
  (`/admin/structure/block`), or trigger it with Islandora Contexts keyed on the
  **Mirador** display-hint term (imported via the `islandora_mirador_tags`
  migration — see [Installation](../installation/index.md)). The block has its own
  `iiif_manifest_url` token field so you can override the manifest per placement.
- **As a field formatter** — on an image or file field's **Manage display**, set
  the format to **Mirador** (`mirador_image`). For each file it finds the
  referencing Islandora media and its node, resolves the manifest URL from that
  node, and renders the viewer.

Themers can further adjust Mirador's window/workspace options with a
`hook_preprocess_mirador()` implementation — see the
[`agent/`](../agent/start.md) theming docs.
