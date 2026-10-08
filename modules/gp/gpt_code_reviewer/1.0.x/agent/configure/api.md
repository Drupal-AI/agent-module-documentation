<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring GPT code reviewer

## Settings
`/admin/config/services/gpt_code_reviewer/settings` (`administer gpt_code_reviewer`):
- **GPT Code Reviewer API server** — URL the code is POSTed to.
- **OpenAI API key** — required. Stored in `gpt_code_reviewer.settings:openai_api_key` as plaintext
  config and rendered in a plain textfield; anyone with this settings permission can read it. There is
  no Key-module integration — treat the settings page as secret-bearing.
- **Model** — gpt-3.5-turbo / gpt-4 / gpt-4-turbo.
- **Timeout** — 600–1800 seconds.

## How a review runs
`ReviewService::review()` JSON-encodes the params + key + model and Guzzle-`post()`s them to the
configured server, then decodes the JSON reply and saves it as a `Review` entity. TLS verification is
left at Guzzle's default (enabled); the destination host is whatever the admin configured.

## Permissions / cost control
Creating a review is an outbound paid API call. Gate it with `add gpt_code_reviewer review` (off for
anonymous by default); use `view/edit/delete/list gpt_code_reviewer review` for the rest. Grant `add`
only to trusted roles to avoid uncontrolled API spend.
