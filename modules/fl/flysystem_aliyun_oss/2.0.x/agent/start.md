<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Flysystem Aliyun OSS (flysystem_aliyun_oss) — agent index

**Flysystem adapter storing Drupal files on Alibaba Cloud (Aliyun) OSS.**

- **Version:** 2.0.x  | **Core:** ^8 || ^9 || ^10  | **Package:** Flysystem
- **Depends:** flysystem. **Library:** aliyuncs/oss-sdk-php ^2.4.
- **Adapter id:** `aliyun_oss` (`src/Flysystem/AliyunOss.php`); configured via flysystem schemes in settings.php (access_key_id/secret, endpoint, bucket, prefix, use_https, cname, visibility, expire).
- **Formatters:** image, file link, audio, video, table, RSS enclosure, plain/URI URL.

**Security note:** `use_https` defaults to **FALSE** (`AliyunOss::create()`), so unless explicitly enabled, OSS traffic (including signed requests carrying the credential signature) goes over plaintext HTTP. Credentials are read from settings.php scheme config (not exported). Recommend setting `use_https: true`.
