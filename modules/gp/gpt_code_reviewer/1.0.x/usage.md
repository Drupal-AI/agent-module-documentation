<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GPT code reviewer sends code to an OpenAI-backed HTTP API and stores the model's feedback as a `Review` content entity, listed and displayed through a bundled View and a custom field formatter.

---

An admin configures the API at `/admin/config/services/gpt_code_reviewer/settings` (`administer gpt_code_reviewer`): the API server URL, an OpenAI API key, the model (gpt-3.5-turbo / gpt-4 / gpt-4-turbo) and a request timeout (600–1800s). The `ReviewService` (`review()`) posts the code plus the key and model as JSON to the configured server via Guzzle and decodes the JSON response; the returned review is saved as a Review entity. Review entities have their own access handler with a full permission set — `add`, `view`, `edit`, `delete`, `list gpt_code_reviewer review` — so an admin decides which roles may create reviews (and therefore trigger paid API calls). The result is rendered by `ReviewResultFormatter` with its own CSS/JS. Because each review is an outbound call to a paid LLM endpoint, creation is a cost-bearing action gated behind the `add gpt_code_reviewer review` permission (not granted to anonymous by default).

Two operational notes worth flagging on setup: the OpenAI API key is stored in plain config (`gpt_code_reviewer.settings:openai_api_key`) and shown in a plain textfield on the settings form — it is not a Key entity, so anyone with the settings permission can read it; and the target API server is an admin-set URL to which the key is sent. Typical setup: enter server/key/model, grant `add gpt_code_reviewer review` to trusted roles, then create reviews and read results.
---
- Review a block of code with an OpenAI model
- Store each review result as a `Review` entity
- List past reviews through the bundled View
- Display a review with the custom result field formatter
- Configure the OpenAI API key and server URL
- Choose the model (gpt-3.5-turbo, gpt-4, gpt-4-turbo)
- Set the API request timeout (600–1800s)
- Grant `add gpt_code_reviewer review` to allow triggering reviews
- Restrict who can view reviews with `view gpt_code_reviewer review`
- Restrict editing/deleting reviews with dedicated permissions
- Keep an audit trail of code-review feedback as content
- Point the module at a self-hosted GPT proxy server
- Integrate AI code feedback into an editorial workflow
- Style review output via the shipped CSS/JS library
- Administer settings at /admin/config/services/gpt_code_reviewer/settings
- Review contributed-module code before deployment
- Surface reviews in an admin listing for triage
