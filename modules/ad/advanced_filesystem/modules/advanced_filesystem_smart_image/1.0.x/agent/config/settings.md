<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration, routes & permissions

## Install / enable

`drush en advanced_filesystem_smart_image` (pulls in `advanced_filesystem` + core `file`).
`hook_install()` creates `public://adfs_derivatives` and chmods it 0775. **PHP GD is required** at
runtime. `hook_uninstall()` deletes the config object.

## Permission & routes

- Permission `administer advanced_filesystem_smart_image` (`*.permissions.yml`,
  `restrict access: true`).
- `advanced_filesystem_smart_image.settings` → `/admin/config/media/advanced_filesystem/smart-image`
  (form `Form\SmartImageSettingsForm`), permission above, `_admin_route`.
- `advanced_filesystem_smart_image.warmup` → `.../smart-image/warmup`
  (form `Form\SmartImageWarmupForm`), same permission.
- `advanced_filesystem_smart_image.derive` → `/adfs/image`, `_access: 'TRUE'` (anonymous). See
  [../api/endpoint.md](../api/endpoint.md).
- Menu link under the settings route defined in `*.links.menu.yml`.

## Config object `advanced_filesystem_smart_image.settings`

Schema `config/schema/advanced_filesystem_smart_image.schema.yml`; install defaults
`config/install/advanced_filesystem_smart_image.settings.yml`:

- `allowed_schemes` (sequence of string) — stream schemes accepted for `src`/`wm`.
  Default `[public]`. Any other scheme → 403.
- `signing.enabled` (bool, default **false**) and `signing.secret` (string, default `''`) — HMAC
  URL signing (see below).
- `cache.max_age_days` (int, default 30) — cron prunes derivatives older than this; 0 = never.
- `cache.max_size_mb` (int, default 500) — informational only; **not enforced automatically**
  (purge via the settings form button or `drush adfs:image:purge`).
- `cache.directory` (string, default `public://adfs_derivatives`).
- `security.max_input_pixels` (int, default 25,000,000) — refuse source images larger than this
  (decompression-bomb guard). 0 = no limit.
- `presets` (sequence of `advanced_filesystem_smart_image.preset`) — named parameter bundles keyed
  by preset id; per-preset keys: `label, w, h, fit, fmt, q, rotate, flip, grayscale, blur, sharpen`.
  Ships three: `thumbnail_small` (150×150 crop webp q80), `medium_webp` (800×600 contain webp q82),
  `hero` (1920×600 cover webp q85).

## Settings form (`SmartImageSettingsForm`)

Shows a GD capability banner (supported formats, `imageavif()` availability) and the current
derivative directory file count/size. Edits `allowed_schemes` (textarea, one per line), max input
pixels, signing enable + secret (secret field visible only when enabled), cache max age/size, a
"Purge all derivatives now" danger button (`purgeAll()` → `DerivativeCacheManager::purgeAll()`), and
the presets as a validated JSON textarea. `getEditableConfigNames()` = the settings object only.

## URL signing

Off by default. When `signing.enabled` is true, every `/adfs/image` request must carry a `token`
query param. `ImageProcessor::generateToken($src, $params, $secret)` =
`hash_hmac('sha256', $src.'?'.http_build_query(ksort($params_without_token)), $secret)`;
`validateToken()` compares with `hash_equals()`. The `token` key is excluded from both the signature
and the cache key. Mint tokens with `drush adfs:image:token public://x.jpg --w=800 --fmt=webp`
(errors if no secret is set). Operationally: enabling signing requires setting a strong, non-empty
`signing.secret`, and callers (templates/CDN) must sign every derivative URL.

## Cron

`advanced_filesystem_smart_image_cron()` (`.module`) calls
`DerivativeCacheManager::pruneByAge(max_age_days * 86400)` when `max_age_days > 0` and logs the count.
