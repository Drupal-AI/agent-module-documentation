Entity Clone Extras is a submodule of Entity Clone that adds bundle-level clone permissions for Node (and Media) entity types, so you can allow cloning of specific content types rather than all of them at once.

---

The base Entity Clone module grants cloning per entity **type** (e.g. `clone node entity`), which is all-or-nothing across every content type. Entity Clone Extras refines this by generating a permission per **bundle** — for example "clone Article content" or "clone Image media" — through its `EntityCloneExtrasPermissions::permissions` callback. It implements `hook_entity_operation_alter()` to hide the Clone operation on individual entities whose bundle the current user is not allowed to clone, so editors only see the clone action for the content types you have granted. It targets Node and Media entity types (Media only when the Media module is enabled). Enable it alongside `entity_clone` and `node`; there is no configuration UI — you simply assign the new bundle-level permissions on the People → Permissions page. This is useful on multi-team sites where, say, the news team may duplicate Articles but not Pages or landing pages.

---

- Allow an editor role to clone Articles but not Pages.
- Grant a marketing team permission to duplicate landing-page nodes only.
- Let a media librarian clone Image media but not Document media.
- Restrict cloning of sensitive content types to administrators.
- Give per-content-type clone rights matching existing edit permissions.
- Hide the Clone operation on bundles a user cannot clone.
- Delegate cloning of event nodes to an events coordinator role.
- Prevent cloning of a legal/policy content type site-wide except for admins.
- Scope clone access on a multi-team editorial site by content type.
- Allow cloning of blog posts for guest authors without other clone rights.
- Combine bundle-level node clone rights with base entity-type rights for other entities.
- Limit media cloning to specific media types.
- Enforce least-privilege cloning as part of a permissions audit.
- Let a translator role clone a specific content type for a new language variant.
- Grant clone rights per content type through a role-based workflow.
