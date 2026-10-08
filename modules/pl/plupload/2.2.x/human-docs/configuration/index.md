# Configuration

Plupload has **no admin settings page**. It ships exactly one piece of
configuration — where in‑progress upload chunks are temporarily stored — and most
sites can leave it at its default. You set it from the command line (or in a config
file), not from a UI.

## The one setting: `temporary_uri`

While a large file is being uploaded, Plupload streams it to the server in chunks
and writes those chunks to a temporary location before reassembling them. The
`plupload.settings:temporary_uri` value controls that location. Its default is
Drupal's temporary stream:

```yaml
# plupload.settings
temporary_uri: 'temporary://'
```

Read or change it with Drush:

```bash
drush cget plupload.settings temporary_uri
drush cset plupload.settings temporary_uri 'private://plupload-tmp' -y
```

## When would you change it?

The one situation that matters is a **load‑balanced / high‑availability** setup with
more than one web server. Because a single file arrives as many chunks, and each
request might land on a different web node, the chunks could be scattered across
servers and fail to reassemble. Pointing `temporary_uri` at a **shared filesystem**
that every web node can reach (for example a mounted NFS stream) ensures all chunks
of a file are written to the same place before they are stitched back together.

On a single‑server site, the default `temporary://` is fine and you don't need to
touch this.

## Related: the upload endpoint and permissions

Plupload's element uploads to a shared, CSRF‑protected route
(`/plupload-handle-uploads`) which requires the core **Access content** permission.
This is the route the element calls internally with a fresh CSRF token — you
normally never call it directly. If you need to restrict who can upload, gate the
**form** that contains your `plupload` element (with your own access checks), rather
than trying to lock down this shared route.
