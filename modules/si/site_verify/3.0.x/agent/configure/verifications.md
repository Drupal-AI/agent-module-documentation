<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure site verifications

## Admin route

`configure` route: **`entity.site_verification.collection`** → `/admin/config/search/verifications`
(Administration > Configuration > Search > Verifications). Menu link weight 10 under
`system.admin_config_search`.

Entity form routes (all under the `site_verification` config entity's route provider):

| Route name | Path | Purpose |
|---|---|---|
| `entity.site_verification.collection` | `/admin/config/search/verifications` | List all verifications |
| `entity.site_verification.add_form` | `/admin/config/search/verifications/add` | Add a verification |
| `entity.site_verification.edit_form` | `/admin/config/search/verifications/{site_verification}/edit` | Edit |
| `entity.site_verification.enable_form` | `/admin/config/search/verifications/{site_verification}/enable` | Enable (confirm form) |
| `entity.site_verification.disable_form` | `/admin/config/search/verifications/{site_verification}/disable` | Disable (confirm form) |
| `entity.site_verification.delete_form` | `/admin/config/search/verifications/{site_verification}/delete` | Delete |

The enable/disable routes are added by a custom route provider,
`Drupal\site_verify\Entity\Routing\SiteVerificationRouteProvider` (extends
`AdminHtmlRouteProvider`), on top of the standard add/edit/delete/collection routes.

## The config entity

Entity type id: **`site_verification`** (a `ConfigEntityType`, config prefix `site_verification`,
so instances export as `site_verify.site_verification.<id>.yml`).

Entity keys: `id`, `label`, `status`.

Exported fields (`config_export`): `id`, `label`, `status`, `description`, `type`, `name`, `content`.

| Field | Meaning |
|---|---|
| `id` | Machine name of the verification |
| `label` | Human label shown in the listing |
| `status` | Boolean; only `true` (enabled) verifications are attached/served |
| `description` | Free-text admin note (single line only — control characters/newlines forbidden) |
| `type` | `meta` or `file` — see below |
| `name` | The meta tag's `name` attribute, or the filename served off the site root |
| `content` | The meta tag's `content` attribute, or the file's text contents |

`type` is backed by the PHP enum `Drupal\site_verify\Entity\SiteVerificationType` with cases
`Meta = 'meta'` and `File = 'file'`. There is no separate `site_verification_type` config
entity or plugin type — the two verification methods are just these two enum values.

## Meta vs file verification

- **`meta`** — Rendered as `<meta name="{name}" content="{content}">` in `<head>`, but **only
  on the front page** (checked via `PathMatcherInterface::isFrontPage()` in
  `hook_page_attachments`). Used by most search-engine webmaster tools (Google, Bing, Yandex).
- **`file`** — Served as plain text (`Content-Type: text/plain`) at a dynamically generated
  route whose path is exactly the verification's `name` (e.g. `name: BingSiteAuth.xml` serves
  `/BingSiteAuth.xml`). Routes for all enabled `file` verifications are (re)built by
  `Drupal\site_verify\Routing\SiteVerifyRoutes::routes()`, a `route_callbacks` dynamic route
  provider, and the router is explicitly rebuilt (`router.builder`) whenever a
  `site_verification` entity is saved or deleted (see `SiteVerificationStorage::triggerRouteRebuild()`),
  so a new/changed file verification becomes servable without a manual `drush cr`.
  A `SiteVerifyUniqueFile` validation constraint forbids two verifications from both using
  `type: file` with the same `name` (filename must be unique among file-type verifications).

## Via the UI

1. Go to `/admin/config/search/verifications`.
2. **Add site verification**. Enter a **Label** (machine name auto-generated, editable) and
   optional **Description**.
3. Choose an entry mode: **Manual entry** (pick Verification type = Meta tag or File, then fill
   in Name and Content), **Paste a meta tag** (paste the full `<meta ...>` tag and it is parsed
   into `name`/`content`), or **Upload a file** (requires core `file` module; the uploaded file's
   name/contents populate the entity, and the temporary upload is deleted after parsing).
4. Save. Newly added verifications are enabled by default (`status` checkbox on by default).
5. Use the row's **Enable**/**Disable** operation (an AJAX-confirmed modal) to toggle `status`
   without deleting the record.

## Via drush / programmatically

```php
// Create a Google-style meta tag verification.
\Drupal\site_verify\Entity\SiteVerification::create([
  'id' => 'google_home',
  'label' => 'Google Search Console',
  'status' => TRUE,
  'description' => '',
  'type' => 'meta',
  'name' => 'google-site-verification',
  'content' => 'AbCdEf123...',
])->save();

// Create a file verification.
\Drupal\site_verify\Entity\SiteVerification::create([
  'id' => 'bing_file',
  'label' => 'Bing Webmaster',
  'status' => TRUE,
  'description' => '',
  'type' => 'file',
  'name' => 'BingSiteAuth.xml',
  'content' => '<?xml version="1.0"?><users><user>ABC123</user></users>',
])->save();
```

`->preSave()` runs the config entity's typed-data validation (against
`config/schema/site_verify.schema.yml`, which has `constraints: { FullyValidatable: ~ }`) and
**throws `\LogicException`** if the entity is invalid, so a bad `type` value or a duplicate
`file` name will abort the save. Because of `FullyValidatable`, **`description` must be set**
(an empty string `''` is fine — it just cannot be omitted/`NULL`) even though it's optional
from a UI standpoint.

Read a verification back:

```bash
drush config:get site_verify.site_verification.google_home
```

or in PHP: `\Drupal::entityTypeManager()->getStorage('site_verification')->load('google_home')`,
then `->getType()`, `->getMetaName()` / `->getFilename()`, `->getContent()`, `->status()`.
