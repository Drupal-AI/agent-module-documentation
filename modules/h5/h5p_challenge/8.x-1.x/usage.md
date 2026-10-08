<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
H5P Challenge attaches a challenge button to any H5P content so users can create a code-joined competition, submit xAPI scores, and view result leaderboards.
---
When enabled, the module injects a challenge action beneath every rendered H5P library view. Any user can start a challenge for a piece of H5P content; challenge creation is protected by Google reCAPTCHA (verified server-side against `https://www.google.com/recaptcha/api/siteverify`) and sends an email notification to the creator. Participants join with a challenge code, play the H5P content, and the module records their xAPI results into its own `h5p_challenge` and `h5p_challenge_points` tables (mirroring how core H5P stores results). Cron drives clean-up and the "challenge ended" notification (attachments are possible via Mail System + Mime Mail). Results are viewable per challenge (`/h5p_challenge/{challenge}/results`, with a CSV export), authenticated users see their own at `/h5p_challenge/mine`, and admins get a report list at `/admin/reports/h5p_challenge`.

Setup: install alongside the `h5p` module, visit **Configuration → System → H5P Challenge** (`/admin/config/system/h5p_challenge`, permission *access administration pages*) to set reCAPTCHA keys, durations and notification options, and ensure cron runs hourly. The optional **h5p_challenge_rest** submodule (requires core `rest`) exposes read REST resources for challenge/points data (canonical URIs like `api/h5p_challenge/challenge/{uuid}/results`) with pagination and from/until filtering. Access: the JSON gameplay endpoints (`create-new.json`, `start-playing.json`, `set-finished.json`, `settings.json`, results) are declared `_access: 'TRUE'` (anonymous) because gameplay happens in the H5P iframe; they require a non-empty `token` GET param and operate on a challenge UUID. Admin/report/config routes are permission-gated.
---
- Install with the `h5p` module and enable H5P content types on the site.
- Configure reCAPTCHA keys and notifications at `/admin/config/system/h5p_challenge`.
- Ensure cron runs hourly for ended-challenge notices and clean-up.
- Create a challenge from any H5P content view (reCAPTCHA-protected).
- Share the generated challenge code with participants.
- Let participants join via `start-playing.json` and play the H5P content.
- Store xAPI scores through `set-finished.json` as players complete content.
- View a challenge leaderboard at `/h5p_challenge/{challenge}/results`.
- Export challenge results as CSV at `/h5p_challenge/{challenge}/results/csv`.
- Let logged-in users review their challenges at `/h5p_challenge/mine`.
- Browse all challenges as an admin at `/admin/reports/h5p_challenge`.
- End a challenge early via `/h5p_challenge/{challenge}/end`.
- Delete a challenge via `/h5p_challenge/{challenge}/delete`.
- Send result/attachment emails via Mail System + Mime Mail (plain text).
- Enable the `h5p_challenge_rest` submodule for RESTful result access.
- Fetch paginated challenge results over REST (`api/h5p_challenge/challenge/{uuid}/results`) with from/until filters.
- List a user's challenges or points via the REST resources.
- Use xAPI event capture identical to core H5P result storage.
- Run challenges in both internal and external (iframe) H5P contexts.
