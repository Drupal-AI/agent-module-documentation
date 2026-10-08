# Permissions

From `organigrams.permissions.yml` (none marked `restrict access: true`):

| Permission | Gates |
|---|---|
| `create organigrams` | The **Add organigram** action / `entity.vocabulary.add_organigram_form` route (creating an organigram vocabulary). Also route-gated by `_entity_create_access: taxonomy_term`. |
| `import organigrams` | The **Import Drupal 7 organigram** form (`organigrams.import_form`). |
| `view organigrams` | Viewing the `/organigram/{vocab}` page, the organigram block (`blockAccess`), and `viewOrganigram()` output. |

Note: organigrams **are** taxonomy vocabularies, so core taxonomy permissions apply too — editing the
chart means editing terms, which requires the relevant `edit terms in <vocab>` / taxonomy access.
The import-items and export-items routes additionally require `_entity_create_access: taxonomy_term:{vocab}`
and pass the `isOrganigram()` custom-access check (vocabulary must carry the `is_organigram` third-party
setting).
