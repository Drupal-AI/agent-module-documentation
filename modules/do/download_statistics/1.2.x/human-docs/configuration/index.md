# Configuration

Getting Download Statistics working is a matter of confirming the private‑files
prerequisite, turning on counting, choosing how download counts are displayed,
placing the block, and setting permissions so the figures are visible to the right
users.

## Prerequisite: private file fields

Counting only happens for files in a **private** directory (see
[Installation](../installation/index.md) for why). Before configuring anything
else, set the relevant file fields to **Upload destination: Private files** in
their **Field settings**, and confirm a private directory is configured in
`settings.php`. This is the single most common reason counts stay at zero.

## Open the settings form

1. Log in as a user with **Administer site configuration**.
2. Go to **Configuration → System → Download Statistics**
   (`/admin/config/system/download-statistics`).

On this page you can:

- **Enable or disable** file‑download counting.
- **Clear the file downloads table** if you want to reset the recorded statistics.

## Choose how downloads are displayed

Download Statistics offers a couple of display integrations:

- **In Views:** to use the download counter on a Views page or block display,
  select **File URI with Download Count** as the URI Formatter type in the Views
  UI. The module also exposes view fields for total downloads, downloads today, and
  the most recent download timestamp.
- **On a node or media page:** to count downloads of an attachment shown on an
  entity page, go to that entity type's **Manage display** tab and select **File
  with Download Statistics recorded** as the field's format.

## Place the "Popular file downloads" block

Under **Structure → Block layout**, place the **Popular file downloads** block in
any region. Its settings let you configure:

- the number of **most recent** downloaded files to display,
- the number of **all‑time** top downloads to display, and
- the number of the **day's top** downloads to display.

You can also build your own block using the Views integration to show attachments
and their download counts directly on a node page.

## Set permissions

On **People → Permissions**, grant the module's permissions so that the download
counter and statistics are visible to the users who need them. Without the
appropriate permission, the counts will not be shown.

## Privacy and retention

Like any download analytics, this module records download activity. Be mindful of
what is stored per download, avoid logging unnecessary personal data, and consider
a retention policy for the statistics — clearing the downloads table from the
settings page when appropriate.
