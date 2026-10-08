# Configuration

Media Alias Display works as soon as it's enabled (and once core's **Standalone
media URL** setting is on). The settings form only *narrows or switches off* the
behavior — it isn't required to get started.

## Prerequisite: Standalone media URL

The module can only serve files at a media alias if media entities actually have a
canonical URL. That comes from core Media's **Standalone media URL** setting at
**Configuration → Media → Media settings** (`/admin/config/media/media-settings`).
Turn it on there, or run `drush cset media.settings standalone_url true -y`. If
it's off, the status report shows a warning and the module does nothing.

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default) — the module adds no permission of its own.
2. Go to **Configuration → Media → Media Alias Display**, or navigate directly to
   `/admin/config/media/media_alias_display`.

## Media Bundles

A checkboxes group listing your media types. This is an **allow-list**: tick the
bundles that should serve their file directly at their alias, and only those are
affected.

- **Leave every box unchecked** to apply the behavior to **all** media bundles.
  (An empty selection means "all", not "none".)
- **Tick specific bundles** — for example only *Document* — to limit the direct-file
  behavior to those, while other media types keep rendering their normal media
  page.

## Kill Switch

A single checkbox that disables the whole module site-wide when ticked. Every media
entity then renders normally again, exactly as if the module weren't doing
anything — without you having to uninstall it. This is handy for quickly reverting
the behavior if something looks wrong. Leave it unchecked for normal operation.

## Save

Click **Save configuration**. Changes take effect immediately; the module ships a
dedicated cache context so responses re-render when you toggle the kill switch.

## URL tricks (append to any media alias)

You don't configure these — they're query strings you (or your links) can add to a
media alias on the fly:

- **`?dl` or `?download`** — sends the file as a download (an attachment) instead
  of displaying it inline in the browser. Useful for "Download the form" links.
- **`?edit-media`** — redirects to the media **edit form** instead of serving the
  file. Only works for users who can edit that media (for example those with *edit
  own/any [bundle] media* or *administer media*), so it's a convenient shortcut for
  staff while staying safe for anonymous visitors.
