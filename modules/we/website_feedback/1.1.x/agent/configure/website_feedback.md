# website_feedback — configure

## Settings form
Route `website_feedback.settings` → `/admin/config/development/website-feedback`
(permission `administer website feedback`). Config object: **`website_feedback.settings`**.

Keys (with install defaults):

| Key | Type | Default | Effect |
|---|---|---|---|
| `type_enabled` | bool | `1` | Show the Type selector (Feedback / Support request / Bug report). |
| `screenshot_enabled` | bool | (unset) | Show the screenshot field on the form. |
| `tags_enabled` | bool | (unset) | Show a taxonomy-term tags field. |
| `tags_vocabulary` | string | (unset) | Vocabulary id used for the tags field (target bundle). |
| `screenshot_technology` | string | `html2canvas` | Screenshot capture technology (from `ScreenshotWidget::getTechnologies()`). |
| `button_text` | string | `Feedback` | Floating button label. |
| `button_title` | string | (see install) | Button `title` (hover) text. |
| `success_message` | string | `Thank you! We received your feedback.` | Message shown after submit. |
| `html2canvas_cdn` | bool | `1` | Load html2canvas from jsDelivr CDN; if `0`, expects `/libraries/html2canvas/html2canvas.min.js` locally (form warns if missing). |
| `link_position` | string | `right` | Button edge: `right` or `left`. |

Changing `tags_vocabulary` or `screenshot_technology` clears cached entity field
definitions (base field settings depend on them).

Set via Drush:
```
drush cset website_feedback.settings screenshot_enabled 1 -y
drush cset website_feedback.settings html2canvas_cdn 0 -y
```

## The entity
`website_feedback` is a `ContentEntityType` (base table `website_feedback`,
`admin_permission = administer website feedback`). Base fields: `summary` (label),
`description` (string_long), `type` (list_integer: 0 Feedback / 1 Support / 2 Bug),
`tags` (entity_reference → taxonomy_term), `screenshot` + `image` (image, 10MB max,
stored under `website_feedback/…`), `url` (uri — set from the `Referer` header on add),
`uid` (author, defaults to current user), `created`, `status` (boolean: on = Resolved).
Add form: `/admin/content/website-feedback/add`; the frontend button submits it via AJAX.

## Management + bulk actions
Collection at `/admin/content/website-feedback` (Views view `website_feedback`, shipped in
`config/optional`). Bulk action plugins (shipped in `config/install`):
`website_feedback_resolve_action`, `website_feedback_unresolve_action`,
`website_feedback_delete_action`. Multiple-delete confirm form at
`/admin/content/website-feedback/delete`.

## Frontend button
Attached in `website_feedback_page_attachments()` only when the current user has
`create website feedback`; passes `buttonText`, `buttonTitle`, `buttonPosition` to
`drupalSettings.websiteFeedback` and attaches the `website_feedback/website_feedback`
library. Cache context `user.permissions` is added so caching stays correct.
