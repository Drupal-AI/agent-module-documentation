# Configuration

Imagecache External works out of the box, but the settings form lets you control where and
how remote images are cached, which hosts they may come from, and how the cache is cleaned
up.

## Open the settings form

1. Log in as a user with the **Administer imagecache external** permission.
2. Go to **Configuration → Media → Imagecache External**, or navigate directly to
   `/admin/config/media/imagecache_external`.

All values live in the config object **`imagecache_external.settings`**.

## The settings, field by field

**Where cached images are stored**

- **Imagecache directory** (`imagecache_directory`, default `externals`) — the directory,
  under the default file scheme, where fetched images are cached (e.g. `public://externals`).
- **Use subdirectories** (`imagecache_subdirectories`, default off) — when on, cached files
  are nested into two hashed subdirectories to avoid one huge flat folder.
- **Default extension** (`imagecache_default_extension`, default `.jpg`) — the extension
  appended when the source URL has none.
- **Management mode** (`imagecache_external_management`, default `unmanaged`) —
  *unmanaged* writes the file with no database record; *managed* creates a `File` entity
  (usable by file‑aware features, but you're responsible for tracking and cleaning it up).

**Which images are accepted**

- **Allowed MIME types** (`imagecache_external_allowed_mimetypes`) — the MIME types accepted
  when fetching (defaults cover jpg/jpeg/png/gif/webp). A file whose type isn't on the list
  is refused.
- **Use whitelist** (`imagecache_external_use_whitelist`, default off) and **Hosts**
  (`imagecache_external_hosts`) — see the host whitelist section below.

**Fallback and SVG**

- **Fallback image** (`imagecache_fallback_image`, a file id, default `0` = none) — the image
  served when an external URL is unreachable or invalid.
- **SVG allowed tags / attributes** (`svg_settings.allowed_tags`,
  `svg_settings.allowed_attributes`) — extra tags/attributes the SVG sanitiser should permit
  beyond its library defaults (empty means use the defaults).

**Cache flushing**

- **Cron flush frequency** (`imagecache_external_cron_flush_frequency`, days, default `0` =
  never) — flush the whole cache every N days on cron.
- **Cron flush originals** (`imagecache_external_cron_flush_originals`, default on) — whether
  the cron flush also removes the original cached files.
- **Batch flush limit** (`imagecache_external_batch_flush_limit`, default `1000`) — how many
  files are processed per queue chunk when flushing.

Read or set any value with Drush:

```bash
drush cget imagecache_external.settings
drush cset imagecache_external.settings imagecache_directory 'externals' -y
drush cset imagecache_external.settings imagecache_external_use_whitelist 1 -y
drush cset imagecache_external.settings imagecache_external_hosts 'cdn.example.org example.com' -y
```

## The host whitelist

By default, images can be fetched from **any** host. Turning on **Use whitelist** restricts
fetching to the hosts you list (whitespace‑separated) in **Hosts** — an image whose host
doesn't match one of them is refused and logged. This is a sensible hardening step so your
site only downloads images from sources you trust. You can test whether a given host passes:

```bash
drush imagecache-external:validate-host cdn.example.org
```

## Displaying external image URLs on a field

Two field formatters render a **link**, **string**, or **text** field that stores an image
URL. Set one on the field's **Manage display**:

- **Imagecache External** (`imagecache_external_image`) — settings for an **image style** and
  an optional **link** (to content, to the file, or none).
- **Imagecache External Responsive** (`imagecache_external_responsive_image`) — the same, but
  the opened image uses a **responsive image style**.

## The Twig filter

In a template you can style an external image URL directly:

```twig
{{ item.image_url|imagecache_external('large') }}
```

It returns the URL of the styled derivative, downloading and caching the source image on
first use.

## Flushing the cache

- **Manually** — use the flush form at
  `/admin/config/media/imagecache_external/flush`.
- **On cron** — set **Cron flush frequency** (in days); the cron job queues the deletions in
  batches.

There's no dedicated flush Drush command — flushing is done via the form or cron.

## Warming and maintaining the cache with Drush

```bash
# Pre-fetch (warm) the cache for a remote image:
drush imagecache-external:generate 'https://example.com/photo.jpg'

# Set the fallback image to file entity 42:
drush imagecache-external:set-default-image 42

# Check whether a host passes the current whitelist config:
drush imagecache-external:validate-host cdn.example.org
```

## Permission

A single permission, **`administer imagecache external`**, gates both the settings form and
the flush form. Grant it at **People → Permissions**.
