Term Merge Manager extends the Term Merge module by recording every term-merge action as reusable rules, then automatically re-applying those rules whenever a matching term is created again later.

---

Term Merge on its own merges taxonomy terms once. Term Merge Manager listens for its `term_merge.terms_merged` event and persists each merge as two content entities: a `term_merge_into` row (the surviving target term, keyed by `tid`/`vid`) and one `term_merge_from` row per source term (keyed by vocabulary `vid` + source `name`, pointing at the `term_merge_into` via `tmiid`). Afterwards, `hook_ENTITY_TYPE_presave()` on `taxonomy_term` checks each new/edited term against the saved "from" rules: if a term with the same vocabulary and name is created again, the presave hook rewrites it in place to become the existing target term (copying `tid`, name, `description`, and any `field_*` values from the target) instead of creating a duplicate. When the `redirect` module is enabled and `redirect.settings.auto_redirect` is on, the subscriber also creates a 301 redirect from each source term's alias to the target term. When a target term is deleted, `hook_taxonomy_term_delete()` removes its `term_merge_into` rule and all associated `term_merge_from` rules. Rules are managed as content entities with admin list builders at `/admin/structure/term_merge_from` and `/admin/structure/term_merge_into`. It has no settings/config schema and no configure route — only Field UI base routes and per-entity add/edit/delete forms gated by permissions.

---

- Automatically re-merge a term that keeps getting re-imported under an old name (e.g. a feed keeps creating "USA" but you standardised on "United States").
- Persist a Term Merge action so it survives and applies to future content, not just the terms present at merge time.
- Keep a vocabulary free of duplicate synonyms by having new duplicates fold into the canonical term on creation.
- Clean up messy free-tagging vocabularies where editors re-enter variant spellings.
- Enforce a controlled vocabulary during migrations that re-run and re-create terms.
- Auto-redirect old term-page URLs to the merged target term when the `redirect` module is enabled.
- Review all historical merge rules from a single admin list at `/admin/structure/term_merge_from`.
- See which surviving terms are merge targets at `/admin/structure/term_merge_into`.
- Delete a specific "from" rule so a previously-merged name is allowed to exist again as its own term.
- Show editors a message when a term they created was auto-merged (via the "view term merged manager messages" permission).
- Automatically clean up all merge rules for a target term when that term is deleted.
- Prevent duplicate URL aliases on merge targets (the module skips Pathauto on the rewritten term).
- Programmatically look up a merge rule with `TermMergeFrom::loadByVidName($vid, $name)`.
- Programmatically resolve whether a term id is a merge target with `TermMergeInto::loadIdByTid($tid)`.
- Grant a taxonomy manager role permission to administer, edit, or delete merge rules.
- Fold newly-created synonym terms into a master term across repeated content imports.
- Standardise category naming across a multi-editor site without manual re-merging.
- Build a self-healing vocabulary that collapses known variants automatically.
- Audit past merges for reporting on how terms were consolidated.
- Undo the automatic behaviour for one name by deleting its `term_merge_from` rule.
- Combine with Redirect's auto-redirect to preserve SEO when consolidating tag pages.
- Ensure re-created terms inherit the target term's fields and description automatically.
