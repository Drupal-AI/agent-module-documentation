<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
AI Image Studio is a chat-style workspace for generating and refining images and video through Drupal AI providers, then publishing chosen results to Media.

---

Each workspace is an owner-scoped `ai_image_studio_session` content entity; every prompt creates an `ai_image_studio_turn` that `ImageGenerator` runs synchronously through the `ai.provider` plugin manager using the `text_to_image`, `image_to_image`, `text_to_video` or `image_to_video` operation, chosen from the output type and whether a source image is supplied. Generated binaries are written to managed files (default `private://ai-image-studio/{session}/turn-{turn}.ext`) and referenced on the turn along with provider/model, timing, token usage and estimated cost. A completed turn can be published into a configured Media bundle/field (optionally burning an "AI" badge into a derivative via GD for images or ffmpeg for video), and a compact variant embeds into the Media / Media Library add forms.

Configuration lives at `/admin/config/ai/image-studio` (`ai_image_studio.settings`): file scheme/directory, prompt/turn caps (`max_prompt_length` 4000, `max_turns` 25), default models per operation, aspect ratio/resolution/duration defaults, cost-warning thresholds, and the Media bundle + source field for image and video publishing. Access is owner-based: `SessionAccessControlHandler` grants view/update/delete to the session owner holding `access ai image studio` (or the `view any` / `delete any` overrides); private generated files are re-authorized on download via `hook_file_download`. Security posture is solid — no anonymous or unauthenticated generation route, no disabled TLS (all provider I/O is delegated to `drupal/ai`), no user-controlled file paths (destinations use integer session/turn ids), and no API keys logged. The main residual is cost governance: `access ai image studio` is not restrict-access and there is no rate limiting beyond `max_turns` per session while session creation is unbounded — pair it with AI Budget Control for spend limits.

---
- Generate an image from a text prompt in a studio session.
- Refine a generated image with a follow-up prompt (image-to-image).
- Generate video from a text prompt or a source image.
- Iterate across multiple turns within one session.
- Branch a turn from a previous turn (parent reference).
- Publish a chosen image into a Media entity/bundle.
- Publish generated video into a video Media bundle.
- Burn an "AI" badge into the published derivative (image via GD, video via ffmpeg).
- Embed the compact generator into the Media Library add form.
- Set default models per operation type in settings.
- Cap prompt length and turns per session.
- Choose default aspect ratio, resolution and video duration.
- Store generated files privately under `private://ai-image-studio`.
- Track per-turn cost, token usage and generation time.
- Warn when a request or session exceeds a cost threshold.
- Restrict sessions to their owner (view/update/delete owner-scoped).
- Grant `view any` / `delete any` to moderators as needed.
- Require alt text before publishing an image to Media.
- Archive or delete old studio sessions.
- List all sessions at `/admin/content/ai-image-studio`.
- Combine with AI Budget Control to bound generation spend.
