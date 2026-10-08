# Configuration

Config Default Image has no settings page of its own. You configure it **per
field**, in the formatter settings on an entity's **Manage display** tab. The
goal is to point the formatter at an image that lives in your code repository, so
the default image and its configuration deploy together.

## Set it up on Manage display

1. Commit a web-friendly image into a git-tracked directory — typically inside a
   custom module or theme, e.g. `modules/custom/my_module/images/default.png` or
   `themes/custom/my_theme/img/default.jpg`.
2. Go to the entity's **Manage display** (for example
   **Structure → Content types → Article → Manage display**,
   `/admin/structure/types/manage/article/display`).
3. For the image field, set the **Format** to **Image or default image** (or the
   responsive/SVG equivalent if you enabled a submodule).
4. Click the settings **gear** for that field and fill in the **Default image**
   details described below.
5. Make sure the field's *own* field-level default image (under **Manage fields**)
   is left **unset** — you want this formatter to supply the fallback.
6. Click **Update**, then **Save**.
7. Export configuration (`drush cex`) and commit **both** the changed display
   config and the image asset to version control, so they deploy as a pair.

## Formatter settings, field by field

The formatter shows the normal core image-formatter options (image style, link)
plus a **Default image** group. The default-image fields are:

- **Path** *(required)* — the location of the fallback image, written as a path
  relative to the Drupal root, e.g. `themes/custom/my_theme/img/default.jpg`. A
  stream URI such as `public://defaults/default.jpg` is also accepted. This is the
  key setting: because it is stored as text in config, it survives export/import
  across environments. Point it at the repo-committed asset from step 1.
- **Use image style** — when ticked, the formatter's selected image style is
  applied to the default image just as it would be to a real upload, so the
  fallback matches the dimensions of normal images. (See the technical note
  below about how this works.)
- **Alt** — the alternative text used on the fallback image, important for
  accessibility.
- **Title** — the title attribute (shown as a tooltip on hover).

The formatter also stores **width** and **height** values internally; these are
recorded automatically rather than typed in by hand.

## How the fallback behaves

- The default image is only used when the field is **empty**. If the field has a
  real uploaded image, that image renders as usual and the default is ignored.
- When it does kick in, the module builds a temporary, unsaved file from your
  **Path** and hands it to the normal image renderer — so regular, responsive, and
  SVG output all "just work".
- **Image style + a plain (schemeless) path:** Drupal image styles need a stream
  wrapper, so when **Use image style** is on and your path has no scheme (like
  `themes/custom/…`), the module copies the file once into
  `public://config_default_image/…` and generates the style derivative from that
  copy. If **Use image style** is off, the raw path is rendered as-is with no
  style applied.

## Keep it in version control

The whole point of this module is deployability: keep the image file in your repo
next to the config that references it, and treat the **Path** as a stable,
code-managed location. That way the default image is identical on dev, staging,
and production, and any change to it goes through the same review and rollback
process as the rest of your configuration.
