OpenAI Prompt Completion Explorer adds a simple admin form where you type a prompt, pick a model and
parameters, and get a text completion back from OpenAI — a ChatGPT-like scratchpad built on the
completions endpoint. It is meant for experimentation and quick testing of the OpenAI text generator
from inside Drupal.

---

The module provides one form at `/admin/config/openai/openai-prompt` (`PromptForm`), gated by the
`access openai prompt` permission. It exposes a prompt textarea plus model, temperature and
max-tokens options; the model list comes from the parent `openai.api` service's `filterModels(['text'])`,
defaulting to `text-davinci-003`. On submit (AJAX) it calls `OpenAIApi::completions()` and shows the
trimmed answer in a read-only textarea; token limits are validated per model. It has no configuration
object, permissions beyond its access permission, or Drush commands, and relies on the parent OpenAI
module for the API key/service. Because it targets the legacy completions endpoint and text models,
it is primarily a testing/exploration tool rather than a production content feature.

---

- Quickly test how OpenAI responds to a given prompt.
- Experiment with temperature to tune creativity vs determinism.
- Compare completions across available text models.
- Draft short copy snippets for reuse elsewhere.
- Check token-limit behavior for a model before coding against it.
- Prototype prompt wording for another integration.
- Give admins an in-Drupal prompt scratchpad.
- Validate that the OpenAI API key/connection works.
- Generate quick text ideas during content work.
- Explore model capabilities without external tools.
- Test max-token limits and truncation behavior.
- Produce sample completions for documentation.
- Evaluate response latency for planning UX.
- Try instruction-style prompts against text models.
- Demonstrate OpenAI text generation to stakeholders.
- Brainstorm headlines or summaries interactively.
- Sanity-check prompt outputs before automating them.
- Teach editors how prompt phrasing affects output.
- Generate throwaway text for QA/testing.
- Confirm model availability on the account.
