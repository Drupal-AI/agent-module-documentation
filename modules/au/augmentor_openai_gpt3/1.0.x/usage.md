Adds an OpenAI GPT3 completions plugin to the Augmentor framework so site builders can transform text with OpenAI models.

---

Augmentor OpenAI GPT3 is a thin provider add-on for the Augmentor module. It registers one Augmentor plugin, `openai_gpt3_completions`, that takes an input string, substitutes it into a configurable prompt template, and calls the OpenAI completions endpoint (default model `gpt-3.5-turbo-instruct`) through one of two bundled PHP SDKs (`orhanerday/open-ai` or `openai-php/client`). The plugin exposes the full OpenAI completion parameter set (temperature, max_tokens, top_p, n, best_of, frequency/presence penalties, stop, logit_bias, echo, stream, logprobs, suffix, user tracking) plus an optional built-in "Summarizer" that chunks over-long inputs, summarizes each chunk, and re-joins them so long text stays within the model's context window. The API key is supplied as a Key entity resolved by the Augmentor base, and all configuration is done inside an Augmentor config entity through the base module's admin UI — this project adds no routes, permissions or config of its own. Augmentors created with this plugin can then be invoked by anything that consumes the Augmentor framework (ECA actions, other modules, custom code).

---

- Summarize a long node body down to a short abstract using the Summarizer (chunker) option.
- Generate an SEO meta description from a page's main text.
- Draft a social-media teaser from an article body.
- Rewrite copy in a different tone (formal, casual, marketing) via a custom prompt template.
- Classify free-text into categories by prompting the model to return a label.
- Extract keywords or tags from body content to feed a taxonomy workflow.
- Translate short strings by wording the prompt as a translation instruction.
- Produce a plain-language summary of technical documentation.
- Auto-generate alt-text suggestions from a supplied image caption or description.
- Expand a bullet outline into full prose for an editor to review.
- Answer templated Q&A prompts where `{input}` carries the user's question.
- Condense meeting notes or transcripts stored in a long-text field.
- Create a "TL;DR" summary block that a display or ECA workflow attaches to content.
- Normalize or clean up messy user-submitted text before storage.
- Generate product blurbs from a set of specification fields concatenated into `{input}`.
- Suggest headline variants (using `n` to request several completions at once).
- Tune determinism per augmentor: temperature 0 for classification, higher for creative drafts.
- Cap cost/output per call with `max_tokens`, `best_of` and `stop` sequences.
- Switch between the orhanerday and openai-php SDKs per augmentor without code changes.
- Chain the completion output into ECA or other Augmentor-aware pipelines as a reusable augmentor.
