<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Social Posts - Hacker News (ai_social_posts_hackernews) — agent index

Submodule of **[ai_social_posts](../../../../1.x/agent/start.md)**. Provides Hacker News integration for AI Social Posts. Config-only package (no `src/`): it installs one bundle of the parent's `ai_social_post` content entity and does **not** call any platform API. Core `^10.3 || ^11.0`.

## Depends on
- `ai_social_posts:ai_social_posts` (the framework: entity, routes, permissions, editor)
- `maxlength:maxlength` (character limit)

## Provides
- **Bundle:** `hackernews_post` ("Hacker News Post") — `ai_social_posts.ai_social_post_type.hackernews_post` config.
- **Fields:** `post`, `title`, `hackernews_topic` (all using the `ai_social_posts` text format). It ships its own field storage(s): `field.storage.ai_social_post.hackernews_topic`.
- **Quirk:** Adds a `hackernews_topic` string field (its own `field.storage.ai_social_post.hackernews_topic`) plus `title` and `post`, with a prompt tuned for a Hacker News audience and a topical vibe check. `js/hackernews-form.js` reacts to the topic field to steer the drafted copy.
- **Form helper:** `js/hackernews-form.js` (attached via `hook_form_alter` to the bundle's entity form; steers the drafted copy client-side).
- **Install hook:** `hook_install` sets the module weight to 10 (after the base module); `hook_uninstall` deletes the `hackernews_post` bundle. (Unlike most sibling submodules it does not auto-enable the Analyze status.)

All CRUD, routes, access and the editor come from the parent — see its [entity & routes doc](../../../../1.x/agent/api/entity.md) and [config doc](../../../../1.x/agent/config/settings.md).
