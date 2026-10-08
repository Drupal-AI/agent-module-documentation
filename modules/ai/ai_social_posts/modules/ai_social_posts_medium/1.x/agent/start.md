<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Social Posts - Medium (ai_social_posts_medium) — agent index

Submodule of **[ai_social_posts](../../../../1.x/agent/start.md)**. Provides Medium integration for AI Social Posts. Config-only package (no `src/`): it installs one bundle of the parent's `ai_social_post` content entity and does **not** call any platform API. Core `^10.3 || ^11.0`.

## Depends on
- `ai_social_posts:ai_social_posts` (the framework: entity, routes, permissions, editor)
- `maxlength:maxlength` (character limit)

## Provides
- **Bundle:** `medium_post` ("Medium Post") — `ai_social_posts.ai_social_post_type.medium_post` config.
- **Fields:** `post`, `title`, `subtitle`, `medium_tag` (all using the `ai_social_posts` text format). It ships its own field storage(s): `field.storage.ai_social_post.medium_tag`.
- **Quirk:** Long-form article bundle: `title`, `subtitle`, a rich `post` body, and a `medium_tag` string field (its own `field.storage.ai_social_post.medium_tag`) with a topical vibe check. `js/medium-form.js` injects `https://medium.com/feed/tag/<tag>` into the copy when the tag field changes.
- **Form helper:** `js/medium-form.js` (attached via `hook_form_alter` to the bundle's entity form; steers the drafted copy client-side).
- **Install hook:** enables the Analyze brand-voice / sentiment status for this bundle when those modules are present.

All CRUD, routes, access and the editor come from the parent — see its [entity & routes doc](../../../../1.x/agent/api/entity.md) and [config doc](../../../../1.x/agent/config/settings.md).
