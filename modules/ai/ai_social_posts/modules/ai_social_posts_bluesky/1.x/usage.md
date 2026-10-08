<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Provides Bluesky integration for AI Social Posts — a submodule of AI Social Posts that installs the `bluesky_post` platform bundle.

---

Provides Bluesky integration for AI Social Posts. Enabling it registers the `bluesky_post` ("Bluesky Post") bundle of the `ai_social_post` content entity, with fields `post` and a Bluesky Post-tuned AI prompt default, plus the Maxlength-enforced character limit for the platform. Editors draft copy from a node's "Socials" tab or at /admin/content/ai-social-posts and refine it in the CKEditor AI Agent. The submodule is config (and, where present, a small client-side form helper) only; it does not authenticate to or post to the platform's API. Requires the `ai_social_posts` base module and `maxlength`.

---

- Enable to add the Bluesky Post bundle to AI Social Posts.
- Draft Bluesky Post copy from any node's "Socials" tab.
- Refine the copy with the CKEditor AI Agent toolbar button.
- Pre-seed the post body with the source node URL and a Bluesky Post prompt.
- Store finished posts under /admin/content/ai-social-posts.
- Add custom fields to the bluesky_post bundle via Field UI.
- Enforce the platform's character limit with Maxlength.
- Edit the bundle's prompt default to match your voice.
- Group Bluesky Post posts by their source node.
- Enable only alongside the ai_social_posts base module.
- Optionally enable brand-voice/sentiment analysis for the bundle.
- Keep the submodule disabled if you do not use this platform.
- Combine with other platform submodules for multi-channel drafts.
- Test the generated copy before using it on the platform.
