# Configure a Protected File field

No global settings page (`configure` null). You add a **Protected File** field to a fieldable entity,
then configure it on *Manage form display* (widget) and *Manage display* (formatter). It behaves like a
core File field plus per-file protection.

## Requirement: private filesystem

The field type only works with the `private://` stream wrapper (only private files run through
`hook_file_download()`). On field-storage config the `uri_scheme` is forced to `private` and disabled;
choosing public raises a validation error (`ProtectedFile::validateUriScheme`). `hook_requirements`
warns at install/runtime if no private scheme is configured in `settings.php`
(`$settings['file_private_path']`).

## Plugins

| Kind | id | Notes |
|---|---|---|
| Field type | `protected_file` | Extends core `FileItem`; adds a boolean `protected_file` property/column (default 0). |
| Widget | `protected_file_widget` | Extends core `FileWidget`; adds a **Protected** checkbox per uploaded file. |
| Formatter | `protected_file_formatter` | Renders `protected-file-link.html.twig`; lock icon + redirect for unauthorized users. |
| Media source | `protected_file` | `@MediaSource` allowing protected files to back media entities. |

## Widget

`protected_file_widget` reuses the core file widget; when a file is present it adds a `protected_file`
checkbox (`#return_value = 1`). For multi-value fields it themes with `protected_file_widget_multiple`
(adds a "Protected" column to the table). Widget settings: only `progress_indicator` (inherited).

## Formatter settings (`protected_file_formatter`)

Defaults from `defaultSettings()`:

| Key | Default | Meaning |
|---|---|---|
| `protected_file_new_window` | `1` | Open the file link in a new tab (`target="_blank"`). |
| `protected_file_path` | `/user/login` | Where to send users **without** the download permission when they click a protected file. |
| `redirect_to_file` | `0` | If set, the redirect's `destination` is the private file URL (so they land on the file after login) instead of the current page. |
| `protected_file_modal` | `0` | Open `protected_file_path` in an AJAX modal (`use-ajax` + `core/drupal.dialog.ajax`). |
| `protected_file_message` | `You need to be logged in to be able to download this file` | Title/tooltip on a protected link. |

Rendering logic (`template_preprocess_protected_file_link`): if the current user **lacks**
`download protected file` and the item is protected, the link points at `protected_file_path` (with a
`destination` query) instead of the file, and a lock icon (`<i class="fa fa-lock">`) is shown. If
`protected_file_path` is empty, the filename is rendered as plain text (no link). Users **with** the
permission always get a direct link to the file URL. This is display-side UX only — the actual gate is
in `hook_file_download()` (see [../api/access.md](../api/access.md)).

## Storage settings schema

`field.storage_settings.protected_file` (display_field, display_default, uri_scheme) and
`field.field_settings.protected_file` (handler, file_directory, file_extensions, max_filesize,
description_field) mirror the core File field.

## Set the field's formatter/widget with Drush (example)

```php
// drush php:eval — put the protected-file widget + formatter on node.article.field_docs
$efd = \Drupal::entityTypeManager()->getStorage('entity_form_display')->load('node.article.default');
$efd->setComponent('field_docs', ['type' => 'protected_file_widget', 'region' => 'content'])->save();
$evd = \Drupal::entityTypeManager()->getStorage('entity_view_display')->load('node.article.default');
$evd->setComponent('field_docs', [
  'type' => 'protected_file_formatter',
  'settings' => ['protected_file_path' => '/user/login', 'redirect_to_file' => 1],
])->save();
```
