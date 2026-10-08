# Configuration

AI Image Studio has one settings form plus the editorial workflow. This page
covers both.

## Open the settings form

1. Log in as a user with the **Administer AI Image Studio** permission.
2. Go to **Configuration → AI → AI Image Studio**, or navigate directly to
   `/admin/config/ai/image-studio`.

The form is grouped into the sections below. Sensible defaults are provided, so
you can enable the module and start generating before touching most of these.

## Storage

Where generated files are written.

- **File scheme** — the storage scheme, `private` by default. Private storage is
  recommended: generated files are then re-authorized on download so they are not
  publicly guessable.
- **File directory** — the subdirectory used, `ai-image-studio` by default. It is
  validated to block path-traversal (`..`) sequences.

## Limits

Guardrails on each session.

- **Max prompt length** — the largest prompt a user may submit (default 4000
  characters).
- **Max turns** — how many turns a single session may contain (default 25). This
  is the only built-in throttle on generation, so set it with cost in mind.
- **Max source image size (MB)** — the largest image a user may upload as a
  starting point for image-to-image or image-to-video (default 20).
- **Max video duration** — the longest video that may be requested (default 15).

## Defaults

The starting values offered to editors on each new turn — output type, aspect
ratio, image resolution, video resolution, video duration, image file type, and
whether a transparent background is used. There is also a **default model per
operation**: separate defaults for text-to-image, image-to-image, text-to-video
and image-to-video, chosen from the models your AI provider offers.

## AI badge

- **Show AI badge** — whether a small badge is burned into published derivatives
  by default (images via GD, video via ffmpeg).
- **AI badge text** — the label used on that badge.

## Cost display and warnings

Controls how much cost and usage information editors see, and when they are
warned.

- **Show costs / Show token usage / Show request metadata / Show session report**
  — toggles for the figures displayed alongside each turn and session.
- **Request cost warning / Session cost warning** — thresholds above which the
  studio flags that a single request, or a whole session, is getting expensive.

## Media publishing

Where finished turns are published.

- **Media bundle** and **Media source field** — the image media type and its image
  field (default `field_media_image`) that a published image is written into.
- **Require image alt text** — on by default; makes editors supply alt text before
  publishing an image, which keeps generated imagery accessible.
- **Video media bundle** and **Video media source field** — the equivalents for
  publishing generated video.

## Using the studio

1. An editor with **Access AI Image Studio** opens
   **Content → AI Image Studio** and starts a new session.
2. They enter a prompt; each submission runs a turn synchronously through the
   selected AI provider and model, and the result appears in the session.
3. They can refine across turns — for example feeding one image back in for an
   image-to-image edit, or branching from an earlier turn.
4. When a turn is right, they publish it into the configured media bundle
   (subject to the publish permissions), optionally with the AI badge.

## Notes

- Generated files default to `private://` and are re-authorized on download, so
  they are not publicly accessible without the right access.
- There is no rate limiting beyond **Max turns** per session, and session creation
  is unbounded — add **AI Budget Control** if you need hard spend limits.
- All model I/O is handled by the AI module; this module makes no direct HTTP
  calls and does not store or log provider keys.
