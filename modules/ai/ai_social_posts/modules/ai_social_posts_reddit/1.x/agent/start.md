<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Social Posts - Reddit (ai_social_posts_reddit) — agent index

Submodule of **[ai_social_posts](../../../../1.x/agent/start.md)**. Provides Reddit integration for AI Social Posts. Config-only package (no `src/`): it installs one bundle of the parent's `ai_social_post` content entity and does **not** call any platform API. Core `^10.3 || ^11.0`.

## Depends on
- `ai_social_posts:ai_social_posts` (the framework: entity, routes, permissions, editor)
- `maxlength:maxlength` (character limit)

## Provides
- **Bundle:** `reddit_post` ("Reddit Post") — `ai_social_posts.ai_social_post_type.reddit_post` config.
- **Fields:** `post`, `title`, `subreddit` (all using the `ai_social_posts` text format). It ships its own field storage(s): `field.storage.ai_social_post.subreddit`.
- **Quirk:** Adds a required `subreddit` string field (its own `field.storage.ai_social_post.subreddit`) plus `title` and a `post` body whose prompt asks for a topical "vibe check" against the subreddit. The `js/reddit-form.js` behavior watches the subreddit input and, once CKEditor 5 has loaded, rewrites the title/post editor content to reference `https://reddit.com/r/<subreddit>` so the drafted copy targets the chosen subreddit.
- **Form helper:** `js/reddit-form.js` (attached via `hook_form_alter` to the bundle's entity form; steers the drafted copy client-side).
- **Install hook:** enables the Analyze brand-voice / sentiment status for this bundle when those modules are present.

All CRUD, routes, access and the editor come from the parent — see its [entity & routes doc](../../../../1.x/agent/api/entity.md) and [config doc](../../../../1.x/agent/config/settings.md).
