# Term Merge Manager — agent index

Extends **Term Merge**: records each merge as reusable rules and **re-applies them on term
presave**, so a re-created source term folds into the surviving target term instead of
duplicating. Two content entities store the rules; no config schema, no configure route,
no Drush, no plugins.

- **How rules are recorded (event), re-applied (presave), cleaned up (delete), the two
  entities and their loader methods, and redirect integration** →
  [api/rules-and-events.md](api/rules-and-events.md)
- **Permissions gating the rule entities and the auto-merge message** →
  [permissions/permissions.md](permissions/permissions.md)

Key facts:
- Requires `term_merge`. Subscribes to `term_merge.terms_merged`
  (`DefaultSubscriber::termMergeMergeAction`).
- Entities: `term_merge_into` (target `tid`+`vid`), `term_merge_from`
  (source `vid`+`name` → `tmiid`). Lists at `/admin/structure/term_merge_{from,into}`.
- Re-merge match key is **vocabulary + term name** (`TermMergeFrom::loadByVidName`).
