<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Config: text format, CKEditor editor & prompt defaults

The base module ships four `config/install` objects plus per-bundle field storages. There is **no**
`config/schema` directory and **no** runtime settings object — `provides_config_schema` is false and the
settings form is a stub.

## Text format & editor (`config/install/`)
- `filter.format.ai_social_posts.yml` — format id `ai_social_posts` ("AI Social Posts"), enforced-dep on
  the module. Single filter `filter_html` allowing **only `<br> <p>`** (`filter_html_help: true`,
  `filter_html_nofollow: false`). All post bodies use this format, so stored/AI-generated markup is
  reduced to those tags when rendered through `processed_text`.
- `editor.editor.ai_social_posts.yml` — CKEditor 5 bound to that format. Toolbar:
  `aiAgentButton`, `removeFormat`, `undo`, `redo`. Plugin `ckeditor_ai_agent_ai_agent` config keys
  (`api_key`, `model`, `endpoint_url`, `temperature`, `max_tokens`, `timeout_duration`,
  `retry_attempts`, `debug_mode`, `stream_content`) are all `null` here — the AI Agent module supplies
  its own configured provider/key. `image_upload.status: false`.

## Base field storages (`config/install/field.storage.ai_social_post.*`)
`post`, `title`, `subtitle` field storages on the `ai_social_post` entity. Platform submodules attach
`field.field.*` instances of these (and add their own storages, e.g. `subreddit`, `medium_tag`,
`hackernews_topic`) to their bundle, each with a platform-tuned prompt in `default_value` and
`allowed_formats: [ai_social_posts]`.

### Prompt-default pattern
Each bundle's `post` field `default_value` is a slash-prefixed instruction, e.g. Bluesky:
`"/Write a Bluesky post that: … Stays under 300 characters …"`. `AiSocialPost::preCreate()` rewrites
this default at create-time into `"/For <node-url> <prompt>. Include the link."` so the editor opens
pre-seeded. Edit the field's default value (Field UI, `entity.ai_social_post_type.edit_form`) to change
a platform's generation prompt.

## Character limits
Enforced by the **Maxlength** module via the bundle's form display widget settings
(`core.entity_form_display.ai_social_post.<bundle>.default.yml`), not by a module setting.

## Optional analysis wiring
Each submodule's `hook_install` (e.g. `ai_social_posts_reddit_install`) sets, if the Analyze submodules
are present, `analyze.settings:status.ai_social_post.<bundle>.brand_voice_analyzer|ai_sentiment_analyzer`
to TRUE — enabling the Analyze tabs for that bundle.

## Operate
1. `drush en ai_social_posts` + the platform submodules you want (e.g. `ai_social_posts_x`).
2. Bundles register automatically; manage at `/admin/structure/ai-social-post-types` and via Field UI.
3. Create posts from a node's "Socials" tab or at `/admin/content/ai-social-posts/add`.
4. Grant `add/view/edit/delete ai_social_post entity` to your editor role.
