# Configuration

File Uploader by Uppy is a **field widget**, so there is no central settings page —
you configure it per file field on that field's **Manage form display**.

## Set the Uppy widget on a file field

1. Go to **Structure → *(entity type)* → *(bundle)* → Manage form display** — for
   example a Media type, or a content type that has a file field.
2. Find your **file field** in the list.
3. In the **Widget** dropdown, choose **File Uploader by Uppy**.
4. Click the **gear icon** at the end of the field's row to open the widget's
   options.
5. Configure the options you want, then click **Update** and **Save** the form
   display.

## Widget options

The widget exposes Uppy's capabilities, so the options relate to the Uppy plugins
this module supports:

- **Dashboard** — the drag-and-drop upload interface (the main UI editors see).
- **Image Editor** — lets editors crop or adjust an image inline, before it is
  uploaded.
- **Internationalisation** — presents Uppy's interface in the site's language.

The **XHR** plugin is the transfer method (client-to-Drupal) that carries the upload
to the `file_uploader` endpoint; it underpins the chunked, resumable behavior.

## Let the field's own rules do the guarding

Uppy is the front end; what may actually be uploaded is still governed by the **file
field's settings**. Before relying on this widget for uploads — especially from
less-trusted users — confirm the field's **allowed extensions**, **maximum file
size**, and **number of values (cardinality)** are set the way you want. The server
side and its access checks live in the **File Uploader** parent module; this widget
does not loosen or replace them.

## Save

Click **Save** on the Manage form display page to apply the widget and its options.
