<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Scribit.pro integrates the external Scribit.pro accessible-video platform with Drupal: editors submit a YouTube or Vimeo video from a media entity, request accessibility services (subtitles, audio description, transcript, sign language), and the processed accessible player is rendered on the front end.

---

The module adds a field widget (`ScribitProWidget`, "Scribit Pro oEmbed URL") and formatter (`ScribitProFormatter`) for Remote Video media, backed by an `ApiService` (talks to the Scribit.pro API with an authenticated Bearer token) and a `HelperService` (extracts YouTube/Vimeo IDs, builds Pro-Services requests). API credentials use the **Key** module: a Scribit ID plus an API-token Key are set on the admin config form `scribit_pro.config` at `/admin/config/system/scribit-pro`, gated by the module's own `administer scribit pro` permission. When an editor saves a Remote Video media entity, the widget submits the video and the requested services to Scribit.pro; once processed, the formatter shows the accessible player.

Two routes exist: the admin config form (permission-gated) and a public callback `scribit_pro.callback` at `/scribit-pro/callback` (`_access: 'TRUE'`, no-cache) that Scribit.pro's server is meant to hit after processing. **This callback is an unimplemented stub** — `Callback::execute()` only builds a `RedirectResponse` to `<front>` inside a render context and returns it (its `@todo handle the callback` is unfulfilled), so it performs no state change and is effectively inert; the route already carries a comment that a real implementation must validate the request origin/signature. The module was previously security-reviewed (v2.0.1 changelog: fixed empty-Bearer `isset(FALSE)` bug, tightened the callback route, set a 30s cURL timeout, removed response `var_export` from user messages, escaped API strings in the status report). Setup: install Key, enable the module, create an authentication Key for the API token, set the Scribit ID + token on the config form, then configure a Remote Video media type's form display (Scribit widget) and display (Scribit formatter).
---
- Submit a YouTube video to Scribit.pro for accessibility processing
- Submit a Vimeo video to Scribit.pro for accessibility processing
- Request subtitles for an editorial video
- Request an audio-description track for a video
- Request a transcript for a video
- Request a sign-language track for a video
- Choose the desired voice gender and language for services
- Mark an accessibility request as urgent
- Add remarks for the Scribit.pro team with a request
- Render the processed accessible player via the Scribit formatter
- Store the API token securely as a Key entity
- Configure the Scribit ID and API token on the admin config form
- Set the Scribit Pro oEmbed URL widget on a Remote Video media form display
- Set the Scribit Pro formatter on a Remote Video media display
- Restrict configuration to holders of `administer scribit pro`
- Add accessibility features to existing remote-video media
- Provide WCAG-oriented video accessibility without in-house captioning
- Limit outbound API calls with the built-in 30s cURL timeout
- Avoid duplicate submissions via the widget's per-request guard
- Manage Scribit configuration from the System configuration menu
