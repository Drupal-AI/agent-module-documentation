<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Content Feedback (content_feedback) — agent index

info.yml name **Content Feedback**, version **2.0.0**, package `Development`, core `^9 || ^10 || ^11`.
Lets visitors/users send a short feedback message about the page they are viewing (a "was this page
better?" quality-assurance channel). A **Feedback** link is injected at the bottom of eligible pages;
clicking it opens an AJAX modal form so the visitor stays on the page after submitting. Submissions land
in a custom database table and are reviewed by admins in an Open/Resolved list. No dependencies, no
entities, no services file, no Drush, no plugin types. Configure at `content_feedback.settings`.

## How it works (mechanism)

- **Feedback link** — `content_feedback_page_bottom()` (in `.module`) adds a container with an `use-ajax`
  modal link to route `content_feedback_add.form` when the current user has permission
  `access content feedback form` **and** `content_feedback_access_block()` passes. That helper returns TRUE
  when the aliased path is not matched by the configured `disable` path list AND either `global == 1`, or
  `global == 0` and the current route's `node` parameter is of a content type selected in `content_types`.
  `content_feedback_page_attachments()` attaches the `content_feedback/content-feedback-link` library and
  `core/drupal.ajax` to users with that same permission.
- **Submit form** — `Form\AddContentFeedback` (form id `content_feedback_form`, route `content_feedback_add.form`
  at `/content-feedback`, permission `access content feedback form`). Fields: `name` (default = current
  account name; shown/required per `name` setting), `email` (default = current account email; per `email`
  setting), `message` (textarea, always required), hidden `path` (from `HTTP_REFERER`, else `/`), hidden
  `ipaddress` (from `getClientIp()`). Standard Drupal form (CSRF token). The write happens in the AJAX
  callback `submitContentFeedback()` (the real `submitForm()` is empty): on no validation errors it calls
  `ContentFeedbackClass::addContentFeedback()` with each value passed through `Html::escape()`, then swaps the
  modal for a success message.
- **Storage** — custom table `content_feedback` created by `hook_schema()` in `.install` (columns: `id`
  serial PK, `name`, `email`, `message` big text, `path`, `ipaddress`, `created`, `updated`, `status` tiny
  int default 1). Not a Drupal entity. `status`: `1` = open, `2` = resolved. All CRUD is in
  `Form\ContentFeedbackClass` (static methods) using the parameterized DB query builder
  (`insert`/`select`/`update`/`delete` with `->condition()`, `->fields()`); no raw SQL. Insert and update
  also re-apply `Html::escape()` to the stored text.
- **Admin list** — `Controller\AdminFeedbackController::content($type)`; routes `content_feedback_list.content`
  (`/admin/content/feedbacks`, `type: open`) and `content_feedback_list.content_resolved`
  (`/admin/content/feedbacks/resolved`), both requiring `manage content feedback submissions`, exposed as
  Open/Resolved local tasks under `admin/content`. Renders a sortable, paged (`limit(50)`) `#theme => table`
  of Date/User/Email/Location/IP/Feedback/Actions; each text cell is `Html::escape()`d and rendered through
  the table theme. Empty state prints "No Content Feedback Found."
- **Edit / Delete** — `Form\EditContentFeedback` (`/admin/content/feedback/edit/{id}`) lets an admin change
  path/name/email/ipaddress/status/message and save via `updateFeedback()`; `Form\DeleteContentFeedback`
  (`ConfirmFormBase`, `/admin/content/feedback/delete/{id}`) deletes via `deleteContentFeedback()`. Both look
  the row up with `checkFeedback($id)` first and throw `NotFoundHttpException` if it does not exist. Both
  require `manage content feedback submissions`.

## Configuration (`content_feedback.settings`)

Settings form `Form\ContentFeedbackSettingsForm` at route `content_feedback.settings`
(`/admin/config/content/feedback`, permission `administer content feedback settings`; also a menu link under
Config → Content authoring):

- `global` (checkbox) — enable the feedback link on every page vs. only selected content types.
- `content_types` (checkboxes of node types) — types that show the link when `global` is off.
- `dialog_size` (checkbox "Auto Resize") and `dialog_width` (number, %) — modal sizing.
- `name` / `email` (checkboxes: `show`, `required`) — visibility/requirement of those two form fields.
- `disable` (textarea) — paths (one per line, e.g. `/about`) where the link is suppressed.

`hook_uninstall()` deletes the `content_feedback.settings` config. Config schema
(`config/schema/content_feedback.schema.yml`) defines only `content_types` (sequence).

## Permissions (`content_feedback.permissions.yml`)

- `administer content feedback settings` — settings form (`restrict access: true`).
- `manage content feedback submissions` — the admin list, edit, and delete routes (`restrict access: true`).
- `access content feedback form` — see and submit the feedback form / link.

## Files

- `.module` — `hook_page_bottom` (link), `hook_page_attachments` (library), `content_feedback_access_block()`,
  `hook_help`.
- `.install` — `hook_schema` (the `content_feedback` table), `hook_uninstall`.
- `src/Form/AddContentFeedback.php` — public submit form (AJAX modal).
- `src/Form/ContentFeedbackClass.php` — static CRUD helpers over the table.
- `src/Controller/AdminFeedbackController.php` — Open/Resolved review list.
- `src/Form/EditContentFeedback.php`, `DeleteContentFeedback.php` — admin edit/delete.
- `src/Form/ContentFeedbackSettingsForm.php` — settings.
- `css/content_feedback.css`, `content_feedback.libraries.yml` — the feedback link styling.
