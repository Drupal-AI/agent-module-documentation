# Configuration

You configure Apostroph Group Translator the same way you configure any TMGMT
translation provider: by adding a translator that uses its plugin and filling in
the connection settings.

## Add the provider

1. Go to **Configuration → Regional and language → Translation providers**
   (TMGMT → Providers).
2. Add a new translator and choose the **Apostroph Group Connector** plugin.
3. Fill in the Apostroph settings (below), then save.

## Connection settings

- **Service URL** — the myApostroph REST base URL. Use the HTTPS address Apostroph
  gives you.
- **Username** and **Password** — your HTTP Basic authentication credentials. The
  module sends them as a `Basic` authorization header on each request. Note that
  these are stored as **plaintext** in the translator's configuration entity (this
  is standard for TMGMT providers), so treat any configuration export as sensitive
  and keep it out of public version control.
- **Customer id** — your Apostroph customer number, used to route each order to
  your account.

## Options

- **One export file** — controls whether all of a job's items are exported into a
  single XLIFF file, or each item is exported into its own XLIFF file within the ZIP.
- **File scheme** — where the exported source ZIP/XLIFF files are stored. This
  defaults to **public**, which means those files (and the download link shown in
  the status message after a send) live under the public files directory and can
  be reached by anyone who knows or guesses the URL. **For any confidential
  content, set this to `private`.** There is also an `is_confidential` flag you can
  use to mark a job as confidential.
- **Cron delivery** — enable the per-translator cron option if you want finished
  translations pulled back and imported automatically on cron runs. Leave it off if
  you prefer to import each delivery manually.

## How translations flow

- **Sending:** requesting a translation exports the job to XLIFF, zips it, and
  POSTs it to Apostroph (retried up to three times on transient errors). The remote
  translation id is stored as the job reference, and a status message with a
  download link to the exported ZIP is shown.
- **Receiving:** deliveries come back either automatically on cron (if enabled) or
  when you submit the manual "semi import" for a job. The module validates that an
  imported file's job id matches the local job before importing it.
- **Cancelling:** deleting or aborting a TMGMT job calls Apostroph's cancel
  endpoint for that job.

## Security checklist for operators

- Set the file **scheme to `private`** for any confidential content — the default
  `public` scheme exposes the source ZIP/XLIFF and the status-message download URL.
- Treat exported TMGMT configuration as **secret**, because the username and
  password are stored there in plaintext.
- All communication is initiated by Drupal, outbound over HTTPS with TLS
  verification on; there is no inbound endpoint for anyone else to trigger.
