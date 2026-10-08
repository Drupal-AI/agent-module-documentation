<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure: Email Templates

Everything is driven by the `workbench_email_template` **config entity**. No global settings
form; there is no separate settings config object.

## Admin UI

- Collection / config link: route `entity.workbench_email_template.collection` →
  `/admin/config/workflow/workbench-email-template` (menu: Config → Workflow → Email Templates).
- Add: `/admin/config/workflow/workbench-email-template/add`
- Edit: `/admin/config/workflow/workbench-email-template/{id}/edit`
- Delete: `/admin/config/workflow/workbench-email-template/{id}/delete`
- All gated by permission `administer workbench_email templates`.

## Template form fields (`Form/TemplateForm.php`)

- **Label** + machine **id**.
- **Format** select: `plain_text` or `html`. HTML requires a third-party mailer (Symfony
  Mailer / Swift Mailer / Mime Mail) — core alone downgrades HTML.
- **Subject** (required, tokens allowed, e.g. `[node:title]`).
- **Reply-To** (optional, tokens allowed, e.g. `[node:author:mail]`).
- **Body** (`text_format`, required) — the chosen filter format is applied at send time.
- **Token browser** shown only if the contrib `token` module is enabled (node tokens only).
- **Enabled recipient types** (required checkboxes) + a vertical-tabs settings subform per
  type that has a configure form. See [plugins/recipient-types.md](../plugins/recipient-types.md).
- **Bundles** checkboxes — limit to selected `{entity_type}:{bundle}`; select none = all
  moderated bundles.
- **Transitions** — per workflow, checkboxes of that workflow's transitions the template fires on.

## Stored config (schema `config/schema/workbench_email.schema.yml`)

Config prefix `workbench_email.workbench_email_template.{id}`. Exported keys
(`config_export`): `id`, `label`, `format`, `subject`, `body` (`{value, format}` mapping),
`bundles` (sequence of `{entity_type}:{bundle}`), `recipient_types` (keyed by plugin id, each
`{id, provider, status, settings}`), `replyTo`, `transitions` (`{workflow_id: {transition_id: transition_id}}`).

## Config example

```yaml
langcode: en
status: true
id: needs_review
label: 'Notify reviewers'
format: plain_text
subject: '[node:title] needs review'
body:
  value: '[node:title] is ready for review: [node:url]'
  format: plain_text
bundles:
  - 'node:article'
recipient_types:
  role:
    id: role
    provider: workbench_email
    status: true
    settings:
      roles:
        - editor
replyTo: ''
transitions:
  editorial:
    draft_needs_review: draft_needs_review
```

Dependencies (workflow, bundle config, recipient fields/roles) are auto-calculated; removing a
referenced role/field prunes it from the template rather than deleting the template.
