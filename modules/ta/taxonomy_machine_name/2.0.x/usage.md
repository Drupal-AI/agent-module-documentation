Taxonomy Machine Name adds a `machine_name` base-field property to every taxonomy term, auto-generated (transliterated + slugified) from the term name and made unique within its vocabulary, so terms can be referenced by a stable string instead of a numeric term ID.

---

The module declares a `machine_name` string base field on the `taxonomy_term` entity via `hook_entity_base_field_info()`. On every term save (`hook_ENTITY_TYPE_presave`) it fills the property: if left empty it derives one from the term name, otherwise it sanitises the value the editor typed, then `taxonomy_machine_name_uniquify()` appends an incrementing `_0`, `_1`, … suffix until the value is unique inside the vocabulary. Slug generation lives in `taxonomy_machine_name_clean_name()` (transliterate to ASCII, lowercase, replace non `[a-z0-9_]` runs with `_`) and is overridable through `hook_taxonomy_machine_name_clean_name_alter()`. The term add/edit form gains a `machine_name` element (with an AJAX uniqueness check against `taxonomy_machine_name_term_load()`), the taxonomy overview page gains a Machine name column gated by the "view machine name overview page" permission, and the value is exposed to Token (`[term:machine_name]`), to Views (a dedicated filter `taxonomy_index_machine_name` and an argument validator `taxonomy_term_machine_name`), and to Migrate (a D7 source plugin `d7_taxonomy_machine_name_term`). The term canonical page also gets a `term--<machine_name>` body class. Values persist as a real column on `taxonomy_term_field_data`; uninstalling nulls the column. A submodule, `search_api_taxonomy_machine_name`, extends this to Search API.

---

- Give every taxonomy term a stable, human-readable slug that survives content migration between environments.
- Reference terms by machine name instead of fragile numeric term IDs when exchanging data with external systems.
- Auto-generate a slug from the term name on save without writing any custom code.
- Look up a term programmatically with `taxonomy_machine_name_term_load('my_slug', 'tags')`.
- Build clean taxonomy URLs by feeding `[term:machine_name]` into a Pathauto pattern.
- Enforce uniqueness of term slugs within a vocabulary (automatic `_0`/`_1` suffixing on collision).
- Add a Views contextual filter that accepts a term machine name in the URL and validates it with the "Taxonomy term machine name" argument validator.
- Expose a Views exposed filter that lets visitors filter content by term machine name rather than term ID.
- Let editors set or override a term's machine name from the term edit form, with live uniqueness checking.
- Show a Machine name column on the vocabulary overview page for site builders (permission-gated).
- Transliterate accented or non-Latin term names into safe ASCII slugs automatically.
- Customise the slug algorithm site-wide via `hook_taxonomy_machine_name_clean_name_alter()` (e.g. dashes instead of underscores).
- Target terms in Twig/CSS using the `term--<machine_name>` body class added to taxonomy term pages.
- Migrate Drupal 7 taxonomy terms and carry over their machine names using the `d7_taxonomy_machine_name_term` source plugin.
- Keep a canonical identifier for terms used as configuration keys in custom logic.
- Map imported feed categories onto existing terms by matching machine names.
- Provide predictable term identifiers for a headless/JSON:API front end.
- Backfill machine names for all pre-existing terms via the install batch or the `taxonomy_machine_name_deploy_update_existing_terms` deploy hook.
- Prevent machine names from colliding with taxonomy route words (`add`, `list`, `delete`, `update` are rejected).
- Use term machine names as glossary keys to match free-text strings to terms case-insensitively.
- Drive Rules or other automation off a term's machine name rather than its label.
- Reference terms in exported configuration without hard-coding term IDs that differ per environment.
- Combine with the `search_api_taxonomy_machine_name` submodule to index and facet on term machine names, including ancestors.
- Give content authors a stable slug for terms reused across many content types.
