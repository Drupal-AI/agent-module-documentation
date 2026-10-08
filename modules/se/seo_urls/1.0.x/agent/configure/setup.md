<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# SEO Urls — configure

## 1. Choose eligible entity types
`/admin/structure/seo_url` (`SeoUrlSettingsForm`, perm `administer seo_url entities`) → set `allowed_content_types`. Only these entity types can have SEO URLs and expose the token.

## 2. Create mappings
- List/manage: `/admin/content/seo_url` (perms `view seo_url entities` / `view own seo_url entities`).
- Add: `/admin/seo_url/add` — set the **canonical URL** (the real, parameterized path, stored as an `internal:` link) and the **SEO URL** (the clean path). Requires create access on `seo_url`.
- Quicker: open the target page and click **Create SEO URL** in the admin toolbar — the canonical field is pre-filled from the current redirect destination (`SeoUrlCreateController::addForm`).
- Toggle a mapping on/off with its `status` flag; duplicates are blocked by the `UniqueLink` constraint.

## 3. Use the token in metatags
`/admin/config/search/metatag` → set the canonical tag to `[<entity_type>:seo-url]`. `SeoUrlManager::getSeoUrlToken()` returns the SEO URL when the current path matches a mapping, else the normal canonical.

## How resolution works
- Inbound `SeoUrlPathProcessor::processInbound` → `SeoUrlManager::getCanonicalUrlBySeoUrl()` rewrites the SEO path to the canonical internal path and re-adds the canonical query args.
- Outbound `processOutbound` → `getSeoUrlByCanonicalUrl()`; a leading `//` is collapsed to `/` to avoid protocol-relative external URLs.
- Enable the `seo_urls_views` submodule to also map view page paths.

## Permissions
`administer seo_url entities` (restricted) for config; granular `view/add/update/delete` `any`/`own` permissions for editors.
