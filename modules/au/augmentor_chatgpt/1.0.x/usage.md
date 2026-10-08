A ChatGPT (OpenAI chat-completions) backend plugin for the Augmentor framework.

---

ChatGPT Augmentor registers a single Augmentor plugin (`chatgpt`) that sends a configurable list of chat messages to OpenAI's chat-completion endpoint and returns the model's reply as augmentor output. Each augmentor instance is a config entity administered through Augmentor's own UI (`administer augmentors` permission); there are no routes, permissions, services, or config schema of its own. The plugin stores per-instance settings — model, ordered `system`/`assistant`/`user` messages (with an `{input}` placeholder), temperature, max tokens, top_p, n, frequency/presence penalties, and optional end-user tracking — and calls OpenAI through one of two selectable PHP SDKs (`orhanerday/open-ai` or `openai-php/client`). The OpenAI API key is supplied as a Key entity (via the Key module), resolved at call time through Augmentor's base class, never stored inline. Because it plugs into Augmentor, any pipeline that consumes an augmentor (fields, ECA, Views, custom code) can use ChatGPT as its engine.

---

- Summarize node body text on save by wiring the `chatgpt` augmentor into an Augmentor field/pipeline.
- Rewrite or paraphrase editorial copy through a `user` message containing `{input}`.
- Generate SEO meta descriptions or social snippets from long-form content.
- Translate submitted text by prompting the model with a `system` instruction plus `{input}`.
- Classify or tag incoming content (sentiment, topic, category) via a constrained prompt.
- Expand bullet points into prose for draft content workflows.
- Produce alt-text drafts or captions from supplied descriptions.
- Answer FAQ-style questions using a fixed `system` persona and a `user` `{input}`.
- Extract structured facts (names, dates) from unstructured text with a strict prompt.
- Clean up or reformat user-submitted text (grammar, tone) before publishing.
- Build a multi-turn priming conversation (system + assistant examples) to steer output style.
- Choose a specific model (e.g. `gpt-3.5-turbo`, `gpt-4`) per augmentor instance from the live model list.
- Tune creativity per instance with temperature vs. top_p for deterministic vs. exploratory output.
- Cap cost/latency per call with `max_tokens` and `n` (number of completions).
- Reduce repetition with frequency_penalty / presence_penalty on generated text.
- Request multiple candidate completions (`n > 1`) and pick among the returned `default` array.
- Attach the current Drupal user id to requests (user_tracking) so OpenAI abuse-monitoring can scope activity.
- Switch between the `orhanerday/open-ai` and `openai-php/client` SDKs without changing prompt config.
- Centralize the OpenAI credential as a single reusable Key entity shared across augmentor instances.
- Drive ECA / rules-style automation that calls an augmentor to enrich entities with AI output.
- Prototype prompt templates in the UI (add/remove message rows) before committing a pipeline.
- Provide a chat-completion engine to other Morpht/Augmentor tooling that expects an augmentor plugin.
- Fall back to `gpt-3.5-turbo` as the default engine when the model list is unavailable.
