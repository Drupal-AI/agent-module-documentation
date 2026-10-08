<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Social Posts - Example (ai_social_posts_example) — agent index

Submodule of **[ai_social_posts](../../../../1.x/agent/start.md)**. Example implementation of a custom social network for AI Social Posts. Config-only package (no `src/`): it installs one bundle of the parent's `ai_social_post` content entity and does **not** call any platform API. Core `^10.3 || ^11.0`.

## Depends on
- `ai_social_posts:ai_social_posts` (the framework: entity, routes, permissions, editor)
- `maxlength:maxlength` (character limit)

## Provides
- **Bundle:** `example_post` ("Example Post") — `ai_social_posts.ai_social_post_type.example_post` config.
- **Fields:** `post`, `title` (all using the `ai_social_posts` text format).
- **Quirk:** Hidden (`hidden: true`) scaffold showing how to add a custom platform: it installs an `example_post` bundle with `title` and `post` fields and a sample prompt. Copy it to build your own platform bundle.
- **No install hook.** Hidden module (`hidden: true`) meant as a copy-paste scaffold for a custom platform.

All CRUD, routes, access and the editor come from the parent — see its [entity & routes doc](../../../../1.x/agent/api/entity.md) and [config doc](../../../../1.x/agent/config/settings.md).
