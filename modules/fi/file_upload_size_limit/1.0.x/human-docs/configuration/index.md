# Configuration

File Upload Size Limit (JS) works the moment you enable it: per-file size checks
happen in the browser using each file field's own maximum. The settings form is
only needed when you want to control the **total** size of a **multi-file** upload.

## Open the settings form

Log in as a user who can administer site configuration and open the module's
settings form (route `file_upload_size_limit.settings`), reachable from the
**Configuration** area — for example via the module's entry on the **Extend** page
(its *Configure* link) once it is enabled.

## Multi-file total-size limit

When a field accepts several files at once, you may want to cap the combined size of
everything a visitor tries to upload in one go — useful where a short server or
proxy timeout makes a very large batch likely to fail. The module offers three
options:

1. **Match the individual file limit** — the total allowed across all selected files
   equals the size configured for a single file.
2. **Set a total via this module's setting** — you specify an explicit maximum total
   size on this form, independent of the per-file limit.
3. **No total limit** *(default)* — only the per-file check applies; there is no cap
   on the combined size.

Choose the option that fits your fields and your server's tolerance for large
batches, then save.

## Remember: this is client-side only

Whatever you set here runs in the visitor's browser and is easily bypassed. It
improves the upload experience but does **not** enforce anything. The limits that
actually protect your site live elsewhere:

- each **file field's** maximum size (in the field's settings), and
- your PHP configuration — `upload_max_filesize` and `post_max_size`.

Keep those correct server-side; treat this module as the friendly warning layered on
top.

## Save

Click **Save configuration** to apply your changes.
