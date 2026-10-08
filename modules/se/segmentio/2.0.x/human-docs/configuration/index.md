# Configuration

Segmentio does nothing until you give it a Segment write key, so this page is the
one setup step that matters.

## Open the settings form

1. Log in as a user with the **Administer Segmentio** (`administer segmentio`)
   permission.
2. Go to **Configuration → System → Segmentio**, or navigate directly to
   `/admin/config/system/segmentio`.

## The settings, field by field

- **Write key** — your Segment source write key, copied from your Segment
  workspace. This is required; with it set, the module attaches Segment's
  `analytics.js` to your pages and starts sending data. If tracking runs while
  this is empty, the module logs an emergency message that no write key has been
  configured. Remember that the write key is public on the client side by
  design — it is not a secret.
- **Privacy (respect Do-Not-Track)** — on by default. When enabled, the module
  suppresses tracking for any visitor whose browser sends the `DNT`
  (Do-Not-Track) header. Leave this on unless you have a specific reason to
  override visitors' Do-Not-Track preference.
- **Tracking callbacks** — a list of the tracking data sources you want to
  enable. Each entry corresponds to a callback that contributes data to the
  payload sent to Segment. Two are built in:
  - the **user** callback adds the current user's ID and their **name and email**
    as identify traits;
  - the **node** callback adds the page's category (content type), name (title),
    and node properties on node pages.

  Enable only the callbacks whose data you actually want to send. Other modules
  can register their own callbacks, which then appear in this list.

## A privacy note before enabling the user callback

When the user callback is enabled, the logged-in visitor's **name and email are
written into the page's `drupalSettings`** (readable in the page source) and sent
to Segment and onward to whatever destinations you have connected. Treat this as
personally identifiable information leaving your site, and make sure it is
consistent with your privacy policy and any GDPR obligations before turning it on.

## A caching note

If your code queues per-request `track` events, Segmentio disables the page cache
for those responses (a "kill switch") so the events are not cached away. That is
expected behaviour; it means pages that fire custom events are not served from the
page cache.

## Save

Click **Save configuration** to store the write key and options. The Segment
snippet is attached to your pages on the next request.
