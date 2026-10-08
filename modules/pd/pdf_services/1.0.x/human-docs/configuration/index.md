# Configuration

PDF Services needs three things set up before it can do anything: your **Adobe
credentials**, some **processing options**, and **per‑field** activation on the
file fields you want processed. After that, processing runs on cron and you watch
it from the queue dashboard.

## 1. Adobe API credentials

Go to **Configuration → Content authoring → PDF Services**
(`/admin/config/content/pdf-services`).

- **Client ID** — the Adobe PDF Services API Client ID from your Adobe developer
  project.
- **Client Secret** — the matching secret. Rather than pasting the raw value here,
  select the **Key** entity you created during installation, so the secret lives in
  an environment variable instead of Drupal's configuration. (See the
  [Installation](../installation/index.md#store-the-adobe-credentials-as-a-secret-recommended)
  steps.)

Without valid credentials the module cannot reach Adobe and no processing will
happen.

> **Reminder:** entering credentials here activates outbound uploads of your PDFs
> to Adobe's cloud. Make sure that is acceptable for the documents your site holds.

## 2. Processing options

On the same settings page, tune how the module behaves:

- **Automatic checking on upload** — whether uploaded PDFs are analysed
  automatically.
- **Block vs. warn** — whether a PDF that fails accessibility checks is blocked
  from being saved, or merely flagged with a warning. A separate *bypass
  justification* permission lets trusted users save a failing PDF while documenting
  why.
- **Batch size and retry limits** — how many files are handled per queue run and
  how failures are retried, so processing does not overwhelm your server.
- **Notifications** — whether editors are emailed when accessibility issues are
  detected (pair with an HTML mail module for nicely formatted messages).
- **Optimisation thresholds and compression levels** — how aggressively PDFs are
  compressed and linearised.

Save the form when you are done.

## 3. Enable processing per field

PDF Services processes the file fields you opt in. For each relevant field:

1. Go to **Structure → Content types → *(your type)* → Manage fields** and edit the
   PDF file field.
2. In the field settings, enable PDF Services processing and choose the field‑level
   options you want (different content types or fields can be handled
   differently).
3. Save.

You can also configure the **Adobe PDF Embed viewer** as a field formatter on
*Manage display*, with options such as lightbox, full‑screen, and two‑column
layouts, and per‑item overrides so editors can tailor how a specific document is
shown.

## 4. Permissions

Under **People → Permissions**, grant the module's permissions to the appropriate
roles — for example, who may administer PDF Services, and who may record a bypass
justification to save a PDF that fails accessibility checks. Keep the
administrative permission to trusted roles.

## 5. Watch processing and read reports

PDFs are processed in the background on the next **cron** run, so processing is
asynchronous and does not slow down content editing. Monitor status, manage the
queue, and view accessibility reports at the queue dashboard,
`/admin/config/content/pdf-services/queue`. Each processed PDF gets an
accessibility report with remediation suggestions, and results can also be surfaced
through **Views**.

> **Tip:** if PDFs never move out of the queue, check that cron is running, that
> your Adobe credentials are valid, and that the site can reach Adobe's API over
> HTTPS.
