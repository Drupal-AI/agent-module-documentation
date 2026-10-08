Augmentor is a pluggable framework for wiring external AI/LLM and other web services into Drupal so that content can be generated, transformed, classified, or enriched on demand.

---

Augmentor defines an "augmentor" plugin type: each augmentor is a configured instance (identified by a UUID, holding a label, an optional Key-module API key, and a debug flag) of a plugin that takes text input and returns a keyed array of results. The base module ships no provider itself — provider plugins (OpenAI/ChatGPT, Google Cloud Vision, NLP Cloud, AWS, etc.) live in companion projects, and a bundled Demo submodule shows the contract. Site builders create and order augmentors on an admin list page, then invoke them three ways: as a field type/widget that adds an "execute" button on entity forms (calling an AJAX controller and writing the result back into target fields via JavaScript), as configurable Views/entity bulk-operation Actions that run an augmentor over source fields and store the response into target fields, and (via submodules) as ECA action steps, CKEditor 4/5 toolbar buttons, and Search API index/query processors. Input and output can be altered by other modules through the `pre_execute`/`post_execute` hooks and the `augmentor.input.alter`/`augmentor.output.alter` events. API keys are always referenced through the Key module rather than stored inline.

---

- Add an OpenAI/ChatGPT augmentor and use it to summarise a long body field into a summary field.
- Translate a title or body from one language into another with a translation-provider augmentor.
- Auto-generate SEO meta descriptions or social snippets from an article's content.
- Extract keywords or taxonomy tags from body text and write them into a term-reference field using the Tags widget.
- Classify or moderate submitted content (sentiment, topic, toxicity) via an AI provider and store the label.
- Run Google Cloud Vision label detection on an uploaded image and map several response keys into several fields at once (multi-target).
- Generate alt text for images using an image-understanding augmentor and the File widget.
- Offer editors an "I'm feeling lucky" single-click rewrite/expand of a field with the Default widget.
- Present several AI-generated alternatives in a select box (Select widget) and let the editor pick one.
- Parse a structured AI response with a regex (Select Regex widget) to pull out just the values you need.
- Rewrite or expand a summary field independently of the main body with the Summary widget.
- Apply an augmentor in bulk to many nodes from a Views bulk operation using the Augmentor Action.
- Map up to ten source fields and ten target/response-key pairs in one action with the Augmentor Minimal action.
- Append, prepend, or replace existing field text with the augmentor's output based on the configured action.
- Choose the text format applied to generated rich-text so output lands in a safe, configured filter.
- Split a delimited AI response into multiple values (explode separator) for multi-value target fields.
- Preview an augmentor's output against test input directly on its edit form before wiring it to fields.
- Drive an augmentor from an ECA model: take a token as input, run it, and store the response back into a token for later steps (augmentor_eca).
- Augment content inline in the rich-text editor via the CKEditor 4 or CKEditor 5 toolbar button (augmentor_ckeditor4/5).
- Enrich or rewrite indexed field values at index time with a Search API processor (augmentor_search_api_processors).
- Transform or expand a user's search query before it runs using the query preprocess processor.
- Restrict who may create, edit, delete, or merely execute augmentors with the module's five permissions.
- Order/weight augmentors on the admin list so related augmentors group together for editors.
- Alter the request body before execution, or reshape results after, with the `pre_execute`/`post_execute` hooks.
- Subscribe to `augmentor.input.alter`/`augmentor.output.alter` events to normalise input or post-process responses site-wide.
- Build a custom provider by extending `AugmentorBase` and implementing `execute()` (see the Demo augmentor as a blueprint).
- Keep third-party API credentials out of exported config by selecting a Key entity for each augmentor's API key.
