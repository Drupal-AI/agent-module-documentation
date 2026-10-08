<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Social Auth Modal — agent index

Lets **social login (Social Auth) happen inside a modal window** (vs full-page redirect). Depends on
`social_auth`. Version **2.0.0**. Core `^9||^10||^11`.

Authentication-UX wrapper — the **OAuth flow (state check + token exchange) is handled by the Social Auth
framework/provider**; this only changes presentation. Security rests on the provider config. No access role of
its own.
