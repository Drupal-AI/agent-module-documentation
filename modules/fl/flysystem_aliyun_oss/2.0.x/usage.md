<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Flysystem Aliyun OSS is a Flysystem plugin that lets Drupal read and write managed files to an Alibaba Cloud (Aliyun) OSS bucket as a stream wrapper scheme.

---

It registers an 'aliyun_oss' Flysystem adapter (backed by the aliyuncs/oss-sdk-php SDK) that you wire up in settings.php via the flysystem module's schemes configuration, supplying access_key_id, access_key_secret, endpoint, bucket, prefix, and options such as use_https, cname, visibility, and signed-URL expiry. Public objects are served by their OSS URL (optionally via a CNAME/CDN domain); private objects are served through time-limited signed URLs. It also provides several field formatters (image, file link, audio, video, table, RSS enclosure, plain URL) that render OSS-hosted files. Credentials live in Drupal settings (flysystem scheme config), not exported config. Note that use_https defaults to FALSE, so enable it explicitly for TLS-protected transfers.

---

- Offload public file uploads to an Aliyun OSS bucket.
- Serve images from OSS with a CDN CNAME domain.
- Store private files in OSS behind time-limited signed URLs.
- Use OSS as the default scheme for a media-heavy site.
- Reduce origin disk usage by keeping assets in object storage.
- Render OSS-hosted images with the provided image formatter.
- Provide download links to OSS files via the file-link formatter.
- Stream OSS-hosted audio or video in field displays.
- Set per-scheme visibility (public vs signed private URLs).
- Prefix all objects under a folder within a shared bucket.
- Serve responsive image styles generated onto OSS.
- Integrate OSS storage with any module that uses stream wrappers.
- Expose OSS files as RSS enclosures in feeds.
- Migrate existing public files to OSS-backed storage.
- Configure signed-URL expiry for private downloads.
- Enable HTTPS transfers by setting use_https in the scheme config.
