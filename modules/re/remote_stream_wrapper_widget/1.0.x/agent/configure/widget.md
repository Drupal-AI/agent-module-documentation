# Configure the Remote Stream Wrapper widget

No global settings. You enable the widget per field on **Manage form display**.

## Attach it
1. Add or reuse a **File** or **Image** field on your entity/bundle.
2. Go to the bundle's *Manage form display* (`admin/structure/…/form-display`).
3. For that field, choose widget **Remote stream wrapper**.
4. Save. The field now shows a single URL textbox instead of an upload control.

The widget id is `remote_stream_wrapper`; it has no per-widget settings form.

## Behavior
- Renders `['#type' => 'url']`, `#required` mirroring the field's required flag; with
  cardinality 1 it also gets the field label + filtered description. Pre-fills with the
  existing file's `uri->value` when a value is already stored.
- On submit, `massageFormValues()`:
  1. skips empty rows;
  2. `loadByProperties(['uri' => $url])` on `file` storage — reuse if found;
  3. otherwise `create(['uri' => $url, 'uid' => currentUser])->save()` a new `file` entity;
  4. stores `['target_id' => $file->id()]` on the field.

## Requirements / caveats
- Requires the **Remote Stream Wrapper** module (`remote_stream_wrapper` ^2.1), which
  registers the `http`/`https` stream wrappers and does the actual byte fetching when the
  file is read (e.g. image-style derivative generation).
- No MIME type or file-extension validation is performed by this widget beyond the HTML `url`
  input type; use it on fields whose sources are trusted.
