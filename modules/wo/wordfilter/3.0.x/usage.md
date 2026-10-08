Wordfilter replaces banned/keyword words in content with configurable substitution text, either by direct regex substitution or token-aware substitution. You define reusable **Wordfilter configuration** entities and apply them as a text-format filter and/or directly on node and comment base fields (title/body, subject).

---

Wordfilter is a base for profanity filtering and dynamic keyword replacement. You create
**`wordfilter_configuration`** config entities (managed at *Configuration → Content authoring →
Wordfilter configurations*, route `entity.wordfilter_configuration.collection`), each holding a
list of items — a comma-separated **words to filter** and a **substitution text** — and a chosen
**filtering process** plugin. Two processes ship: `default` (Direct substitution — builds a
case-insensitive regex from the words and replaces matches) and `token` (same, but runs Drupal
tokens inside the substitution text). A configuration is applied three ways: (1) as the
`wordfilter` **text-format filter** — enable *Apply filtering of words* on a text format and pick
the active configurations; (2) on **content types** and **comment types** via a *Display settings*
third-party setting, filtering the rendered title/body (`hook_entity_display_build_alter`) and
comment subject (`template_preprocess_comment`); (3) programmatically through a `processed_text`
render element. Both process plugins run every filter word and every substitution string through
`Xss::filterAdmin()` before use, so script/dangerous-HTML vectors are stripped, and the title
render path prints through autoescaped Twig. Permissions: `administer wordfilter configurations`
(restricted), a non-restricted `access wordfilter configurations page`, and a per-configuration
`administer wordfilter configuration <id>`. New process plugins are pluggable via the
`wordfilter_process` plugin type.

---

- Censor profanity in comment subjects and bodies across a site.
- Replace a list of banned words with `***` or `[removed]` on node titles and bodies.
- Apply keyword replacement (e.g. brand normalization) via a text format filter.
- Swap placeholder keywords for dynamic values using token substitution.
- Insert the current user name / site name into content via tokens in the substitution.
- Maintain several reusable filter word lists as separate configurations.
- Enable different word lists on different text formats.
- Filter only specific content types by binding a configuration on the content type's Display settings.
- Filter comment titles/bodies per comment type.
- Combine multiple configurations on one text format (applied in sequence).
- Filter a custom string in code via a `processed_text` render element and a format that has the filter.
- Provide moderation-lite keyword masking without a full moderation workflow.
- Replace competitor mentions or disallowed terms in user-generated content on render.
- Use word boundaries so only whole words are matched (naturally-spoken words).
- Delegate configuration management of a single word list to a role via the per-config permission.
- Restrict who can create/delete all configurations via the restricted admin permission.
- Add a custom filtering backend (e.g. an external moderation API) as a `wordfilter_process` plugin.
- Keep original stored content intact while filtering only the displayed output (irreversible transform filter).
- Localize substitutions by using language-aware tokens in the token process.
- Roll out consistent banned-word handling by exporting the configuration entities.
