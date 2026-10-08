# Configuration

Editor File Upload is configured **per text format**, so you can give file-upload
capability to some formats (say, one used by trusted editors) while others go
without. Access to the button follows the text format's own **use** permission —
the module adds no permissions of its own.

## Add the File button and set the options

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`) and **edit** a **CKEditor 5**-based text
   format.
2. In the toolbar configurator, drag the **File** (paperclip) button from
   *Available buttons* into the *Active toolbar*.
3. Open the **File upload** vertical tab under **CKEditor 5 plugin settings** and
   set:
   - **Enable file uploads** — turn uploading on. The rest of the fields only
     appear once this is enabled.
   - **File storage** — the stream wrapper to store uploads in, such as `public` or
     `private`. This option only shows when more than one writable wrapper is
     available. Choose `private` when the files should be access-controlled.
   - **Upload directory** — the path (relative to the files directory) where
     uploaded files are placed.
   - **Allowed file extensions** — **required.** A space- or comma-separated list of
     extensions with no dots (for example `pdf docx xlsx`). Restricting this is what
     keeps unsafe file types from being uploaded.
   - **Maximum file size** — the size cap for uploads. Leave it blank to fall back
     to PHP's upload maximum.
4. Click **Save configuration**.

## A note on the "Limit allowed HTML tags" filter

If the format uses the **Limit allowed HTML tags** filter, make sure the `<a>` tag
is allowed to keep its `data-entity-type` and `data-entity-uuid` attributes — the
module needs them to track file usage and keep links valid. The plugin declares the
allowed element `<a href data-entity-uuid data-entity-type>`, so confirm your
filter does not strip those attributes.

## Good to know

- The upload dialog is served per format and gated by that format's use access, so
  only users who can use the format can upload through it.
- If you configure a remote/CDN stream wrapper, you can point uploads there via the
  **File storage** option.
- Settings from the old **CKEditor 4** file-upload equivalent are migrated
  automatically the first time you configure the format.
- Install the suggested **Editor Advanced Link** module if you want to add title,
  id, or class attributes to the inserted download link.
