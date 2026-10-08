# Configuration

## Prerequisite

The PHP **`ssh2` extension** must be installed and loaded (see
[Installation](../installation/index.md)). Without it, the export cannot connect to
the remote server.

All of the screens below live under **Configuration → Web services** at
`/admin/config/services/sftp_settings/*`. Note that they are reachable by any role
with the generic **Access administration pages** permission, so make sure only
trusted users have admin access.

## 1. Choose the fields to export

Go to `/admin/config/services/sftp_settings/content_config`.

For each content type (bundle), select which fields should be included in the CSV.
Some field types are filtered out automatically and won't appear in the picker —
entity-reference, map, metatag, UUID and comment fields. When you export, the
remaining fields are formatted for you:

- **Image** fields export as their file URI.
- **List** fields (string / integer / float) resolve to their allowed-value labels.
- **Created / timestamp** fields are formatted as `m/d/Y H:i:s`.
- **Link** fields export their URI.

Save your selection.

## 2. Enter the SFTP credentials

Go to `/admin/config/services/sftp_settings/credentials`.

Enter the remote server's **host**, **port**, **username** and **password**. These
are saved to configuration (`sftp_data_export.cred`).

Be aware that these credentials are stored in **plaintext config** — the password is
even pre-filled back into the form when you return — so keep this config out of any
public version control, and remember that the connection performs **no host-key
verification**. Only point it at a server you reach over a trusted network path.

## 3. Run the export

Go to `/admin/config/services/sftp_settings/export`.

Running the export kicks off a Batch API process: it loads the nodes in chunks,
builds the CSV at `public://sftp/<bundle>_<date>.csv`, and — on completion — opens an
SSH2 connection and streams the file up to the remote host, where it lands as
`Files/<count>_<date>.csv`.

## After exporting

The CSV written to `public://sftp/` is in a **web-accessible** directory, has a
**predictable name**, and is **not deleted** automatically. Clean up those files
after a successful transfer (or restrict access to that directory) so exported
content isn't left exposed. Re-run the export whenever your content changes and you
need to push a fresh file.
