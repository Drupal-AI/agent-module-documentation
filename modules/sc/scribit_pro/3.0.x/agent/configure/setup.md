<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Setting up Scribit.pro

## 1. Store the API token (Key module)
1. `Administration > Configuration > System > Keys` → **Add key**.
2. Type *Authentication*; paste your Scribit.pro API token (from your Scribit.pro account).

## 2. Configure the module
Route `scribit_pro.config` → `/admin/config/system/scribit-pro`
(permission: **`administer scribit pro`**). Config object `scribit_pro.config`:
- `scribit_id` — your Scribit ID.
- `api_token` — select the Key created above.

## 3. Remote Video media type
If you don't already have one: `Structure > Media types > Add media type`, source
**Remote video**, save.

## 4. Form display + display
- **Manage form display**: set *Remote video URL* widget to **Scribit Pro oEmbed URL**
  (`scribit_pro_widget`). Editors then pick services (subtitles, audio description,
  transcript, sign language), voice gender/language, urgency and remarks.
- **Manage display**: set *Remote video URL* formatter to **Scribit Pro formatter**
  (`scribit_pro_formatter`; settings `max_width`, `max_height`).

## 5. Submission flow
Saving a Remote Video media entity submits the video + requested services to the
Scribit.pro API (`ApiService`, authenticated Bearer token, 30s cURL timeout). The widget
guards against duplicate submissions per request. Once Scribit.pro finishes processing,
the formatter renders the accessible player.

## Routes
- `scribit_pro.config` — admin form (permission-gated).
- `scribit_pro.callback` `/scribit-pro/callback` — public (`_access: 'TRUE'`), intended for
  Scribit.pro's server. **Currently an unimplemented stub** that redirects to `<front>` and
  changes no state; a real implementation must validate the request origin/signature.
