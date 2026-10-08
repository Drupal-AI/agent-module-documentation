# Configuration

File Upload Options is configured from a single settings form, where you choose how
each file field should behave when an uploaded file collides with an existing one.

## Open the settings form

1. Log in as a user with the **Administer file upload options** permission.
2. Go to **Configuration → Media → File Upload Options**, or navigate directly to
   `/admin/config/media/file-upload-options`.

## Per-field, grouped by entity type

The form lists your file fields **grouped by entity type** (nodes, media, users,
and so on). For each field you can set what should happen when an uploaded file or
image has the **same name as an existing file**. The notable option is to **re-use
an existing file entity with the same URI** rather than create a new file and let
Drupal append a number (the `filename_1.pdf` behavior). Set each field to the
behavior that suits how that field is used.

Because the module alters the underlying file handling rather than the upload
widget, these settings take effect on your **existing** file fields and widgets —
you do not need to switch to a special widget for them to apply.

## Custom Fields — for fields defined in code

Fields that are **defined in code** (rather than through the Field UI) won't appear
automatically in the normal grouped list. To configure one, add its field name
under the **Custom Fields** section of the form.

Alternatively, non-entity fields are **added to Custom Fields automatically** the
first time you view a form that contains such a field. Once a field shows up there,
you can configure its same-name behavior just like any other field.

## REST uploads

The same handling applies to file uploads made over **REST**: you can specify how
existing files with the same name are treated, and choose to re-use an existing file
entity with the same URI rather than create a new one. No separate REST screen is
needed — the per-field settings you configure here govern REST uploads too.

## A note on security

Upload options are upload security. Keep in mind that Drupal enforces the
**allowed-extension** list (not a file's claimed MIME type), so the extensions a
field accepts are the real control over what your site takes in. When you relax
upload behavior — especially per field or for less-trusted roles — treat it with the
same care as granting a permission, and make sure files still land in a destination
where core's protective `.htaccess` (which denies script execution in the public
files directory) applies.

## Save

Click **Save configuration** at the bottom of the form. Your changes apply to
subsequent uploads on the affected fields.
