# Remote Stream Wrapper Widget — agent index

One field widget that populates a core **File**/**Image** field from a remote `http(s)` URL
instead of a local upload, saving a `file` entity with a remote URI. No config page
(`configure` null), no permissions, no schema, no Drush. Requires `remote_stream_wrapper` (^2.1),
which supplies the actual stream wrapper + fetching.

- **Attach the widget, its behavior on save, field-type support** → [configure/widget.md](configure/widget.md)

Key facts:
- Widget plugin id **`remote_stream_wrapper`** (`…/Plugin/Field/FieldWidget/RemoteStreamWrapperWidget.php`),
  `field_types = {file, image}`.
- Form element: a single `#type => url` textfield per delta (required mirrors the field).
- `massageFormValues()` reuses an existing `file` entity matching the URI, else `create()`s
  and `save()`s a new one (`uid` = current user) and stores its `target_id`.
- No MIME/extension validation beyond the browser `url` type.
