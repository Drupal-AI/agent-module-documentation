<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Media Entity PodToo (podtoo) — agent index
**Registers an oEmbed media source for embedding PodToo podcast/audio as Drupal media.**

- **Version:** 2.0.x
- **Core:** ^9.2.9 || ^10 || ^11
- **Depends on:** media
- **Config route:** `podtoo.configuration` → `/admin/config/media/podtoo` (`administer site configuration`)
- **Key services:** `Drupal\podtoo\ProviderRepository` (decorates `media.oembed.provider_repository`), `PodTooResourceFetcher`
- **Provider endpoint (fixed):** `https://embed.podtoo.com/api/oEmbed`; schemes `embed.podtoo.com/*`, `podcasts.podtoo.com/*`

**Security:** No custom routes beyond a permission-gated (`administer site configuration`) settings form; media CRUD uses core media-type permissions. Fetch target is hard-coded (no SSRF). Admin-opt-in setting can forward the current user's name/email/uid to the PodToo endpoint (privacy note, off by default).
