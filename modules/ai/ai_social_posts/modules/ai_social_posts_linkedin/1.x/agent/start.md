<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Social Posts - LinkedIn (ai_social_posts_linkedin) — agent index

Submodule of **[ai_social_posts](../../../../1.x/agent/start.md)**. Provides LinkedIn integration for AI Social Posts. Config-only package (no `src/`): it installs one bundle of the parent's `ai_social_post` content entity and does **not** call any platform API. Core `^10.3 || ^11.0`.

## Depends on
- `ai_social_posts:ai_social_posts` (the framework: entity, routes, permissions, editor)
- `maxlength:maxlength` (character limit)

## Provides
- **Bundle:** `linkedin_post` ("LinkedIn Post") — `ai_social_posts.ai_social_post_type.linkedin_post` config.
- **Fields:** `post` (all using the `ai_social_posts` text format).
- **Quirk:** Single `post` body with a professional-networking prompt for LinkedIn feed posts.
- **Install hook:** enables the Analyze brand-voice / sentiment status for this bundle when those modules are present.

All CRUD, routes, access and the editor come from the parent — see its [entity & routes doc](../../../../1.x/agent/api/entity.md) and [config doc](../../../../1.x/agent/config/settings.md).
