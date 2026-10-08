# Configure validator services

Route `web_accessibility.settings` → `/admin/config/system/web_accessibility`
(form `Drupal\web_accessibility\Form\AdminForm`, requires `administer_web_accessibility`).
The form lists every stored service in a table (Name, URL, Delete operation) and an
"Add" form with two textfields.

Services are **not** config entities — they are rows in the `web_accessibility_services`
DB table (columns `id`, `name`, `url`, all defined in `web_accessibility.install`). They
are therefore per-environment state, not exportable configuration.

## Default services (seeded on install)

`hook_install` calls `WebServiceManager::getDefaultServices()` and inserts:

| Name | URL |
|---|---|
| `validator.w3.org (checklink)` | `https://validator.w3.org/checklink?uri=<URL>` |
| `validator.w3.org (check)` | `https://validator.w3.org/check?uri=<URL>` |
| `wave.webaim.org` | `http://wave.webaim.org/report#/<URL>` |

## Adding a service (form fields)

| Field | Key | Notes |
|---|---|---|
| Name | `name` | Required; trimmed; max 255. Shown as the link label on the node form. |
| URL | `url` | Required; trimmed; max 255. Include the token `<URL>` where the page URL should be substituted. |

`AdminForm::validateForm()` strips `<URL>` from the submitted URL, then rejects it if the
remainder is empty or fails `\Drupal\Component\Utility\UrlHelper::isValid($url, TRUE)`
(must be a valid **absolute** URL). The **raw** value (token intact) is what gets stored.
On submit the row is inserted via the service manager and the form redirects back to
itself with a status message.

## Deleting a service

Each table row's Delete link goes to `web_accessibility.delete_service`
(`/admin/config/system/web_accessibility/delete/{service_id}`, form `DeleteServiceForm`,
a `ConfirmFormBase`). It loads the row by id (404 if missing), deletes it on confirm,
logs a `user`-channel notice, and redirects to the settings page.

## How the token expands

At node-form render time (see [hooks/node_form.md](../hooks/node_form.md)) the stored
`url` has `WebServiceInterface::URL_TOKEN` (`<URL>`) replaced with the node's absolute
canonical URL, so `https://validator.w3.org/check?uri=<URL>` becomes
`https://validator.w3.org/check?uri=https://example.com/node/1`.

## Set services from PHP / drush

There is no drush command. Use the service manager (see
[api/service_manager.md](../api/service_manager.md)):

```php
$m = \Drupal::service('web_accessibility.service_manager');
$m->addService('https://example.org/a11y?u=<URL>', 'My validator');
// Clear caches afterwards; the node-form section reads the table on build.
```
