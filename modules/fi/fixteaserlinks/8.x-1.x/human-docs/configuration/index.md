# Configuration

By default, Fix Teaserlinks does **nothing** — every option starts switched off.
You turn on hiding for each link you don't want to appear under your node
teasers. This page describes that form.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → System → Fix Teaserlinks**, or navigate directly to
   `/admin/config/system/fixteaserlinks`.

## Choose which teaser links to hide

The form offers a toggle for each of the node links Drupal renders under a teaser.
Switch on the ones you want to hide; leave the rest off. The links you can control
are the usual teaser links, including:

- **Read more** — the link to the full node page.
- **Add new comment** — the link inviting logged‑in users to comment.
- **Log in or register to post comments** — the prompt shown to anonymous
  visitors where commenting is available.

Turning a link's option **on** hides that link in teaser view mode; leaving it
**off** keeps Drupal's default behaviour. The module only affects the **teaser**
view mode, so full node pages are untouched.

## Save and rebuild caches

Click **Save configuration**. Then rebuild the caches so the change is applied:

```bash
drush cr
```

> **If a change doesn't seem to take effect**, this is almost always caches. Make
> sure you have cleared or rebuilt caches after saving before treating it as a
> bug. Reload a page that lists node teasers and confirm the links you hid are
> gone.
