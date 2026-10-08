Views Core Entity Reference opts your entity-reference field filters into Drupal Core's built-in `entity_reference` Views filter, replacing the raw numeric/string "target id" comparison with a proper Select or Autocomplete widget for choosing referenced entities.

---

The module is a tiny, zero-configuration glue layer. Its only runtime code is a `hook_views_data_alter()` that loads every `entity_reference` field config, computes the field's Views table (`<entity_type>__<field_name>`) and target-id column (`<field_name>_target_id`), and — when that column's filter is currently the generic `numeric` or `string` handler — swaps the filter plugin id to `entity_reference`. That single change makes Views expose the field as a select/autocomplete of the actual referenced entities instead of asking the user to type an entity id. Because this filter previously only existed as a long-standing core patch, the module also ships an `hook_install()` migration (`_views_core_entity_reference_update_as_a_reference()`) that rewrites existing view configs: it strips the old `_reference` suffix the patch appended to filter ids/keys/operators so views built against the patched core keep working after switching to this module. There is no admin UI, no permissions, no config schema, and no plugins of its own — it simply enables a capability Drupal Core already provides. Requires the `views` module and Drupal core 10.2+ (where the core `entity_reference` Views filter exists).

---

- Turn a numeric "entity id" Views filter into a select list of referenced entities.
- Provide an autocomplete widget for filtering a View by an entity-reference field.
- Let editors pick a referenced node/term/user by label instead of typing its id.
- Add a usable exposed filter for entity-reference fields on a content listing View.
- Replace the raw target-id string filter with core's entity_reference filter site-wide.
- Improve UX of admin content Views that filter by author, category, or related content.
- Filter a View of articles by their referenced taxonomy term via a select widget.
- Filter a media/asset View by a referenced entity using autocomplete.
- Migrate a site off the old core entity_reference Views filter patch cleanly.
- Preserve existing views that used the patch (auto-strips the `_reference` suffix on install).
- Enable label-based exposed filters for faceted-style browsing without extra modules.
- Filter user lists by a referenced role/group entity reference field.
- Give content moderators a friendlier "referenced by" filter on dashboards.
- Apply the core entity_reference filter to custom entity types' reference fields automatically.
- Avoid hand-writing `hook_views_data_alter()` to switch each reference field's filter.
- Standardize entity-reference filtering behavior across all bundles and entity types.
- Support both Select and Autocomplete widget behavior as provided by core's filter.
- Reduce editor errors from guessing numeric entity ids in Views filters.
- Keep filtering consistent with how entity-reference fields behave elsewhere in Drupal.
- Drop-in improvement for existing Views with no configuration required after enabling.
