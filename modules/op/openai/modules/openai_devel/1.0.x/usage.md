OpenAI Devel Generate adds a "content from ChatGPT" generator to the Devel Generate suite, so demo
and QA content is written by OpenAI GPT models instead of Lorem Ipsum. It works from the Devel
Generate admin UI and from a Drush command, filling node titles and selected string/text fields with
realistic AI-written text.

---

The module ships a single DevelGenerate plugin (`content_gpt`) that extends core Devel Generate's
content generator and a Drush wrapper command (`devel-generate:content-gpt`, alias `gencgpt`). For
each node it asks an OpenAI chat model (default `gpt-3.5-turbo`) for a title and then for the value
of each requested string/text field, steered by a configurable "system profile" prompt, temperature
and max-tokens. Non-text fields still get standard sample values. It has no configuration, permission
or schema of its own — it relies on Devel Generate's `administer devel_generate` permission and the
parent OpenAI module's API key/service. Because every node triggers several OpenAI API calls, it is
meant for local, development and QA use (it is tagged `developer`), and large batch counts consume
real API quota. Model, temperature and token limits are validated both in the settings form and in
the Drush validator.

---

- Fill a fresh site with realistic-sounding demo articles for a client walkthrough.
- Generate sample nodes for theme and layout QA that read like real content.
- Produce believable body copy to test text formats and trimming.
- Seed content types with plausible titles instead of random Latin.
- Batch-generate demo content headlessly in CI with `drush gencgpt`.
- Create topic-specific sample content by tuning the system profile prompt.
- Generate HTML-formatted long-text field values for WYSIWYG testing.
- Populate only chosen fields (via `--base-fields`) while randomizing the rest.
- Delete and regenerate content in one step with `--kill`.
- Generate multilingual demo content and translations for i18n testing.
- Vary randomness of generated copy by adjusting temperature.
- Cap generation cost per node by lowering max-tokens.
- Prefix content-type labels onto titles for easy identification in lists.
- Assign generated nodes to specific author ids for permission testing.
- Produce demo content for search/index testing that has real vocabulary.
- Generate example content for accessibility or SEO audits.
- Create sample data for migration or view-building rehearsals.
- Spin up plausible content for stakeholder demos without manual writing.
- Test moderation/workflow states against generated published nodes.
- Benchmark rendering performance with realistic field lengths.
- Generate content that exercises multiple content types in one run.
- Provide writers with AI-drafted starter nodes to edit down.
