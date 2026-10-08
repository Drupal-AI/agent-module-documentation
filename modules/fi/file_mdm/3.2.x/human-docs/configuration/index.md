# Configuration

File Metadata Manager has a single settings page. It controls how missing files
are logged, how retrieved metadata is cached, and lets each installed metadata
plugin override the global cache rules. Because this is a foundation module, the
defaults are sensible and most sites can leave them alone — but it is worth
understanding each option, especially the caching behaviour.

## Open the settings page

1. Go to **Configuration → System → File metadata manager**
   (`/admin/config/system/file_mdm`).

![The File metadata manager settings page](../images/settings.png)

## Missing file logging

At the top of the page, **Missing file logging** is a dropdown that sets the
**log level to use if a file does not exist** when its metadata is requested.
The default is **Error**. If you find the log noisy — for example when files are
legitimately expected to be absent sometimes — you can lower the severity here
so those events are logged at a less prominent level.

## Metadata caching

The **Metadata caching** section controls the whole point of the module: keeping
parsed metadata around so files are not re-read on every request.

- **Cache metadata** — a checkbox, **on by default**. When selected, metadata
  retrieved from files is cached for further access. Leave this on unless you
  have a specific reason to disable caching; turning it off means every lookup
  re-parses the file.

- **Cache expires** — a dropdown that sets **how long cached entries live**
  (the default is **2 days**). Longer lifetimes mean fewer re-reads but a larger
  cache; shorter lifetimes keep the cache small but re-parse files more often.
  Choose based on how often your files change.

- **Excluded paths** — a text area, one path per line, listing paths that should
  be **excluded** from caching even when caching is on. A few rules apply here:
  - Only files prefixed by a valid URI scheme are cached at all — for example
    `public://`.
  - Files in the `temporary://` scheme are **never** cached, regardless of this
    list.
  - You can use wildcard patterns. For example, entering `public://styles/*`
    excludes all generated image-style derivatives from the metadata cache.

## Per-plugin sections (Getimagesize, and others)

Below the caching section, each installed metadata plugin gets its own block.
Out of the box you will see **Getimagesize** — the *File metadata plugin for PHP
getimagesize()* — which is the base module's built-in image-dimension reader. If
you enabled the `file_mdm_exif` or `file_mdm_font` submodules, their **EXIF** and
**font** plugins appear here as additional blocks.

Each plugin block contains an **Override main caching settings** checkbox. Leave
it unchecked to have the plugin use the global **Metadata caching** settings
above. Tick it when you want *this specific plugin* to cache differently from the
rest — for example, to cache image dimensions permanently while letting EXIF data
expire sooner. Checking the box reveals that plugin's own caching controls
(enable/disable, expiration, excluded paths), which then apply only to metadata
read by that plugin.

## Save

Click **Save configuration** at the bottom of the page. Your changes take effect
for metadata read from that point on.
