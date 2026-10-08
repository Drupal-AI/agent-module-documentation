# SFTP Data Export — manual setup guide

**SFTP Data Export** (`sftp_data_export`) exports selected fields from the nodes of a
content type into a CSV file and uploads that file to a remote SFTP server over SSH2.
It's built for feeding Drupal content into an external system on a recurring basis —
handing a catalog or content extract to a partner, an ETL pipeline, or a legacy
reporting tool without anyone copying files around by hand.

You pick which content type to export and exactly which of its fields to include; the
module then runs a Batch API process that loads nodes in chunks, formats each field
sensibly (image fields become their file URI, list fields resolve to their
allowed-value labels, timestamp fields are formatted as dates, link fields export
their URI) and writes the rows to a CSV. When the batch finishes it opens an SSH2
connection and streams the CSV up to the remote server.

**A note on the package name.** The Composer package is `drupal/sftp_export` but the
module's machine name is `sftp_data_export` — so you *require* `drupal/sftp_export`
but *enable* `sftp_data_export`. This is a genuine mismatch to keep in mind, and it's
reflected in the commands in this guide.

The module requires the PHP **`ssh2` extension** and supports Drupal 9, 10 and 11.
This guide is written for a **human** setting it up through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Security — read this before you use it

This module has several behaviors that operators should weigh carefully:

- **Broad access gate.** All three admin routes (field selection, credentials,
  export) are gated only by the generic **Access administration pages** permission —
  *not* by the module's own `administer sftp` permission, which is defined but never
  actually enforced. That means any role with general admin access can view or change
  the SFTP credentials and trigger exports. Restrict who has admin access
  accordingly.
- **Plaintext credentials.** The SFTP host, port, username and password are stored in
  plain configuration (`sftp_data_export.cred`). They are therefore exportable with
  your config (so keep that config out of public version control), and the password
  is pre-filled back into the form field.
- **Web-accessible output.** The generated CSV is written to the public files
  directory (`public://sftp/<bundle>_<date>.csv`) with a predictable name and is not
  deleted afterward — meaning exported content can sit in a web-reachable location.
  Clean these files up, or restrict access to that directory.
- **No host-key verification.** The SSH2 connection does not check the remote
  server's host key/fingerprint, which leaves the transfer open to a
  man-in-the-middle. Only use it toward hosts on a trusted network path.

## Contents

1. [Installation](installation/index.md) — install with Composer (note the package
   name), install the SSH2 extension, and enable the module.
2. [Configuration](configuration/index.md) — choose fields, enter SFTP credentials,
   and run the export.

## Where it lives in the admin menu

The module's screens live under **Configuration → Web services** at
`/admin/config/services/sftp_settings/*`:

- `.../content_config` — choose which fields per content type to export.
- `.../credentials` — the SFTP host, port, username and password.
- `.../export` — run the export batch.
