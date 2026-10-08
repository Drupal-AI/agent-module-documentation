<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# External Script SRI (external_script_sri) — agent index

Attaches **`integrity`** and **`crossorigin`** attributes to externally hosted `<script>` files
**that are already declared in some module/theme `*.libraries.yml`**. Config form at
`/admin/config/system/sri-configuration`; permission `administer external_script_sri`
(`restrict access: true`). Version **1.0.1**. Core `^9.5 || ^10 || ^11`. Package Security.
No dependencies, no Drush, no config schema, no submodules.

## What it actually does (read the source, not the tagline)
- **No arbitrary URLs, no server-side fetch.** The form does not accept typed-in script URLs and
  never downloads a script to compute a hash. `SriConfigurationForm::buildForm()` runs
  `ExtensionDiscovery` over all modules + themes, parses each `*.libraries.yml`, and keeps only
  `js` paths that begin with `https://`, `http://`, or `//`. Those rows are shown in a table with
  the JS-path field **disabled**; the admin fills in hash / crossorigin / sensitive per row.
- **Injection** is a single `hook_library_info_alter()` in `external_script_sri.module`: for each
  saved row it sets
  `$libraries[$library]['js'][$path]['attributes']['integrity']` = saved hash and
  `['attributes']['crossorigin']` = saved value. Drupal's asset renderer emits the attributes
  (values are HTML-escaped by core's `Attribute`/asset rendering).
- **"Mark as Sensitive" INVERTS protection.** The alter hook only injects when
  `mark_as_sensitive` is empty/false, so ticking it *removes* SRI from that script. It is an
  exclude toggle, not hardening. Document it that way.
- **Storage:** `submitForm()` saves the whole table into
  `external_script_sri.sri_configuration.settings:js_library` (an array of rows, each with
  `js_path`, `sri_hash`, `crossorigin`, `mark_as_sensitive`, `module_hidden`, `library_hidden`).
  Ships one config-install default: an empty `js_library`.

## Two operational facts that decide help-vs-break
1. **`crossorigin` is required for SRI to function** — the browser needs a CORS-mode fetch to read
   the response and the host must send permissive CORS headers, else the script **fails to load**.
2. **A hash pins one exact file.** Upstream publishes a new build under the same path → the script
   stops loading until the hash is refreshed. Pin **versioned URLs**; treat a hash update as a
   review step (that is the point). SRI can also break with dynamically generated CDN responses.

## Limits
- Only decorates scripts declared via `libraries.yml`. Inline scripts, or `<script>` hard-coded in
  a template, are invisible to it — move them into a library first.
- Generate hashes yourself (form help text links `srihash.org`). The module computes nothing.

## Files
- `external_script_sri.module` — `hook_library_info_alter()` (the injection).
- `src/Form/SriConfigurationForm.php` — discovery + table form + save.
- `external_script_sri.routing.yml`, `.permissions.yml` — route + gated permission.
- `external_script_sri.services.yml` — thin `Symfony\Component\Yaml\Yaml` service wrapper.
- `config/install/external_script_sri.sri_configuration.settings.yml` — empty `js_library` default.

## Solution types
- `agent/config/` — configuring and operating the SRI table.
