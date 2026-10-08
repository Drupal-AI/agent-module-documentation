# Configure — bulk update form

Route `google_index_api.google_index_api_bulk_update_form` at
`/admin/config/services/google-index-api/bulk-update`
(`\Drupal\google_index_api\Form\BulkUpdateForm`, permission `administer google index api`). Use it to
push a backlog of URLs through the Indexing API in one batch — e.g. after a migration or a bulk
publish. All submissions are treated as `URL_UPDATED` (the form only calls `updateUrl()`).

## Input

Two mutually exclusive inputs, toggled by the "Check here if you want to upload via file" checkbox:

- **Textarea** (`urls`) — one URL per line.
- **File** (`uploadz`) — a `txt` file, one URL per line (read line-by-line, so large files are fine).

`processUrls()` normalises each entry, validates it with `filter_var($url, FILTER_VALIDATE_URL)`, and
keeps only the **path** via `parse_url($url, PHP_URL_PATH)`. Non-URL lines are dropped. Each kept path
is prepended with the configured `google_index_api_base_domain` when the API is called, so only paths
on the site's own domain are actually submitted.

## Processing

`submitForm()` builds a Batch API job: one operation per URL calling
`Drupal\google_index_api\Batch\GoogleIndexApiBatch::batchProcess`, which invokes
`\Drupal::service('google_index_api.client')->updateUrl($path)`. `batchFinished` reports the count
updated. If no valid URLs are parsed, a "No Valid URLs to Process!" warning is shown instead.

Mind Google's ~200-calls-per-project-per-day quota when sizing a bulk run.
