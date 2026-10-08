# Configure — the Webform Protected Download handler

The module has no global settings page. All configuration lives on a **webform handler** you add
per webform. Class `WebformProtectedDownloadsHandler`
(`src/Plugin/WebformHandler/WebformProtectedDownloadsHandler.php`), plugin id
`webform_protected_downloads`, category "Downloads", cardinality UNLIMITED (add several to one
webform to offer several downloads).

## Add it (UI)

1. Build/edit a webform, then go to **Settings → Emails / Handlers**
   (`/admin/structure/webform/manage/{webform}/handlers`).
2. **Add handler → Webform Protected Download**.
3. In the handler form, upload the file under **Protected Files** and set the validity options.
4. Put the token `[webform_submission:protected_download_url]` into the webform's confirmation
   message and/or an Email handler so the submitter receives the link (see "Surfacing the link").

## Settings

Stored as the handler's `settings` (config schema type `webform.handler.webform_protected_downloads`,
`config/webform_protected_downloads.schema.yml`). Defaults come from
`WebformProtectedDownloadsHandler::defaultConfiguration()`.

| Setting key | Form control | Default | Meaning |
|---|---|---|---|
| `verify_access` | radios | `basic` | Access-verification level applied by the download controller — see table below. |
| `expiration_one_time` | checkbox | `FALSE` | If set, the link is deactivated after the first successful download (`active` set to FALSE). |
| `expiration_time` | number (minutes) | `0` | Minutes the link stays valid after submission. `0` = never expires. Required field. |
| `expiration_page` | radios | `page_reload` | Where an invalid/expired/used link redirects: `404`, `homepage`, `page_reload` (back to the form), or `custom`. |
| `expiration_page_custom` | textfield | `''` | Path or absolute URL to redirect to when `expiration_page` is `custom`. |
| `expiration_error_message` | textfield | `This link has expired.` | Message flashed when the link is invalid (shown for `homepage`, `page_reload`, `custom`). |
| `protected_file` | managed_file | `[]` | The file to serve (single file). Uploaded to `private://webform_protected_downloads/[Y]-[m]`. |
| `protected_file_allowed_extensions` | textfield | webform's `file.default_managed_file_extensions` | Space-separated allowed upload extensions. Required, maxlength 196. |
| `debug` | checkbox | `FALSE` | Show debugging on screen to all users. |

### `verify_access` levels

The download controller applies an additional entity check for every level **except** `basic`:

| Value | Check performed at download time |
|---|---|
| `basic` | No additional entity check beyond the link's `hash`, `active` flag and expiry. |
| `owner` | Requires the current user to be the submission owner (`$submission->isOwner($currentUser)`). |
| `view_submission` | Requires the current user to pass `$submission->access('view')`. |
| `owner_or_view_submission` | Passes if **either** owner **or** view-submission access holds. |
| `owner_and_view_submission` | Requires **both** owner **and** view-submission access. |

The owner-bearing levels make `hasAnonymousSubmissionTracking()` return TRUE, so Webform tracks the
anonymous submitter (needed for the owner check to work for anonymous users).

## File upload details

- `#type => 'managed_file'`, `#multiple => FALSE`, `#upload_location =>
  'private://webform_protected_downloads/[Y]-[m]'` (year/month subfolder, resolved through the
  `[date:custom:...]` token). Files therefore live in the **private** filesystem.
- Allowed extensions are enforced with the core file-extension validator (via
  `DeprecationHelper::backwardsCompatibleCall` — `FileExtension` on core ≥ 10.2, else
  `file_validate_extensions`). An AJAX callback (`allowedExtensionsAjaxCallback`) rebuilds the
  upload element when the extension list changes; `allowedExtensionsElementValidate()` blocks
  narrowing the list while a still-uploaded file would become disallowed.
- On save (`submitConfigurationForm()`), the previously configured file's `file.usage` is released
  and the newly selected file is registered permanent via
  `$this->fileUsage->add($file, 'webform_protected_downloads', 'webform', $webform_id)`.

## Set it via PHP / drush

Handler settings live inside the webform config entity (`webform.webform.{id}` →
`handlers.{handler_id}.settings`). Example (`drush php:eval` / a hook):

```php
$webform = \Drupal\webform\Entity\Webform::load('leadgen');
$handler = $webform->getHandler('webform_protected_downloads');
$config = $handler->getConfiguration();
$config['settings']['verify_access'] = 'owner';   // basic|owner|view_submission|owner_or_view_submission|owner_and_view_submission
$config['settings']['expiration_time'] = 60;      // minutes; 0 = never
$config['settings']['expiration_one_time'] = TRUE;
$handler->setConfiguration($config);
$webform->updateWebformHandler($handler);
$webform->save();
```

The `protected_file` value is a list of file IDs (a `sequence` of integers in schema); the handler
uses `current($protected_file)` — the first entry — as the served file.

## Surfacing the link

The module provides a webform-submission token via `hook_token_info()` /`hook_tokens()`:

- `[webform_submission:protected_download_url]` — the download URL for this submission. With a
  single handler, no sub-token is needed.
- `[webform_submission:protected_download_url:{handler_id}]` — when a webform has multiple
  protected-download handlers, address a specific one by handler id, e.g.
  `[webform_submission:protected_download_url:webform_protected_downloads_2]`.

Place the token in the webform's **confirmation message**, a **confirmation page**, or the body of
an **Email** handler. At render time the token resolves (through
`WebformProtectedDownloadsManager::getSubmissionByUuid()` → the entity's `getUrl()`) to the absolute
`/webform_protected_file/{hash}/download` URL for that submission's record.
