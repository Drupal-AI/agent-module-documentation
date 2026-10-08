# Configuration

Text File Viewer has two parts to set up: a module-wide configuration page (where
the Prism library and enabled extensions are set) and the per-field formatter
choice on the display of the field you want to render.

## Module configuration

Open the **Text File Formatter Configurations** page in the Drupal admin
interface. Here you control:

- **External Library Location Setting** — whether Prism.js is loaded from an
  **external** source or from a **local** copy. Choose **Local** if you prefer to
  self-host the library rather than pull it from an external URL.
- **Enabled file extensions** — the file extensions for which syntax
  highlighting is turned on. Restrict this list to the extensions you actually
  want highlighted on your site.

### Using a local Prism library

If you select the local option:

1. Download the required JavaScript and CSS from the Prism.js site, selecting the
   file extensions you want syntax highlighting for.
2. Move the downloaded `prism.js` and `prism.css` files into the module's
   `libraries/` directory.
3. On the module configuration page, set **External Library Location** to
   **Local**.
4. Restrict the file extensions in the module configuration to match the
   extensions you selected when downloading Prism, so the highlighting and the
   library stay in step.

## Apply the formatter to a field

1. Go to the **Manage display** screen for the content type (or other entity)
   whose file field you want to render.
2. For that file field, choose the **Text File Viewer** formatter.
3. Adjust the formatter's display options to control formatting and appearance,
   then save.

When the entity is viewed, the file's contents are shown inline with syntax
highlighting for the extensions you enabled. Because the formatter works from the
managed file's URI, it respects the access control already applied to the field.
