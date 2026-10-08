# FillPDF hooks

From `fillpdf.api.php` plus the two plugin-info alter hooks.

## `hook_fillpdf_form_form_pre_form_build_alter(FillPdfFormForm $fillpdf_form_form)`

Fires in `FillPdfFormForm::form()` before the edit form is built. Use it to set defaults on the
`fillpdf_form` entity (e.g. a default entity type).

```php
function my_module_fillpdf_form_form_pre_form_build_alter(\Drupal\fillpdf\Form\FillPdfFormForm $fillpdf_form_form): void {
  $form = $fillpdf_form_form->getEntity();
  if (!$form->getDefaultEntityType()) {
    $form->set('default_entity_type', 'webform')->save();
  }
}
```

## `hook_fillpdf_populate_pdf_context_alter(array &$context)`

Fires in `HandlePdfController::populatePdf()` (via `alterContext()`) right after the request is parsed,
before entities are loaded and merged. `$context` keys: `fid`, `force_download`, `flatten`, `sample`,
`entity_ids`. Use it to inject or adjust which entities feed the merge.

```php
function my_module_fillpdf_populate_pdf_context_alter(array &$context): void {
  // e.g. auto-attach the current user's latest submission for each webform in context.
  // (See fillpdf.api.php for the full webform_submission example.)
}
```

## Plugin-info alter hooks

- `hook_fillpdf_pdfbackend_info_alter(array &$definitions)` — alter PdfBackend plugin definitions.
- `hook_fillpdf_fillpdf_action_info_alter(array &$definitions)` — alter FillPdfActionPlugin definitions.

Note: FillPDF respects normal entity `view` access when loading context entities for a merge — see the
access rules in [../api/generate.md](../api/generate.md).
