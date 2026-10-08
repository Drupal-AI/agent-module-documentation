<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
rh_storage is a small glue submodule of Storage Entities that plugs the `storage` entity type into the Rabbit Hole module, so you can control what happens when someone tries to view a storage entity (display it, deny access, redirect, or return 404).

---

The submodule does two tiny things. It registers a **Rabbit Hole entity plugin**
(`RabbitHoleEntityPlugin` id `rh_storage`, `entityType = "storage"`,
`Storage extends RabbitHoleEntityPluginBase`) so Rabbit Hole knows how to attach its
behaviour to the `storage` entity type. And it implements `hook_entity_base_field_info()`
(`RhStorageHooks::entityBaseFieldInfo`) which, for the `storage` entity type, returns the
Rabbit Hole base fields from `rabbit_hole.entity_extender` — adding the fields **`rh_action`**,
`rh_redirect`, `rh_redirect_response` and `rh_redirect_fallback_action` to storage entities.
With those in place, Rabbit Hole's normal UI/behaviour applies: each storage entity (and the
storage-type bundle default) can choose a Rabbit Hole action from the behavior plugins
`display_page`, `access_denied`, `page_not_found`, or `page_redirect`. It requires both
`rabbit_hole` and `storage`, has no config of its own, no permissions, no Drush, no settings
page, and no plugin type — everything is provided by the parent modules; rh_storage only
wires them together.

---

- Deny access to storage entities when someone visits their canonical URL.
- Return a 404 (page not found) for storage entities instead of showing them.
- Redirect visitors from a storage entity's URL to another page.
- Allow normal display of specific storage entities while the bundle default hides the rest.
- Set a Rabbit Hole default action per storage type (bundle) so all its items behave the same.
- Override the bundle default on an individual storage entity via its `rh_action` field.
- Keep back-end storage data unreachable at the front end using `access_denied`.
- Configure a redirect target and HTTP response code for redirecting storage entities.
- Provide a graceful fallback action when a redirect target is missing.
- Combine with the storage type's `has_canonical` setting to fully control front-end exposure.
- Apply Rabbit Hole to imported/structured storage records so they never render publicly.
- Migrate a "content type + Rabbit Hole" setup onto storage entities with the same behaviour.
- Let editors choose per-entity whether a storage item is viewable.
- Use Rabbit Hole tokens/redirects on storage entities as you would on nodes.
- Enable the integration simply by turning on the rh_storage submodule (pulls in rabbit_hole).
- Read a storage entity's configured Rabbit Hole action from its `rh_action` base field.
- Standardise front-end behaviour of a storage type across an editorial team.
- Prevent search engines/users from reaching internal storage data.
- Switch a storage type's behaviour from "display" to "access denied" without code.
- Reuse Rabbit Hole's existing behavior plugins rather than writing custom access logic.
