Entity Deep Token adds an `entity-deep-token` token type that reads values from fields of related entities by walking entity-reference chains across multiple hops.

---

Drupal's core token system only follows one-level relationships, so a token can read a source entity's own fields but not values on the entities it references. Entity Deep Token closes that gap: it registers a custom token type, `entity-deep-token`, whose replacement callback (`entity_deep_token_tokens()`) treats the token string as a path of steps, starting from a source entity present in the current token context. Each field name reads that field; an `:entity:` step follows an entity-reference field to the referenced entity; and a terminal keyword (`id`, `label`, `bundle`, `value`, `target_id`, `date`, a numeric delta, or another property/method name) returns the value at the end of the chain. Which entity types the module treats as valid starting points is chosen on an admin settings form (route `entity_deep_token.settings`, under Configuration, permission `administer site configuration`), which stores the selection as `content_list` in the `entity_deep_token.settings` config object. The module depends on the Token module and works in any token-aware context that supplies an entity. From the source: only the first delta of a multi-value reference field is followed, and raw values such as timestamps are returned unformatted.

---

- Add an `entity-deep-token` token type to pull values from related entities in any token-aware field.
- Read a source entity's own field with `[entity-deep-token:field_name:value]`.
- Read a referenced entity's title with `[entity-deep-token:field_ref:entity:label]`.
- Read a referenced entity's numeric id/path with `[entity-deep-token:field_ref:entity:id]`.
- Read a referenced entity's bundle with `[entity-deep-token:field_ref:entity:bundle]`.
- Traverse two or more reference hops, e.g. degree → department → school for the school's title.
- Build hierarchical breadcrumbs from a chain of parent-reference fields.
- Generate meta tags / SEO metadata from values on a related entity.
- Compose custom URLs or path patterns using a referenced entity's id or slug field.
- Feed conditional logic in other token-consuming modules with related-entity values.
- Read a related node's raw creation timestamp with `[entity-deep-token:field_related_node:entity:created:value]`.
- Pull a `target_id` from a reference field with `...:field_ref:target_id`.
- Reach a specific field delta by index, e.g. `...:field_multi:0:...` within the module's first-item handling.
- Include related-entity data in email templates that run through token replacement.
- Populate default field values (via modules that accept tokens) from a parent entity.
- Choose which content entity types act as deep-token sources on the settings form.
- Use it with nodes, users, taxonomy terms, media, and other content entity types.
- Enable the taxonomy `term` context alias so term tokens resolve from a `term` data key.
- Combine with Pathauto, Metatag, or Token Filter wherever an entity context exists.
- Keep the token type available site-wide with no per-field configuration once enabled.
- Extend token coverage for developers without writing a custom `hook_tokens()` per project.
