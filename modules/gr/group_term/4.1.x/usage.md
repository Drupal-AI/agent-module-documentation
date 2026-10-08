Group Term makes taxonomy terms usable as Group content, so vocabularies can be related to Group entities and terms managed per-group (via the Group module's relation/plugin system).

---

The module defines a Group relation type plugin, `group_term`, with a deriver (`GroupTermDeriver`) that
produces one plugin derivative **per taxonomy vocabulary** (`group_term:<vocabulary_id>`), each targeting
the `taxonomy_term` entity type and that vocabulary as its bundle. Entity cardinality is forced to 1 (the
config form disables the field) because the functionality relies on a single group per term. Enabling a
derivative on a group type (as a Group relationship / plugin) lets that group "have" terms of the chosen
vocabulary, reusing Group's standard relationship entities, create/add pages and access system. It ships a
Views view (`group_terms`, path `group/%group/terms`) that lists a group's related terms with operations,
gated by the group permission `access group_term overview`; a `hook_entity_operation` adds a **Terms**
operation link to each group when that permission is held. A `RouteSubscriber` clones Group's generic
relationship create/add routes to friendlier paths (`group/{group}/term/create`, `group/{group}/term/add`)
and action links surface them on the terms view. A custom `GroupTermOperationProvider` relation handler adds
a per-vocabulary **Create** group operation when the user has `create <plugin> entity` or the global
`create any group_term entity` permission. Token support (`group_term.tokens.inc`) adds `[term:group]` and
`[term:groups]` tokens exposing a term's parent group(s). There is no module settings form; configuration is
done through the Group type's relationship UI and Group's own permission matrix.

---

- Relate taxonomy terms of a specific vocabulary to Group entities as group content.
- Give each group its own managed set of category/tag terms.
- Install the `group_term:<vocabulary>` relation on a group type to enable term membership.
- List all terms belonging to a group at `group/{group}/terms` (the bundled Group Terms view).
- Add a "Terms" tab/operation to group pages for users with the overview permission.
- Let group members create new taxonomy terms scoped to their group via `group/{group}/term/create`.
- Relate existing taxonomy terms to a group via `group/{group}/term/add`.
- Control who can create group terms per group using Group's per-plugin `create ... entity` permissions.
- Grant a trusted role blanket term creation with the `create any group_term entity` permission.
- Restrict term overview visibility with the `access group_term overview` group permission.
- Expose a term's owning group in tokens with `[term:group]` (group label).
- List all of a term's parent groups with the `[term:groups]` array token.
- Chain group tokens off a term, e.g. `[term:group:id]` / `[term:group:url]`.
- Build per-group taxonomy dashboards by embedding or cloning the `group_terms` view.
- Model multi-tenant sites where each tenant (group) curates its own vocabulary terms.
- Automatically refresh available relations when a new vocabulary is created (definitions are recleared).
- Enforce one-group-per-term semantics (entity cardinality is fixed at 1).
- Combine with Group's access system so term create/edit respects group roles.
- Provide vocabulary-scoped tagging where terms are owned and moderated by group admins.
- Add "Create <vocabulary>" group operations to the group collection for permitted users.
