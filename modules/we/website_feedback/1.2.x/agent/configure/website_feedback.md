<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# website_feedback — configure

## Settings form
Route `website_feedback.settings` → `/admin/config/development/website-feedback`
(permission `administer website feedback`). Form `SettingsForm` (form id
`website_feedback_settings`). Config object: **`website_feedback.settings`**.

Keys (with `config/install` defaults; schema in `config/schema/website_feedback.schema.yml`):

| Key | Type | Default | Effect |
|---|---|---|---|
| `type_enabled` | bool | `1` | Show the Type selector (Feedback / Support request / Bug report). |
| `screenshot_enabled` | bool | `1` | Show the screenshot capture field on the form. |
| `screenshot_technology` | string | `html2canvas` | Capture tech: `html2canvas` or `getDisplayMedia` (from `ScreenshotWidget::getTechnologies()`). |
| `button_text` | string | `Feedback` | Floating button label. |
| `button_title` | string | (see install) | Button `title` (hover) text. |
| `success_message` | string | `Thank you! We received your feedback.` | Message shown after submit. |
| `html2canvas_cdn` | bool | `1` | Load html2canvas from jsDelivr CDN; if `0`, expects a local file under `/libraries/html2canvas/…` (form warns + `hook_requirements` errors if missing). |
| `link_position` | string | `left` | Button edge: `left` or `right`. |
| `tags_enabled` | bool | `0` | Show a taxonomy-term tags field. |
| `tags_vocabulary` | string\|null | `null` | Vocabulary id used as the tags field target bundle. |
| `flood_limit` | int | `10` | Max non-admin submissions per window (0 disables flood check). |
| `flood_window` | int | `3600` | Flood window in seconds. |

Changing `tags_vocabulary` or `screenshot_technology` in `submitForm()` calls
`entityFieldManager->clearCachedFieldDefinitions()` (base field settings depend on them).
`update_10001` (in `.install`) backfills `screenshot_enabled`, `link_position`, `tags_*`,
and `flood_*` defaults on existing sites and nulls a `tags_vocabulary` that no longer resolves.

Set via Drush:
```
drush cset website_feedback.settings screenshot_enabled 1 -y
drush cset website_feedback.settings html2canvas_cdn 0 -y
drush cset website_feedback.settings flood_limit 5 -y
```

## The entity
`website_feedback` is a `ContentEntityType` (base table `website_feedback`,
`admin_permission = administer website feedback`, `entity_keys`: id/uuid/summary(label)/status;
route provider `AdminHtmlRouteProvider`). Base fields (`WebsiteFeedback::baseFieldDefinitions()`):

- `summary` — string(255), required, the entity label.
- `description` — string_long.
- `type` — list_integer, required, default `0`; allowed `0 Feedback` / `1 Support request` / `2 Bug report` (constants `TYPE_FEEDBACK`/`TYPE_SUPPORT`/`TYPE_BUG` on `WebsiteFeedbackInterface`). Hidden unless `type_enabled`.
- `tags` — entity_reference → taxonomy_term, unlimited; target bundle from `tags_vocabulary`. Hidden unless `tags_enabled`.
- `screenshot` — image, `max_filesize` 2MB, dir `website_feedback/screenshots/[Y]-[m]`; form widget `website_feedback_screenshot`. Hidden unless `screenshot_enabled`.
- `image` — image, `max_filesize` 2MB, dir `website_feedback/images/[Y]-[m]`; standard upload ("Or upload an image instead").
- `url` — uri; set on **add** from the request `Referer` (validated via `UrlHelper::isValid($referer, TRUE)`, else NULL). Form-hidden on add, disabled on edit.
- `uid` — author (defaults to current user via `preCreate()`); admin field.
- `created` — created timestamp; admin field.
- `status` — boolean, default FALSE; on = "Resolved" (constants `RESOLVED`/`NOT_RESOLVED`). Admin field.

Add form route: `entity.website_feedback.add_form` at `/admin/content/website-feedback/add`;
the front-end button submits the same add form via route `website_feedback.frontend_add`
(`/website-feedback/modal`, `_admin_route: FALSE`) in an AJAX dialog. `WebsiteFeedbackForm`
hides admin metadata on the public form, and its `validateForm()` registers/checks a flood
event (`website_feedback.submission`) for non-admin add operations; `save()` constrains the
post-submit redirect to same-host relative paths (open-redirect guard). AJAX submit
(`ajaxFormSubmit()`) replaces the form with a themed success card.

## Screenshot widget
`ScreenshotWidget` (`Plugin/Field/FieldWidget/ScreenshotWidget`, extends core `FileWidget`,
id `website_feedback_screenshot`). Client JS puts a base64 `data:image/(png|jpeg);base64,…`
string into a hidden `screenshot_data` element; `valueScreenshotWidget()` regex-matches it,
re-checks flood limits, base64-decodes, enforces the 2MB size limit, saves via
`file_system->saveData()`, then verifies the result is a genuine image with
`image.factory->get()->isValid()` (deleting + erroring otherwise). Filenames are randomised
(`screenshot-YmdHis-<rand>.ext`). Anonymous uploads get the core ManagedFile HMAC token and
are registered in `anonymous_allowed_file_ids` session for file access. Attaches libraries
`website_feedback/screenshot` + `website_feedback/html2canvas[-cdn]`.

## Management, listing & bulk actions
Collection at `/admin/content/website-feedback`. `WebsiteFeedbackListBuilder::render()` prepends
Total/Active/Resolved metric cards (entity queries with `accessCheck(TRUE)`); rows show status +
type badges, truncated target-page link, and a screenshot thumbnail (falls back to the `image`
field). Per-row op `toggle_status` → route `website_feedback.toggle_status`
(`WebsiteFeedbackController::toggleStatus`, requirements `_entity_access: website_feedback.update`
+ `_csrf_token: TRUE`). Optional Views view `website_feedback` (`config/optional`) exposes the
`website_feedback_bulk_form` Views field (`WebsiteFeedbackViewsData`). Action plugins (config in
`config/install`): `website_feedback_resolve_action` / `website_feedback_unresolve_action`
(`FieldUpdateActionBase` setting `status`), and `website_feedback_delete_action`
(`entity:delete_action`). Multiple-delete confirm form `ConfirmDeleteMultiple` at
`/admin/content/website-feedback/delete` (permission `delete website feedback`).

## Front-end button attachment
`website_feedback_page_attachments()` adds cache context `user.permissions` + cache tag
`config:website_feedback.settings`, and — only when the current user has `create website feedback`
— attaches library `website_feedback/website_feedback` and `drupalSettings.websiteFeedback`
(`buttonText`, `buttonTitle`, `buttonPosition`, `formUrl`). `hook_requirements` reports whether
html2canvas is set to CDN, installed locally, or missing.
