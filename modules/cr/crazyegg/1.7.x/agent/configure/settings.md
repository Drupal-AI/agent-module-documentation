<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure Crazy Egg

**Admin UI:** `/admin/config/system/crazyegg` (route `crazyegg.config`, form
`CrazyeggSettingsForm`, permission `administer crazy egg`). Menu link under
Configuration → System.

## Config object: `crazyegg.settings`

| Key | Type | Default | Meaning |
|---|---|---|---|
| `crazyegg_enabled` | integer | `1` | Master on/off. Script attaches only when `> 0`. |
| `crazyegg_account_id` | text | `''` | Your **numeric** Crazy Egg account number. Must be numeric or nothing loads. |
| `crazyegg_js_scope` | text | `'header'` | Where the `<script>` goes: `header` or `footer`. |
| `crazyegg_paths` | text | `''` | Drupal path-pattern list (one per line, `*` wildcards, `<front>`). Empty = every page. |
| `crazyegg_roles_excluded` | sequence of role ids | `[]` | Users in any listed role are NOT tracked. |

Read/write with drush:
```bash
drush cget crazyegg.settings
drush cset crazyegg.settings crazyegg_account_id 1234567 -y
drush cset crazyegg.settings crazyegg_js_scope footer -y
drush cset crazyegg.settings crazyegg_enabled 1 -y
```
Set excluded roles / paths (structured):
```bash
drush php:eval '\Drupal::configFactory()->getEditable("crazyegg.settings")
  ->set("crazyegg_paths", "/promo\n/landing/*")
  ->set("crazyegg_roles_excluded", ["administrator"])
  ->save();'
```

## Account id → script URL

`crazyegg_get_account_path()` left-pads the numeric id to 8 digits and splits it `NNNN/NNNN`:
- `1234567` → `01234567` → `0123/4567` → `https://script.crazyegg.com/pages/scripts/0123/4567.js`

The library `crazyegg/crazyegg` is built in `hook_library_info_build()` with this external, `async`,
minified script; `header: true` when `crazyegg_js_scope === 'header'`.

## When the snippet is injected

`hook_page_attachments()` attaches the library only if ALL hold:
1. `crazyegg_enabled > 0`,
2. a valid (numeric) `crazyegg_account_id` (else `crazyegg_get_account_path()` returns FALSE),
3. `crazyegg_is_page_allowed()` — current path matches `crazyegg_paths` (empty = always true, via
   `path.matcher`),
4. `crazyegg_is_role_allowed()` — current user is in none of `crazyegg_roles_excluded`.

The settings object is added as a cacheable dependency, so editing settings invalidates cached pages.
No config schema beyond `config/schema/crazyegg.schema.yml`; no plugins, no Drush commands.
