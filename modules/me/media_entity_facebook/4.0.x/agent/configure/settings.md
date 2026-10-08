<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure — settings & media type setup

## Settings form

Route `media_entity_facebook.settings` → `/admin/config/media/facebook-settings` (`FacebookSettingsForm`, permission `administer media`). Note: `configure` is not declared in `media_entity_facebook.info.yml`, so the module page has no "Configure" link; navigate to the path or the route directly. Link also added under Configuration → Media via `media_entity_facebook.links.menu.yml`.

Config object `media_entity_facebook.settings` (schema in `config/schema/`, defaults in `config/install/`):

| Key | Default | Meaning |
|---|---|---|
| `facebook_app_id` | `''` | Facebook App ID; only used in oEmbed API mode. |
| `facebook_app_secret` | `''` | Facebook App secret; joined as `app_id|app_secret` into the oEmbed access token. |
| `use_embedded_posts` | `true` | `true` = JS-SDK "Embedded Posts" (no app review). `false` = server-side oEmbed Graph API (needs a reviewed app + credentials). Clear cache after changing. |

Set via drush:

```bash
drush config:set media_entity_facebook.settings use_embedded_posts false -y
drush config:set media_entity_facebook.settings facebook_app_id '<id>' -y
drush config:set media_entity_facebook.settings facebook_app_secret '<secret>' -y
drush cr
```

In **Embedded Posts** mode (default) no credentials are needed; missing app id/secret only matters in oEmbed mode (the fetcher logs an error and returns FALSE if either is empty).

## Creating the media type

The module ships no media type — create one and select the `facebook` source:

```bash
# Via UI: /admin/structure/media/add → Media source: "Facebook".
```

- Selecting the `facebook` source creates/uses a `string_long` source field (editors paste a Facebook URL or an `<iframe>` embed).
- `prepareViewDisplay()` auto-sets the `facebook_embed` formatter on the source field (label visually hidden).
- Map metadata (author name, width, height, url, html) to media fields as needed via *Manage fields* / the source's field mapping.
- The `FacebookEmbedCode` constraint is added to the source field, rejecting values that don't resolve to `facebook.com`/`fb.watch`.

## Media Library

The source declares a `media_library_add` form (`FacebookMediaLibraryAddForm`), so once a Facebook media type exists editors can add Facebook media inside the core Media Library modal via a single textarea (the source field).
