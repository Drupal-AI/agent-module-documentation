# paragraphs_edit — agent start

Adds **Edit / Clone / Delete** contextual links to rendered paragraphs and dedicated
per-paragraph routes/forms, so a single paragraph can be edited without opening the whole
host entity. Builds on **Paragraphs** + core **Contextual Links**. No config UI, no
settings, no module-specific permissions — enabling `paragraphs_edit` (with `contextual`
and `paragraphs`) is the whole setup. Routes live under
`/paragraphs_edit/{root_parent_type}/{root_parent}/paragraphs/{paragraph}/{edit|clone|delete}`.

- Contextual links, the edit/clone/delete routes & forms, access model, revision handling → [configure/paragraphs_edit.md](configure/paragraphs_edit.md)
- Access & permissions model (core entity access, no custom perms) → [permissions/paragraphs_edit.md](permissions/paragraphs_edit.md)
- Services (lineage inspector/revisioner), form classes, trait → [api/paragraphs_edit.md](api/paragraphs_edit.md)
