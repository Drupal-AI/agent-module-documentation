# Configuration

Email to RSS needs configuration before it produces anything — you have to tell it
which mailbox to read and give it the password out of band. Everything below is
done at **Configuration → Web services → Email to RSS**, reachable by a user with
the **Administer site configuration** permission.

## Set the IMAP password first

The mailbox password is **not** stored in Drupal configuration. Instead, the
module reads it from an environment variable named **`EMAIL_TO_RSS_IMAP_PASSWORD`**.
Set that variable in your hosting environment before (or right after) you fill in
the connection details.

> **Using DDEV?** Store the value with DDEV's dotenv helper rather than committing
> it: `ddev dotenv set .ddev/.env --email-to-rss-imap-password='your-password'`
> (the flag becomes the `EMAIL_TO_RSS_IMAP_PASSWORD` variable), then
> `ddev restart` so the container picks it up. Keep `.ddev/.env` out of version
> control.

## Configure the IMAP connection

On the settings form, fill in:

- **Host** — the IMAP server hostname (for example `imap.example.com`).
- **Port** — the IMAP port (commonly `993` for encrypted IMAPS).
- **Encryption** — the transport security to use. Choose an encrypted option
  (IMAPS/TLS) so credentials and mail aren't sent in the clear.
- **Username** — the mailbox login (usually the full email address).
- **Folder** — which mailbox folder to publish (for example `INBOX`, or a folder
  you file newsletters into).
- **Feed entry limit** — how many of the most recent messages the feed should
  contain.

Remember the password comes from the `EMAIL_TO_RSS_IMAP_PASSWORD` environment
variable, not from this form.

## The private feed URL

Once configured, the settings page displays the **private RSS feed URL**. This URL
contains a secret token and is the only thing protecting the feed — there is no
role‑based permission on it. **Treat the URL as secret:** anyone who has the link
can read the fetched email content. Use a high‑entropy token, serve the site over
HTTPS, avoid pasting the link where it might be logged or shared, and don't point
the feed at a mailbox that holds confidential mail.

## Fetching messages

- **Sync now** — fetches messages from the IMAP folder immediately. Use this to
  test the connection or to pull new mail on demand.
- **Automatic sync on cron** — with a normal cron setup, the module fetches new
  messages in the background, so the feed stays current without manual action.
- **Delete all entries** — clears Drupal's local mirror of fetched messages. The
  next sync repopulates it from the mailbox.

Messages are deduplicated by their Message‑ID, so re‑running a sync will not
create duplicate feed items, and HTML email bodies are preserved through the
feed's `content:encoded` element.

## Save

Click **Save configuration** to store the connection details, then use **Sync
now** and open the private feed URL in a feed reader to confirm messages are
coming through.
