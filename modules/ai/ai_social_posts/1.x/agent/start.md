<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# AI Social Posts (ai_social_posts) — agent index

Content-authoring framework for AI-assisted social media copy. Adds a fieldable **`ai_social_post`**
content entity and a **`ai_social_post_type`** config bundle entity; each platform is a bundle
supplied by one of **16 submodules**. Editors draft platform-tuned copy from a node tab and refine it
with the **CKEditor AI Agent**. The module stores content only — it does **not** call any social-network
API and does not auto-publish. Version **1.0.0** (version dir `1.x`). Core `^10.3 || ^11.0`.

## Dependencies
- `drupal:filter`, `drupal:ckeditor5` (core)
- `ckeditor_ai_agent:ckeditor_ai_agent` — the in-editor AI toolbar button (`aiAgentButton`)
- `maxlength:maxlength` — per-platform character limits
- Suggested: `analyze`, `analyze_ai_brand_voice`, `analyze_ai_sentiment`

## What it provides
- **Entities:** `ai_social_post` (content, base table `ai_social_post`; base fields `node_id`,
  `user_id`, `created`, `changed`) and `ai_social_post_type` (config bundle; exports only `id`,
  `label`, `uuid`). Classes: `src/Entity/AiSocialPost.php`, `src/Entity/AiSocialPostType.php`.
- **Access:** `AiSocialPostAccessControlHandler` — admin permission `administer ai_social_post entity`
  grants all; otherwise per-op `view/edit/delete/add ai_social_post entity`.
- **Service:** `ai_social_posts.post_type_manager` (`AiSocialPostTypeManager::getTypes()`).
- **Controller:** `AiSocialPostController` — node tab (`nodeAiSocialPosts`, `nodeBundlePosts`),
  add page, title callbacks.
- **Dynamic routes:** `AiSocialPostRoutes::routes()` adds `ai_social_posts.node.<type>_posts` per bundle.
- **Config:** filter format + CKEditor5 editor `ai_social_posts` (see config doc).
- **Permissions:** 6 (`ai_social_posts.permissions.yml`).

## Solution docs
- [Entity, routes & access](api/entity.md) — the content model, routes, permissions, node integration.
- [Config: filter format & editor](config/settings.md) — the `ai_social_posts` format/editor and prompt defaults.
- [Platform submodules](../modules/) — one bundle per platform; each has its own doc set:
  reddit, newsletter, facebook, linkedin, linkedin_article, x, tiktok, youtube, youtube_shorts,
  substack, bluesky, hackernews, instagram_reels, instagram_story, medium, example.
