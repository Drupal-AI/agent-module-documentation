# Configure leave-confirm points (configure)

There is no free-form settings form — configuration is a set of **`leave_confirm_point` config
entities**, one per form you want guarded. Manage them at
`/admin/config/user-interface/leave-confirm-points` (route `leave_confirm_point.list`). Every route
here requires the permission **`administer leave confirm settings`**.

## How a point makes a form fire

`leave_confirm_form_alter()` (`leave_confirm.module:47`) calls
`leave_confirm_get_leave_confirm_form_ids($form_id)` (`:104`), which runs:

```php
\Drupal::entityQuery('leave_confirm_point')
  ->condition('label', $form_id)   // matches the ENTITY LABEL, not the machine id
  ->condition('status', 1)         // must be ENABLED
  ->execute();
```

So a point guards a form **only when its `label` is exactly that form's `form_id` (or base form id)
and it is enabled**. The entity `id` (`formId` field) is a separate machine name and is *not* used
for matching or for the CSS selector — only `label` is. In the four shipped install points and the
node points seeded by `hook_install`, `label` and `formId` happen to be identical; the webform points
seeded at install deliberately differ (`label: webform_submission_<id>_add_form`,
`formId: webform_<id>_add`), and there the **label** is what must equal the real form id.

On a match, the module attaches library `leave_confirm/confirmation_popup` and sets
`drupalSettings.leave_confirm.formId` to a comma-joined list of selectors: each matched id is
stripped to `[A-Za-z0-9_-]`, `_`→`-`, and prefixed with `.` (so `node_page_form` → `.node-page-form`).
`js/leave-confirm.js` then watches `.form-item` elements inside those selectors.

## Add / enable a point via the UI

1. Go to `…/leave-confirm-points`, click **Add leave confirm point** (route `leave_confirm_point.add`).
   You may also deep-link `…/add?form_id=<id>` to pre-fill.
2. **Form ID** (the `label` field) — set it to the target form's real `form_id`. It is
   `preg_replace('/[^A-Za-z0-9_-]/','',…)`-sanitised on save.
3. **Machine name** (`formId`) — auto-derives; uniqueness checked by `leave_confirm_point_load`.
4. Save, then **Enable** the point (route `entity.leave_confirm_point.enable`) — new/seeded points are
   disabled by default. Disable/Delete are the confirm forms `entity.leave_confirm_point.disable` /
   `entity.leave_confirm_point.delete_form`.

## Form-ID naming (from the in-form handbook)

- Node add: `node_<type>_form`; node edit: `node_<type>_edit_form` (e.g. `node_page_form`,
  `node_page_edit_form`).
- Webform: `webform_submission_<id>_form`; block-embedded: `webform_submission_<id>_form_add`.
- User: forgot password `user_pass`, login `user_login_form`, register `user_register_form`.
- Contact personal form: `contact_message_personal_form`.
- "Also works with the base form ID" — the alter also checks `$form_object->getBaseFormId()`, so a
  base id (e.g. `node_form`) can guard a whole family.

## Create a point from code / config

Config entity (config/install or a deploy):

```yaml
# leave_confirm.leave_confirm_point.node_article_form.yml
langcode: en
status: true            # enabled — install-shipped points use false
dependencies: {  }
formId: node_article_form   # entity id (machine name)
label: node_article_form    # MUST equal the real form_id to match
```

Entity API:

```php
\Drupal::entityTypeManager()->getStorage('leave_confirm_point')->create([
  'formId' => 'node_article_form',
  'label'  => 'node_article_form',
  'status' => TRUE,
])->save();
```

Enable/disable an existing one: `$point->enable()->save();` / `$point->disable()->save();`.

## Install seeding (`hook_install`)

On install the module creates points (all `status: false`): the four in `config/install`
(`user_login_form`, `user_pass`, `user_register_form`, `contact_message_personal_form`); if `node` is
enabled, `node_<type>_form` and `node_<type>_edit_form` for each existing node type; if `webform` is
enabled, an `_add` and a plain point per webform. Node/webform types created *after* install are not
seeded automatically — add those points yourself.

## Gotchas

- **Nothing fires until you enable a point** — every seeded point starts disabled.
- Matching is on **`label`**, so a point whose label ≠ the real form id silently never fires even if
  enabled.
- The `beforeunload` message text is fixed in the JS and then overridden by the browser's own
  wording; it cannot be customised. The prompt only appears after the user has interacted with the
  page, and does not fire on JS-driven (SPA/AJAX) navigations.
- No `config/schema/` ships for the entity (a config-validation gap, not a runtime error).
