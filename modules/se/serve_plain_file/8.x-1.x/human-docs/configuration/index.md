# Configuration

Serve Plain File has no abstract settings to tune — configuring it means granting
the permission and then adding the files you want to serve.

## Grant the permission

Go to **People → Permissions** and grant **Administer served files** to the roles
that should manage these files. Because a served file can affect how search
engines and ad networks see your site, keep this to trusted administrators.

## Add and manage served files

1. Go to **Configuration → System → Served files**
   (`/admin/config/system/served_files`).
2. Add a file, providing:
   - **Path** — the URL the file should be served at (for example `/ads.txt` or
     the path a verification service expects). Make sure this does not clash with
     an existing route on your site.
   - **Max-age** — how long the served file may be cached, in seconds.
   - **Content** — the plain-text body of the file, entered directly in the back
     end.
3. Save. The file is immediately available at the path you gave.

You can edit or delete served files from the same screen at any time. Since the
files are stored as configuration, they travel with your normal config
export/import — or, if you would rather edit them straight on production, pair the
module with **Config Ignore** so a config import does not overwrite them.

## If you use external caching

If you run Varnish, a CDN, or another external cache, changing a served file will
not clear those caches automatically. The module exposes the URLs that need
purging through its entity update and delete hooks, so you can implement
`hook_ENTITY_TYPE_update()` and `hook_ENTITY_TYPE_delete()` for the served-file
entity in a custom module and call your own cache-purging logic with the returned
URLs.
