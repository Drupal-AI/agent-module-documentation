Node Title Validation adds per-content-type rules to node titles — minimum/maximum character length, minimum/maximum word count, a blocklist of forbidden characters or words, and a uniqueness check — enforced on node save via an entity constraint.

---

The module attaches a `NodeTitleValidate` symfony constraint to the node `title` base field for every node bundle (via `hook_entity_base_field_info_alter()` and `hook_entity_bundle_field_info_alter()`). Its `NodeTitleConstraintValidator` reads the module's config (`node_title_validation.settings` → `node_title_validation_config`) and, for the node's own content type, applies whichever rules are set: `min`/`max` character length (`mb_strlen`), `min-wc`/`max-wc` word count (split on spaces), an `exclude` blocklist of comma-separated characters/words (single characters matched anywhere in the string, multi-character words matched as whole words), an optional `comma` flag that also blocks the comma character, and a per-type `unique` flag that rejects a title already used by another node of the same type. Each failing rule adds a violation, so a title can fail several rules at once and all messages show. Rules are configured on one admin form (`/admin/config/content/node-title-validation`, route `node_title_validation.admin_form`) that renders a fieldset per content type; it is gated by the module's own permission `node title validation admin control`. There is also a global "unique for all content types" checkbox stored at `node_title_validation_config.unique`, but note the validator's uniqueness check is always scoped to the node's own type — set the per-type `unique` flag to actually enforce it. Because validation runs as an entity constraint it fires on any node save path (node form, migration, JSON:API, programmatic `->save()` validation), not just the UI.

---

- Enforce a minimum title length (e.g. at least 10 characters) on Article nodes.
- Cap title length below the 255-character node title maximum for a content type.
- Require a minimum number of words in a title (e.g. at least 3 words).
- Cap the word count of a title to keep headlines short.
- Block specific special characters (e.g. `!`, `@`, `#`) from appearing in titles.
- Blocklist marketing/spam words so editors cannot use them in titles.
- Also forbid the comma character in titles via the dedicated "comma" toggle.
- Require unique titles within a content type to prevent duplicate pages.
- Apply different title rules to different content types from one settings form.
- Prevent duplicate event titles for an Events content type.
- Enforce SEO-friendly title length ranges per content type.
- Stop editors from saving one-word titles by setting a minimum word count.
- Reject titles that reuse an existing published node's title of the same type.
- Validate titles on programmatic node saves (entity constraint, not just the form).
- Enforce title rules on nodes created via migration or JSON:API.
- Keep news headlines within an editorial character budget.
- Block profanity words from node titles site-wide by configuring each type.
- Ensure product titles meet a minimum descriptive length.
- Combine a blocklist and a length rule so a single title is checked against both.
- Show a helpful violation message naming exactly which blocked words were found.
- Gate the settings form behind a dedicated non-admin permission for content managers.
- Standardize title conventions across an editorial team without custom code.
- Prevent accidental duplicate landing pages by requiring unique titles per type.
- Restrict title punctuation for URL/slug cleanliness downstream.
