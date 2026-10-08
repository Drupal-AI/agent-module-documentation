<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
D-ID AI Provider plugs the D-ID talking-head video service into the AI module and AI Automators.

---

It registers an AI provider plugin and an AI Automator type (*Image + Audio → Video*). Given an audio file and either a still image or a chosen D-ID presenter, the `DidApiService` uploads the assets to `https://api.d-id.com`, creates a talk/clip, polls until the result URL is ready, and stores the finished MP4 in Drupal (`public://did_videos`). Editors configure whether to use an image field plus audio field or a stock presenter, and can pick a facial expression (neutral/happy/surprised/serious/angry/sad).

Security and cost notes: the D-ID API credential is read through the **Key module** (config `did_ai_provider.settings:api_key` → Key entity), not hardcoded, and is sent as HTTP Basic auth over HTTPS to `api.d-id.com` with TLS verification left at Guzzle defaults (enabled) — no disabled-TLS. The only route is the settings form gated by `administer ai providers`. Because generation runs from a content automator on save and each talk is a paid, long-polling (up to 600s) request, treat it as a cost-sensitive integration: restrict who can trigger automators. Setup: store the D-ID key via Key, set it on the provider settings form, add a file field for output, and enable the automator on the field.

---
- Generate a talking-head video from an audio clip and a portrait image.
- Generate a video from audio plus a D-ID stock presenter (no image).
- Store the resulting MP4 automatically in `public://did_videos`.
- Choose a facial expression preset for the avatar.
- Drive generation from an AI Automator on content save.
- Store the D-ID API key securely via the Key module.
- Configure the provider at `/admin/config/ai/di-ai-provider`.
- Poll synchronously until a result URL is ready (bounded timeout).
- Kick off async generation and fetch the talk later by id.
- List available D-ID presenters (cached 30 min).
- Validate a presenter id before submitting a job.
- Auto-resize oversized images before upload (>1920x1080 or >1MB).
- Reduce audio noise on generated talks.
- Stitch frames for smoother output.
- Replace the deprecated AI-Interpolator-based D-ID module.
- Restrict provider configuration to `administer ai providers`.
- Attach generated video to a node's file field.
- Budget for paid, long-running D-ID API calls per generation.
