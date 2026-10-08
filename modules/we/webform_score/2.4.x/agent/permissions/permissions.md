# Permissions

Two permissions (`webform_score.permissions.yml`) gate visibility of the computed score field.
Neither is state-changing — the field is never editable.

| Permission | Grants |
|---|---|
| `view any submission score` | See the `webform_score` field on any submission the user can already view. |
| `view own submission score` | See the score only on submissions the user owns (`isOwner`). |

## Enforcement
`webform_score_entity_field_access()` (`hook_entity_field_access`) in `webform_score.module`:
- If the score field has no value / `denominator` is null → `neutral` (defers to core).
- If `denominator` is 0 (no scoring configured) → **forbidden** (score hidden even from admins).
- `view` operation: allowed if the account has `view any submission score`, or has
  `view own submission score` and owns the submission; otherwise forbidden. Cached per
  permissions/per user with the submission as a cache dependency.
- `edit` operation: always forbidden (calculated field).

Both permissions are additive to normal Webform submission-view access — a user must be able to view
the submission itself first. Grant them to roles that should see quiz results (e.g. graders, or the
respondents themselves for "own").
