# Group Term — agent index

Makes taxonomy terms usable as **Group content**. Defines the `group_term` Group relation type plugin with
a deriver that yields one derivative per vocabulary (`group_term:<vocabulary_id>`, entity_type
`taxonomy_term`, cardinality fixed to 1). Depends on `group` + `taxonomy`. No settings form
(`configure` null); configured through Group's relationship UI + permission matrix. No Drush, no config
schema.

- **Enable the relation on a group type, the Terms view/routes/operations, tokens** →
  [configure/relation.md](configure/relation.md)
- **The permissions it defines (global + group) and what they gate** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Relation plugin `group_term`, deriver `GroupTermDeriver` → `group_term:<vocab>` per vocabulary.
- Bundled Views view `group_terms` at `group/{group}/terms` (access: group permission
  `access group_term overview`); adds a "Terms" group operation.
- Friendly routes cloned by `RouteSubscriber`: `group/{group}/term/create` + `group/{group}/term/add`.
- Tokens: `[term:group]` (label of one parent group) and `[term:groups]` (array of parent groups),
  from `group_term.tokens.inc`.
