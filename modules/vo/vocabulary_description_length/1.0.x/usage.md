<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Vocabulary Description Length changes the taxonomy vocabulary edit form so the **Description** field is rendered as a multi-line `textarea` instead of core's single-line `textfield`, making it comfortable to write long, multi-paragraph vocabulary descriptions.

---

This is a one-hook convenience module with no configuration, no schema, no permissions and no services. It implements `hook_form_FORM_ID_alter()` for `taxonomy_vocabulary_form` and, if the `description` element exists, sets its `#type` to `textarea`. That is the module's entire behaviour. Core stores a vocabulary's description as an unlimited string either way (`taxonomy.vocabulary.<vid>` config, key `description`) — the module does **not** change storage, add length validation, or alter how the description renders on the front end; it only improves the *editing widget* so longer text is practical to enter. Because it only alters the vocabulary form, it has no effect on term descriptions, node fields, or anywhere else. There is no configure route (`configure: null`).

---

- Give editors a roomy multi-line box for a vocabulary's description instead of a cramped one-line field.
- Write a full paragraph explaining what a vocabulary is for and how terms should be used.
- Document editorial guidelines directly in a vocabulary's description without truncation frustration.
- Add line breaks / structured notes to a vocabulary description during setup.
- Improve the admin UX of taxonomy vocabulary creation on content-heavy sites.
- Let content architects record the purpose and scope of each vocabulary inline.
- Store onboarding notes for new editors in the vocabulary description.
- Make long "Tags", "Categories" or custom-vocabulary descriptions comfortable to author.
- Explain the difference between two similar vocabularies in their descriptions.
- Capture governance rules (who may add terms, naming conventions) per vocabulary.
- Keep vocabulary documentation with the vocabulary rather than in an external wiki.
- Provide translators context by describing a vocabulary at length.
- Avoid custom code just to widen the vocabulary description input.
- Enable multi-paragraph descriptions on an existing site by simply installing the module.
- Support internal knowledge-base style notes on taxonomy vocabularies.
- Describe the intended term hierarchy of a vocabulary in prose.
- Note deprecation/migration plans for a vocabulary in its description.
- Give a client-friendly explanation of each vocabulary in the admin UI.
- Standardise how teams document vocabularies by making the field easy to fill in.
- Reduce accidental truncation when pasting descriptive text into the vocabulary form.
