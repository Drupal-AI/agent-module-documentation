# Configuration

Media External has **no admin settings form**. There are two setup steps: add
your provider API keys to `settings.php`, then create a media type that uses the
**External media** source.

## 1. Add provider API keys to settings.php

The provider keys are read only from Drupal settings — never from the UI or
config — which keeps them out of your exported configuration. Get a free API key
from each provider's developer portal, then add the matching line(s) to your
site's `settings.php` (or a `settings.local.php`):

```php
$settings['media.external_provider.pexels.api_key']      = 'YOUR_PEXELS_API_KEY';
$settings['media.external_provider.unsplash.access_key'] = 'YOUR_UNSPLASH_ACCESS_KEY';
```

You only need the key for the provider(s) you intend to use. Best practice is to
read the value from an environment variable rather than hard‑coding it, e.g.
`getenv('PEXELS_API_KEY')`.

## 2. Create the media type

1. Go to **Structure → Media types → Add media type**
   (`/admin/structure/media/add`).
2. Give it a name (for example "Stock photo") and choose **External media** as
   the **Media source**.
3. In the source configuration set:
   - **Provider** — pick **Pexels** or **Unsplash** (or a custom provider plugin
     if a developer has added one).
   - **Thumbnails location** — a stream‑wrapper path where downloaded thumbnails
     are stored. The default is `public://external_thumbnails/[date:custom:Y-m]`,
     which sorts thumbnails into month folders. Tokens are allowed; the value must
     be a valid URI.
4. **Save.** The module automatically creates the source field (a text field named
   "*<label>* ID") that stores the external image's ID — you don't create it
   yourself.

## 3. Map the metadata to fields (recommended)

The External media source exposes metadata you can map onto real fields so the
values are stored locally and don't require another API call to display:
**provider**, **title**, **File URL**, **description**, **alt**, **photographer**,
and **photographer URL**.

On the media type's **Manage fields**, add fields (for example a text field for
the file URL and one for alt text), then on the source settings map the metadata
attributes onto them. Mapping **File URL** to a field and feeding that field to
the **imagecache_external** module is what lets you apply image styles to the
remote images. Mapping **photographer** / **photographer URL** lets you credit
the photographer.

## 4. Import images (the editor flow)

Once the type exists, editors adding media of that type (via a Media Library
field or the media add page) see an **Add by keyword** box. They type a search
term, click **Search**, pick thumbnails from the results (which are paginated),
and click **Import**. Access to the search follows the standard Media Library
permission — anyone who can use the Media Library can search and import.

## Notes

- This module ships no config schema and no permissions of its own; all access is
  governed by core Media / Media Library permissions.
- Provider search results are cached, so repeated searches don't hit the provider
  API every time.
