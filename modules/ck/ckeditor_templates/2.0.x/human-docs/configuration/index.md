# Configuration

Setting up CKEditor Templates is a two-step job: **create the templates** in the
admin UI, then **add the Templates button** to the CKEditor 5 toolbar for each
text format where editors should see them.

## Step 1 — Create a template

Go to **Configuration → Content authoring → CKEditor Templates**
(`/admin/config/content/ckeditor-templates`) and click **Add template**. Each
template has these fields:

- **Label** — the name shown in the template dialog (and used to build the
  machine id).
- **Description** — a short sub-line in the dialog explaining what the template
  is for.
- **Thumbnail** — upload an image so editors can pick templates visually. If you
  would rather point at an existing file, use the alternative image path field
  to give a path or URL (for example a theme-hosted icon) instead of uploading.
- **Template HTML** — the actual markup that gets inserted, edited through a
  text-format-aware field. Note that this HTML is still subject to the target
  format's filters and allowed tags, so a restrictive format may strip parts of
  it.
- **Text formats** — check the text format(s) this template should be offered on.
  A template only appears in the dialog for a format listed here. (Only formats
  that use the CKEditor 5 editor are relevant.)
- **Enabled** — untick to temporarily retire a template without deleting it;
  disabled templates never appear in the dialog.
- **Weight** — controls the order templates appear in the dialog; lower weights
  come first.

Save the template. Repeat for each snippet you want to offer. Back on the
collection page you can reorder, edit, disable or delete templates at any time.

Because templates are configuration, you can export them and deploy them between
environments alongside your other config.

## Step 2 — Add the Templates button to a text format

The button does not appear until you add it to a CKEditor 5 toolbar:

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** a format that uses CKEditor 5 (for example *Full HTML*).
3. In the toolbar configuration, drag the **Templates** button from the
   available buttons into the active toolbar.
4. Save the format.

### The "Replace actual contents" default

When the Templates button is on a format's toolbar, that format gains one
setting: whether the dialog's **Replace actual contents** checkbox starts
ticked. Leave it unticked (the default) so inserting a template *adds* to the
existing content; tick it for a format where editors typically start a page from
a template, so choosing one replaces whatever is in the editor.

## What editors see

In a format with the button, an editor clicks **Templates** and a dialog opens
listing every enabled template whose text formats include the current format,
each shown with its thumbnail, label and description. They pick one and its HTML
is inserted — or replaces the current content if the "Replace actual contents"
box is ticked. If no template targets the current format, the dialog shows a
"There is no template available for this text format" message.

## Notes

- Upgrading a site from CKEditor 4 does **not** migrate old templates. Only the
  button and the replace-content setting are carried over; you recreate the
  templates themselves as described above.
- Managing templates and using them are separate permissions — see
  [Installation](../installation/index.md).
