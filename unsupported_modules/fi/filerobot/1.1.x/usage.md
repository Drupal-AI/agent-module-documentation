<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Integrates the Scaleflex Filerobot Digital Asset Management platform.

---

Scaleflex DAM (module `filerobot`, project `filerobot_by_scaleflex`) integrates the Scaleflex Filerobot Digital Asset Management platform — a scalable DAM with image/video optimizers to store, organize, optimize and deliver media assets — letting editors pick assets from Filerobot and insert them as Drupal files/media.

**Security note (as shipped, 1.1.0):** the insert endpoint `/api/filerobot-insert-image` (gated by `administer media`) does `file_get_contents($data['url'])` on a caller-supplied URL with **no scheme/host validation** — an authenticated SSRF / local-file read (a content-admin could fetch internal services or `file://` paths). Validate/allowlist the URL before fetching. Store Filerobot API credentials securely (env-backed). Supports Drupal 10 and 11.

---

- Integrate the Scaleflex Filerobot DAM.
- Pick assets from Filerobot.
- Insert them as Drupal files/media.
- Optimize/deliver media.
- NOTE: insert endpoint fetches a caller URL (SSRF).
- Gate insert by `administer media`.
- Validate/allowlist the URL.
- Store API credentials securely.
- Depend on core media.
- Support Drupal 10 and 11.
- Configure the connection.
- Handle DAM assets.
- Support Drupal.
- Support Drupal.
- Support Drupal.
