<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Social Posts adds a fieldable `ai_social_post` content entity and per-platform bundles so editors can draft AI-assisted, platform-tuned copies of a node's content from one admin interface.

---

AI Social Posts is a content-authoring framework, not a publishing bridge: it stores social copy as Drupal content entities and does not call any social-network API. Installing the base module registers the `ai_social_post` content entity and the `ai_social_post_type` bundle (config) entity; each platform submodule (X, LinkedIn, Facebook, Reddit, Medium, Substack, Bluesky, YouTube, Instagram, TikTok, Hacker News, newsletter, and more) installs a bundle with a platform-specific prompt default and character limit. From any node you get an "AI Social Posts" tab that opens a create form per platform, pre-seeding the post body with the node's absolute URL plus a platform prompt; the CKEditor AI Agent toolbar button then generates and refines the copy in the editor. Finished posts are saved, listed, and edited under `/admin/content/ai-social-posts`, keyed to their source node. All routes are admin routes gated by the module's own permissions, so only trusted editors can create, view, edit, or delete posts. Character limits per platform are enforced with the Maxlength module; brand-voice and sentiment analysis are optional via the Analyze submodules.

---

- Draft platform-specific social copy from any node via the "AI Social Posts" / "Socials" tab.
- Generate multiple platform variations from a single piece of content.
- Store social posts as first-class, fieldable content entities.
- Create standalone posts at `/admin/content/ai-social-posts/add`.
- Use the CKEditor AI Agent to Make Longer, Make Shorter, or Simplify Language.
- Summarize or continue-write post copy inline in the editor.
- Pre-seed a post with the source node's absolute URL and a platform prompt.
- Enforce per-platform character limits (280 for X, 300 for Bluesky) with Maxlength.
- Add a new platform by enabling a submodule bundle.
- Give each platform its own prompt default and field set.
- Add custom fields to any platform bundle through Field UI.
- Group posts by source node and by platform bundle.
- Restrict who can add, view, edit, or delete posts via permissions.
- Manage platform bundles at `/admin/structure/ai-social-post-types`.
- Repurpose existing site content into ready-to-copy social snippets.
- Reddit posts capture a target subreddit and inject its URL into the copy.
- Medium posts capture a tag and inject its feed URL.
- Hacker News, Medium, and Reddit posts include a topical vibe-check field.
- Optionally score brand-voice consistency with Analyze AI Brand Voice.
- Optionally run sentiment analysis with Analyze AI Sentiment.
- Build a content team workflow around platform-optimized drafts.
- Extend the framework with a custom bundle using the example submodule as a scaffold.
