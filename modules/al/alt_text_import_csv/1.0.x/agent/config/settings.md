<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings & email reports

Source: `src/Form/AdminSettingsForm.php`, `config/schema/alt_text_import_csv.schema.yml`,
`config/install/alt_text_import_csv.settings.yml`, and the `hook_mail` in
`alt_text_import_csv.module`.

## Config object: `alt_text_import_csv.settings`

Schema type `config_object` with three keys (install defaults shown):

| Key | Type | Default | Effect |
| --- | --- | --- | --- |
| `mails` | sequence (list of emails) | `[]` | Recipients of the failure report email. Empty = no email sent. |
| `no_page_url_match_update_all` | boolean | `false` | If a row's page URL matches no host entity, update the image's alt text on **all** host entities that reference the file (used for sitewide block content, etc.) instead of failing the row. |
| `media_only` | boolean | `false` | Restrict updates to `media` host entities only (intersects Entity Usage sources with the `media` type). |

## Settings form — `AdminSettingsForm`

- `ConfigFormBase`; `getFormId()` = `alt_text_import_csv_settings_form`; editable config
  `alt_text_import_csv.settings`. Route `alt_text_import_csv.settings`
  (`/admin/config/media/alt_text_import_csv/settings`), perm `administer alt_text_import_csv`.
- `mails`: a `multivalue` element (from **multivalue_form_element**), unlimited cardinality, one
  `email` sub-element per row. `submitForm()` flattens it with
  `array_column($form_state->getValue('mails'), 'mail')` before saving.
- `no_page_url_match_update_all` and `media_only`: checkboxes inside an "Image usage options"
  details group.
- `validateForm()` is empty.

Config export example:

```yaml
# alt_text_import_csv.settings.yml
mails:
  - a11y@example.com
  - editors@example.com
no_page_url_match_update_all: true
media_only: false
```

## Email report — `hook_mail` (key `report`)

Sent by `AltTextImportBatch::sendReportMail()` only when `mails` is non-empty **and** at least one
row failed. Recipients = the `mails` list joined by `, `; langcode = site default; params carry the
current user id and the CSV file id. `alt_text_import_csv_mail()` builds the body from the failed
rows stored in the private tempstore (`results_<fid>`), listing `line N: <page url>, <image url>,
<message>` per failure (line numbers shown 1-based). Subject: *"Alt text update report from
<site>"*.
