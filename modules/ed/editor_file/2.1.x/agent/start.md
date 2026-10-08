# editor_file — agent start

Adds a **File** (paperclip) button + upload dialog to CKEditor 5 so authors upload a file and
insert a tracked link (`data-entity-type`/`data-entity-uuid`). Requires core `ckeditor5`.
No permissions of its own (uses the text format's `use` permission). Configured per text
format at **Admin → Config → Content authoring → Text formats and editors**
(`filter.admin_overview`).

- Enable the button and set upload options → [configure/setup.md](configure/setup.md)
