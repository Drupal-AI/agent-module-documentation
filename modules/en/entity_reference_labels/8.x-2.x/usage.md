Entity Reference Labels adds a "Default (Descriptive)" entity-reference selection method whose autocomplete/select options show each candidate's label plus its id, bundle and language, so editors can tell same-named entities apart.

---

Entity Reference Labels is a small module that registers an alternative entity-reference *selection handler* (reference method) called "Default (Descriptive)". You pick it per field on the field's settings page, exactly where you would choose core's "Default" handler. It does not change how a saved reference is *displayed* on the rendered entity; instead it changes the *options an editor sees while selecting* a reference in the edit form. Where core's autocomplete or select widget shows only the plain entity label, the descriptive handler shows the label followed by the entity's id, bundle and language code — for example `Sidebar - (12 | block | en)`. This disambiguates entities that share the same human-readable name (two blocks both called "Sidebar", two nodes with identical titles, etc.). The handler is derived for every entity type on the site, so it is available on any entity-reference field; entity types that do not declare a `label` key transparently use a PHP-based variant that filters candidates by their computed label. All option text is HTML-escaped before it reaches the widget. There is no settings form, no permission, and no dependency beyond Drupal core.

---

- Disambiguate two referenced entities that share the same display label.
- Show a candidate's entity id inline in the reference autocomplete.
- Show a candidate's bundle inline in the reference autocomplete.
- Show a candidate's language code inline in the reference autocomplete.
- Pick "Default (Descriptive)" as the reference method on an entity-reference field.
- Improve the autocomplete widget on a node reference field.
- Improve the autocomplete widget on a taxonomy-term reference field.
- Improve the autocomplete widget on a user reference field.
- Reference block configuration entities and tell identical block labels apart.
- Reference custom entities that lack a unique human-readable title.
- Help editors pick the correct item when many candidates share a name.
- Reduce mis-selected references caused by ambiguous labels.
- Add descriptive selection options without writing a custom selection plugin.
- Use the descriptive handler on any entity type, including config entities.
- Rely on the PHP variant for entity types with no `label` key in their definition.
- Keep type-ahead search behaviour identical to the core autocomplete.
- Filter candidates case-insensitively while showing the descriptive label.
- Swap a field from core "Default" to "Default (Descriptive)" with no data migration.
- Multilingual sites: surface each candidate's language alongside its label.
- Editorial teams working with large numbers of similarly named entities.
- Distinguish revisions or drafts that carry the same title during selection.
- Support content models where several bundles are referenceable from one field.
- Give reviewers a quick id/bundle reference while curating related content.
- Revert to the plain core handler at any time by changing the reference method back.
