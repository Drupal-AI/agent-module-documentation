# Configuration

Decorative Image has no central settings page. You switch it on **per image
field**, and it then adds a checkbox to that field's upload widget for editors.

## Enable it on an image field

1. Go to the image field's **Edit field** form — for example **Structure → Content
   types → *(your type)* → Manage fields**, click the image field, then **Edit
   field settings** (Media image fields work the same way). The path looks like
   `admin/structure/types/manage/<bundle>/fields/<field>`.
2. Just after the core **Alt field required** option you'll find two new settings:

   - **Enable the Decorative field** — turns on the per-image decorative checkbox
     in the widget for this field.
   - **Require Alt or Decorative** — when set, an image can't be saved with a file
     uploaded but *both* alt text and the decorative flag empty. This is only
     meaningful when the decorative option above is enabled **and** core's own
     *Alt field required* is off (otherwise core already forces alt text).

3. Save the field.

## What editors see

Once you've enabled the decorative option, each image in the upload widget gains a
checkbox (labeled around "Descriptive image (not decorative)"). Editors leave it as
appropriate for meaningful images and tick the decorative state for
presentation-only ones.

If you turned on **Require Alt or Decorative**, uploading an image without either
alt text or the decorative flag produces a validation error: *"Alternative text or
the decorative option is required."* The check is smart about AJAX — it won't
falsely fire while an upload or remove button is mid-request.

## How it renders

When an image is marked decorative, on display the module outputs it with an
**empty `alt`** and **`role="presentation"`**, so assistive technology skips it.
Meaningful (informative) images keep their real alt text as normal. The net effect
is cleaner screen-reader output on image-heavy pages and better automated
accessibility scores, with no custom theme code.

## Where the flag is stored (worth knowing)

The decorative boolean is **not** stored on the image field value itself. On save,
the module writes it to Drupal's **key-value store** (a collection named
`decorative_images`), keyed by the image's **file id**, and only for **node** and
**media** entities. Two consequences follow:

- Because the flag is keyed by file id, the **same file reused elsewhere shares the
  decorative state**.
- The flag is **not** part of your field configuration or content exports — it
  lives in the site's key-value store, so it won't travel with a config export.

## Custom or responsive image pipelines

The automatic empty-alt / presentation-role handling covers standard image
rendering. If you use a custom image template or a responsive-image pipeline that
bypasses the normal image preprocess, replicate the same behavior in your own
`template_preprocess_image` override (set `role="presentation"` and blank the `alt`
for flagged images) — see the sibling `agent/` docs for exactly which preprocess
steps to mirror.
