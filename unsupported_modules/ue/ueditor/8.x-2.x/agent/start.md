<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# UEditor (ueditor) — agent index

Baidu UEditor as a Drupal editor plugin, plus its upload / file-manager / remote-fetch endpoints.
Configure at `/admin/config/content/ueditor`. Core `^8.8 || ^9 || ^10 || ^11`. Depends on `editor`.
Composer resolves **`1.x-dev`** — the checkout is at tag **8.x-2.62** (`a0c81f8`, 2024-10-14) with
no `version:` in the info file.

Permissions: `upload file with ueditor` (**not** `restrict access`), `administer ueditor`.

**Do not recommend without stating the first two. Both executed on a clean install.**

1. **SSRF with response exfiltration.** `?action=catchimage&source[]=<url>` →
   `UploadCatch::doUpload()` does `get_headers()` then `readfile()` on a client-supplied URL. The
   only guards are `strpos($imgUrl,"http") !== 0` and an extension test against the **URL string**
   (`?x=.png` defeats it). The Content-Type test is **inverted** —
   `|| stristr($heads['Content-Type'], "image")` errors on real images and passes everything else.
   **Verified:** an account with only `upload file with ueditor` fetched `http://web:80/robots.txt`
   (container-internal), and the body was written to
   `/sites/default/files/ueditor/…png` and read back **anonymously**. Reaches cloud metadata,
   internal admin UIs, any co-located service.
2. **Uploads bypass the managed-file pipeline.** All actions end at
   `FileSystem::saveData('public://'…)` — no `FileExtension` validator, no `.php` munging, no file
   entity, nothing in `file_managed`. The `lib/config.json` extension list is the only control.
3. `server()` calls `date_default_timezone_set("Asia/Chongqing")`, `error_reporting(E_ERROR)` and
   a raw `header()` on every request — process-global side effects that also mute the warnings the
   two findings above would otherwise raise.

Done correctly: the JSONP `callback` is validated with `preg_match("/^[\w_]+$/", …)`; `title`,
`original` and `source` go through `htmlspecialchars()`; both routes carry a permission.