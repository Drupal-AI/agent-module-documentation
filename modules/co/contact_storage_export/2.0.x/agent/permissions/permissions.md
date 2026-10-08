# Contact Storage Export permissions

From `contact_storage_export.permissions.yml`:

| Permission | Gates |
|---|---|
| `export contact form messages` | The **Export submissions** operation, the export form (`entity.contact_form.export_form`), and the download form (`contact_storage_export.contact_storage_download_form`). `restrict access: TRUE`. |

That single permission controls the whole feature. Grant it to any role that should be able to
download contact-form submissions as CSV (the README explicitly suggests giving it to
non-administrator roles that need to export). There is no per-form permission — holding it
allows exporting **any** contact form's stored messages (subject to normal entity access on the
messages, since the export query runs with `accessCheck(TRUE)`).
