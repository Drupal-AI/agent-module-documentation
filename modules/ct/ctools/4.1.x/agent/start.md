# ctools — agent start

Developer utility APIs (no admin UI, `configure: null`). Consumed via services & plugins.
Core dep of Panels, Page Manager, Views bulk tooling. Core requirement `^9.5 || ^10 || ^11`.

- Multi-step Form Wizard API → [api/wizard.md](api/wizard.md)
- Context / tempstore / access services → [api/services.md](api/services.md)
- Relationship plugin type (derive one context from another) → [plugins/relationship.md](plugins/relationship.md)
- Submodules: `ctools_block` (entity-field block), `ctools_entity_mask` (borrow another type's fields), `ctools_views` (Views block display) — see their own docs.
