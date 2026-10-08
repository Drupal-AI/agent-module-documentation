<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# GPT code reviewer (gpt_code_reviewer) — agent index
**Posts code to an OpenAI-backed API and stores the reply as a Review entity.**

- **Version:** 1.0.x (dev-1.x checkout; 1.0.0-alpha1 tag)
- **Core:** ^10 || ^11
- **Configure:** `gpt_code_reviewer.settings` (/admin/config/services/gpt_code_reviewer/settings, `administer gpt_code_reviewer`)
- **Entity:** `Review` (own access handler); rendered by `ReviewResultFormatter`; bundled View
- **Service:** `ReviewService::review()` — Guzzle POST to configured server
- **Permissions:** `administer/add/view/edit/delete/list gpt_code_reviewer review`

**Security:** settings are admin-gated; creating a review (a paid outbound LLM call) requires `add gpt_code_reviewer review`, not granted to anonymous by default, so there is no anonymous cost-abuse path out of the box — but any role granted that permission can drive paid calls. Observations for reviewers: the OpenAI API key is stored in **plaintext** config and shown in a plain textfield (`GptCodeReviewerAdminSettings.php:48-52`, `ReviewService.php:54`) — not a Key entity; the request goes to an admin-set server URL over Guzzle with TLS verification left at Guzzle's default (not disabled).

See [configure/api.md](configure/api.md).
