# Configuration

This module needs three pieces of information from your GC Notify account before it
can send anything: the API **endpoint URL**, a **template ID**, and an **API key**.
There is also an optional **queue** setting for throttling on busy sites.

## Before you start: keep the API key a secret

The GC Notify API key authenticates your site to the service. Never hard-code it in a
committed file. Store it in an environment variable and reference it through Drupal so
the value never lands in configuration exports or version control.

With DDEV, save the key into the container's environment:

```bash
ddev dotenv set .ddev/.env --gcnotify-api-key=<your-key>
ddev restart
```

That makes the value available as `GCNOTIFY_API_KEY` inside the container (keep
`.ddev/.env` out of version control). Where the module accepts a
[Key](https://www.drupal.org/project/key) entity, prefer creating a Key backed by the
env provider rather than pasting the secret into the form; otherwise reference the
environment variable from `settings.php` with `getenv('GCNOTIFY_API_KEY')`. Either
way the raw key stays out of the database and out of git.

## Enter the connection settings

On the module's settings form, fill in:

- **GC Notify URL** — the REST endpoint the module posts to. Use the HTTPS URL GC
  Notify provides so the request (which carries recipient data and your key) is
  encrypted in transit.
- **Template ID** — the ID of the GC Notify template you created with `((subject))`
  and `((body))` placeholders. Drupal fills those placeholders with the
  token-replaced, language-appropriate subject and body before sending.
- **API key** — the secret from your GC Notify account. Provide it via the Key entity
  or environment variable described above rather than typing it directly wherever the
  form allows.

## Use queue (optional throttling)

- **Use queue** — tick this on large or high-volume sites. Instead of sending each
  notification immediately, the module hands items to a QueueWorker that introduces a
  wait time between sends, smoothing the load on GC Notify. If you enable this, make
  sure cron runs regularly (a dedicated runner such as Ultimate Cron is recommended)
  so the queue is actually processed.

## Privacy and data handling

When a notification is sent, recipient details (email address, and potentially phone
number — both personal data) and the message content leave your site for the GC
Notify API. Make sure this external transfer is reflected in your privacy notice and
records of processing, and that recipients have a lawful basis to be contacted this
way.

## Save

Save the form. Trigger a subscribed change to confirm delivery. If sends fail, first
check the URL and template ID, then confirm the API key is present in the container
(for example `ddev exec 'test -n "$GCNOTIFY_API_KEY"'`, which exits 0 when it is set)
without printing its value.
