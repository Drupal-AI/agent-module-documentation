# Configuration

Image Crop Widget has no global settings page. You turn it on per image field from
the entity's **Manage form display** tab, then set one option.

## Turn the widget on for a field

1. Go to **Manage form display** for the bundle that has the image field — for
   example **Structure → Content types → Article → Manage form display**
   (`/admin/structure/types/manage/article/form-display`), or a Media type's form
   display.
2. Find your **Image** field and change its **Widget** to **Imager Widget**.
3. Click the gear/cog to open the widget settings, choose the **Type of update
   image** option (below), then click **Update** and **Save**.

Because the widget extends core's standard image widget, all the usual image‑widget
settings (such as the preview image style) are still available — Image Crop Widget
just adds the one extra option.

## The one setting — Type of update image

This controls what happens to the file when an author saves an edit:

- **Replace existing image** — the edited image is written over the original
  file's location. The file keeps the same ID and filename, so every existing
  reference to it keeps working, and the module clears the old image‑style
  derivatives (including their `.webp` versions) so they regenerate from the edited
  image. Choose this when you want the edit to apply everywhere the image is
  already used.
- **Create new image** — the edited image is saved as a brand‑new file (in the
  public files directory, renamed if a file of that name already exists) and the
  field is repointed to the new file. The original file is left untouched. Choose
  this when you want to keep the original.

> **Note on defaults:** internally the widget's default is *Create new image*, but
> the settings form falls back to *Replace existing image* if the option has never
> been set. To avoid ambiguity, pick the option explicitly and save.

## How editing works for authors (good to know)

Once a file is uploaded on the edit form, the widget shows a **Start Editing**
button. Clicking it opens the ImagerJS editor over the preview with Rotate, Crop,
Resize, Undo, and Save tools (touch‑friendly on tablets). When the author clicks
ImagerJS's save icon, the edited image is captured and a reminder prompts them to
also save the Drupal form. On form submit, the image is written back according to
the **Type of update image** setting above. If the author never edits, the original
upload is kept unchanged.
