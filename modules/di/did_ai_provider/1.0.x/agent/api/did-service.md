<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# DidApiService (did_ai_provider.api)

Client for `https://api.d-id.com/`. Auth: HTTP Basic from the Key value (`explode(':', apiKey)` → user:pass), sent over HTTPS with default TLS verification. Long timeouts (`connect_timeout`/`read_timeout` 600s), `http_errors=false`.

## Key methods
- `generateVideoFromAudioAndImageSync($audioUrl, $imageUrl, $expression='neutral', $timeout=600)` — upload image+audio, create talk, poll to `result_url`.
- `generateVideoFromAudioAndImage(...)` / `...AndPresenter(...)` — async, returns the talk (poll later with `getTalk($id)`).
- `generateVideoFromAudioAndPresenterSync(...)` — presenter flow, polls to result.
- `uploadImage`/`uploadAudio` — multipart upload; `checkAndCreateTemporaryImage()` downscales images >1920x1080 or >1MB to a temp JPEG.
- `getPresenters()`/`getPresenterMap()` (cached 30 min)/`isValidPresenterId()`.
- `getTalk`/`getTalks`, `clipsFromAudioPresenter`/`getClip`.

## Configure
1. Store the D-ID key in **Key** (e.g. env or config provider).
2. `/admin/config/ai/di-ai-provider` → select that Key as `api_key`.
3. Add a file field for output; enable Automator **D-ID: Image + Audio → Video**; choose image+audio fields or a presenter and an expression.

## Cautions
Each call is billable and can block up to 600s. Restrict who can run automators.
