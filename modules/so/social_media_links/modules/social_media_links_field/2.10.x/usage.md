Social Media Links Field turns the Social Media Links platform system into a field type, so editors can store a set of social-network profile links directly on any entity (node, user, taxonomy term, etc.) instead of only in a block.

---

This submodule of Social Media Links adds a `social_media_links_field` field type together with matching widgets and a formatter. Add the field to any bundle via Field UI, then in the field settings choose which platforms are available and the icon set to render them; editors fill in just the account/handle per network, and the parent module's Platform plugins build the full URLs. Two widgets are provided — a default multi-row widget (`social_media_links_field_default`) and a select-based widget (`social_media_links_field_select`) — plus a default formatter (`social_media_links_field_default`) that renders the icon links exactly like the block does, reusing the same Iconset plugins. Its configuration schema stores an `iconset` plus a `platforms` sequence (enabled, description, weight) at field level, and `platform`/`value` pairs as the stored values. Theme hook suggestions let you template the output per field, entity type or bundle (`social_media_links_platforms__<field_name>`, etc.). It depends on the main Social Media Links module for the platform and iconset plugins, and targets Drupal 9.5, 10 and 11.

---

- Store a person's social profiles on their user account.
- Add social links to an "author" or "team member" content type.
- Let editors manage per-node social links instead of a global block.
- Capture an organization's networks on an organization entity.
- Choose which platforms are offered on a given field.
- Pick the icon set used to render a field's links.
- Render field icons identically to the social block.
- Show different social links per taxonomy term (e.g. per brand).
- Order the platforms within the field via weights.
- Use the select widget for a compact editing UI.
- Use the default multi-row widget for full control.
- Template a specific field's output with theme suggestions.
- Vary social-link markup per entity type or bundle.
- Include social profiles in a view that lists entities.
- Migrate per-entity social data into a structured field.
- Expose per-entity social links to a decoupled front end via JSON:API.
- Add a "follow us" field to a company profile node.
- Reuse the ~50 bundled platforms as field options.
- Enable only a few networks (e.g. LinkedIn + GitHub) on a resume field.
- Keep social links as content (editable per entity) rather than config.
