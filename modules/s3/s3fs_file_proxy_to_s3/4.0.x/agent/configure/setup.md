<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring S3FS File Proxy to S3 (staging)

This module has no admin UI of its own. It is driven by the `s3fs` and `stage_file_proxy`
configuration plus one settings flag.

## 1. Enable the modules
```
drush en s3fs stage_file_proxy s3fs_file_proxy_to_s3 -y
```

## 2. Turn on S3-for-public and provide credentials (settings.php)
The overriding behaviour only activates when this is set:
```php
$settings['s3fs.use_s3_for_public'] = TRUE;
```
Supply S3 credentials/bucket for the **staging** bucket through the standard s3fs settings
(keys in `settings.php`, not config, so they are not exported). Do not commit real keys.

## 3. Point stage_file_proxy at production
Configure the stage_file_proxy **origin** to the production site URL. The fetch manager builds the
remote URL from that origin plus the requested public path — it never fetches a URL taken from the
incoming request, so there is no arbitrary-URL fetch surface.

## How a request flows
1. A staging request for a public file the bucket lacks hits the stage_file_proxy subscriber
   (`S3fsFileProxyToS3Subscriber::checkFileOrigin()`).
2. If the file already exists it redirects to it; otherwise the fetch manager downloads it from the
   production origin and writes it into the staging bucket via the s3fs public stream wrapper.
3. Image-style requests are served from `/s3fs_to_s3/files/styles/{image_style}/{scheme}`; the
   original is fetched and the derivative regenerated.

## Notes
- Intended for staging / pre-production only.
- Keep both buckets' credentials in `settings.php`.
