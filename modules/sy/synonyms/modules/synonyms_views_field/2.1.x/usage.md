Synonyms Views Field exposes the computed "Synonyms list" field (from Synonyms List Field) to Views, so you can add a synonyms column to any entity View.

---

A thin glue submodule: it implements `hook_views_data()` (`synonyms_views_data()`) to declare a
`synonyms` Views **field** on each entity type's data/base table (and revision table where present),
mapped to the core `field` handler with `field_name: synonyms`. That is the computed base field added by
`synonyms_list_field` (which this submodule requires), so the Views field renders each entity's list of
synonyms. There is no configuration, schema, permission, or service of its own — enable it and the
"Synonyms list" field becomes available in the Views UI. Depends on `synonyms`, `synonyms_list_field`,
and core `views`.

---

- Add a "Synonyms list" column to a content/term/user View.
- Show each row's synonyms alongside its title in a Views table.
- Build a glossary listing that displays terms with their aliases.
- Include synonyms in a View-based export (CSV/REST) of entities.
- Render synonyms in a block View of related content.
- Reuse the computed synonyms field without writing a custom Views handler.
- Display synonyms in an admin View for content auditing.
- Combine with the Synonyms Views filter to both filter and display synonyms.
- Surface aliases in a search-results-style View.
- Expose synonyms on revision-aware Views where a revision table exists.
- Add a synonyms column to a taxonomy term overview View.
- Show product aliases/SKUs in a commerce catalog View.
- Include synonyms in a JSON/REST export View for downstream systems.
- Render synonyms in an entity-reference display View.
- List user display-name synonyms in an admin user View.
- Provide a synonyms column in a moderation/content dashboard View.
