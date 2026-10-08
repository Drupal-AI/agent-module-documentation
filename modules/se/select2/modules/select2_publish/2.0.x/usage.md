Select2 Publish marks referenced entities in a Select2 widget with their published status, so editors can see at a glance which options are unpublished.

---

Select2 Publish is a submodule of Select2 that annotates the options of a `select2` entity
reference widget with each referenced entity's published/unpublished state. It works two ways: for
rendered options it implements `hook_element_info_alter()` to add a pre-render callback
(`StatusProperties::preRender`) that sets a `data-published` attribute on every option (via the
`form_options_attributes` module) and a `data-select2-publish-default` attribute on the element;
for autocomplete (AJAX) options it implements `hook_select2_autocomplete_matches_alter()` to add a
`published` flag to each match returned by the Select2 matcher. Only entity types that implement
`EntityPublishedInterface` are decorated. A small CSS/JS pair (`select2.publish` library) then
styles unpublished options distinctly in the dropdown. It depends on the Select2 main module and
`form_options_attributes`. There is no configuration — enabling the module is enough; any Select2
entity reference widget on a publishable entity type gets the status indicators automatically.

---

- Show which referenced nodes are unpublished directly in a Select2 dropdown.
- Warn editors visually before they reference an unpublished entity.
- Distinguish draft vs published taxonomy terms / media in a reference field.
- Mark autocomplete (AJAX) suggestions with their published status as you type.
- Add a `data-published` attribute to each Select2 option for custom styling.
- Style unpublished options distinctly with the bundled `select2.publish` CSS.
- Indicate the default published state for entities that would be auto-created (tags).
- Improve editorial accuracy on sites using content moderation / workflows.
- Avoid publishing content that links to still-unpublished references.
- Apply status indicators automatically to any publishable entity type (implements EntityPublishedInterface).
- Keep unpublished-awareness consistent across single and multi-select Select2 fields.
- Surface publish state on media, users, or custom entity reference fields.
- Give reviewers a quick signal about referenced content readiness.
- Extend the same status data in code via the `select2_autocomplete_matches_alter` hook.
- Combine with Select2 autocomplete for large, status-aware reference lists.
- Work with no configuration — enable and it applies to existing Select2 reference widgets.
