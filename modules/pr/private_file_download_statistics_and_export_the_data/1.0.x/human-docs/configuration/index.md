# Configuration

This module needs two decisions from you: **which private file field** to track,
and **which user fields** to include when exporting. Tracking will not record
anything until the first of those is set.

## Open the settings form

1. Log in as a user with the **Access administration pages** permission (an
   administrator by default).
2. Go to `/admin/file-statistics/config` (the same form is also linked from
   `/admin/private-files-statistics/config`).

## The two settings

### Private file field to track

Enter the **machine name** of the private file field whose downloads you want to
record — for example `field_private`. Whenever a user downloads a file stored in
this field, the module logs the node, the file, the user's email, the timestamp,
and increments the download count. Without this value, nothing is tracked.

### User field names to export

Enter a comma-separated list of **user field machine names** to include in CSV
exports — for example `mail,field_firstname`. These come from the *People* (user)
fields. A few things to know:

- If you leave this empty, the **Export** link will not appear on the dashboard —
  so set it if you want CSV export at all.
- Only **plain text** field values are supported in the export. Non-text field
  types (references, dates, and similar) will not export correctly.

Click **Save configuration** to apply.

## Using the dashboard

Once tracking is running, go to **`/admin/files/statistics`**. For each tracked
file you get three actions:

- **View** — a detailed view of that file's statistics, including the list of
  users who downloaded it and their most recent timestamps.
- **Delete** — remove that file's statistics record.
- **Export** — download a CSV of that file's downloaders together with the user
  fields you configured above.

## Where exports are stored

Exported CSVs are written to the public files directory.
