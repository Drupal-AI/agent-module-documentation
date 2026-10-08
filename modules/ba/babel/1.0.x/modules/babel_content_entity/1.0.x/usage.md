Babel submodule that exposes simple content entities (taxonomy terms, shortcuts, and similar) as translatable UI strings inside Babel's unified translation interface.

---

`babel_content_entity` adds a derived `content_entity` translation-type plugin to Babel. An admin picks which content entity types to expose (and, per type, which bundles) on the settings page at `/admin/config/regional/babel/settings/content-entity`; the deriver (`BabelContentEntityDeriver`) then creates one plugin derivative per selected entity type (`content_entity:<entity_type>`). The plugin harvests each entity's translatable string fields (excluding language/metadata keys) into Babel's index, so translators see and translate them alongside code and configuration strings. Saving a translation writes it back to the entity as a proper `content_translation` entity translation (author set to the current user). Because these entities are then translated by anyone with Babel's `translate interface` permission, admins should only expose entity types with a predictable, controlled number of entities and the bundles that actually need translation.

---

- Translate taxonomy term names and descriptions from the Babel translation interface.
- Translate shortcut link labels as UI strings.
- Translate other simple/small content entity types you opt in via the settings page.
- Limit exposure per entity type to specific bundles to keep the string list manageable.
- Let non-technical translators handle content-entity labels without navigating each entity's own edit/translate form.
- Include content-entity strings in Babel spreadsheet exports and imports.
- Send content-entity strings to TMGMT translators via `babel_tmgmt` alongside all other Babel strings.
- Keep entity translations stored natively (content_translation) rather than duplicated in Babel.
- Curate (activate/deactivate) and lock content-entity translations like any other Babel string.
- Avoid performance blow-ups by restricting selection to entity types with few, controlled entities (the settings form warns about this).
