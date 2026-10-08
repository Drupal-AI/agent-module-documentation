<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring External Script SRI

## Prerequisite: the script must live in a `libraries.yml`
The form only lists external `js` entries found in installed modules'/themes' `*.libraries.yml`
(paths starting `https://`, `http://`, or `//`). If your script is inline or hard-coded in a
Twig template, it will **not** appear. Move it into a library first, e.g.:

```yaml
# mytheme.libraries.yml
vendor_widget:
  js:
    https://cdn.example.com/widget@1.2.3/widget.min.js: { type: external, minified: true }
```

## Steps
1. Go to **Configuration → System → Sri Configuration**
   (`/admin/config/system/sri-configuration`). Requires the `administer external_script_sri`
   permission (`restrict access: true` — grant only to trusted admins).
2. Each discovered external script is a row (Module / Library / JS path are read-only).
3. Generate the SRI hash for that exact file yourself, e.g. at `https://www.srihash.org/`
   (the module does not fetch or hash anything server-side). Paste it into **SRI Hash value**.
   Format is `sha384-…` (or sha256/sha512).
4. Set **Crossorigin** — `anonymous` in almost all cases; `use-credentials` only if the asset is
   served with credentials and matching CORS headers. **This is mandatory**: without a working
   CORS-mode fetch the browser cannot verify the hash and the script fails to load.
5. Leave **Mark as Sensitive** unticked to *apply* SRI. Ticking it **excludes** the row from SRI
   injection (see quirk below).
6. Save. Values persist to `external_script_sri.sri_configuration.settings:js_library`.
7. Rebuild caches so libraries re-alter: `ddev drush cr`.

## Verify
- View source / DevTools on a page that loads the script; the tag should now read
  `<script src="…" integrity="sha384-…" crossorigin="anonymous">`.
- Inspect saved config: `ddev drush config:get external_script_sri.sri_configuration.settings`.
- If the script silently stops loading, the most common causes are: wrong/stale hash (upstream
  changed the file), missing CORS headers from the host, or `crossorigin` not set.

## The "Mark as Sensitive" quirk (important)
`hook_library_info_alter()` injects the integrity/crossorigin attributes **only when the row is
NOT marked sensitive**. So ticking "Mark as Sensitive" *removes* SRI from that script rather than
adding scrutiny. Use it as a deliberate exclude switch for fragile/dynamic CDN files that would
otherwise break under a pinned hash — not as a hardening option.

## Operational notes
- A hash pins one exact file. When a vendor ships a new build under the same URL the script will
  stop loading until you update the hash — pin **versioned** URLs and treat hash updates as a
  review checkpoint.
- SRI can be impractical for endpoints that return dynamically generated or per-request content;
  such scripts cannot be pinned and should be excluded.
- The config is exportable like any Drupal config, so hashes can be deployed across environments
  or a multisite via the normal config workflow.
