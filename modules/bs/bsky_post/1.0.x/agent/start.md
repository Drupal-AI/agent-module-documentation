<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bluesky Post (bsky_post) — agent index

UI layer over the **bsky** (Bluesky Integration) module. Adds a **"Share to Bluesky"** local task on selected node types; the tab's form posts the node's title + summary + link to Bluesky (AT Protocol) via bsky's post service and the vendored `potibm/phluesky` library. Version 1.0.0-alpha3. Core `^10 || ^11`, PHP `>=8.1`. No automatic posting — editor-initiated only.

## Dependencies
- `bsky` (drupal/bsky) — holds the Bluesky handle + app-password credential (via the Key module) and does all HTTP to Bluesky. bsky_post stores **no** credentials.

## What it provides
- **Routes** (`bsky_post.routing.yml`):
  - `bsky_post.tab` → `/node/{node}/bsky`, form `BskyPostForm`, perm `post to bluesky`.
  - `bsky_post.settings` → `/admin/config/services/bsky-post-settings`, form `BskyPostSettingsForm`, perm `administer bsky_post configuration`.
- **Permissions** (`bsky_post.permissions.yml`): `administer bsky_post configuration`, `post to bluesky`.
- **Config**: `bsky_post.settings` (key `types` = selected node bundles). Schema in `config/schema/bsky_post.schema.yml`.
- **Service** (`bsky_post.services.yml`): `bsky_post.bsky_post` = `Drupal\bsky_post\BskyPost` (wraps `@bsky.post_service`); route subscriber `bsky_post.subscriber`; hook class `BskyPostHooks`.
- **Local task / menu**: `bsky_post.links.task.yml` (tab on `entity.node.canonical`), `bsky_post.links.menu.yml` (settings link).
- **Route subscriber** `BskyPostRouteSubscriber`: restricts the `{node}` bundle of `bsky_post.tab` to the configured content types.

## Solution docs
- [Configuration & content-type selection](config/settings.md)
- [Posting flow & the BskyPost service](api/posting.md)
