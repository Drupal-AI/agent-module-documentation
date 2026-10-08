# Configure — override core/contrib emails with Easy Email templates

Submodule of `easy_email`. Requires `easy_email`. Manage overrides at **Admin → Structure →
Email templates → Overrides** (`/admin/structure/email-templates/overrides`, route
`entity.easy_email_override.collection` — the `configure` route). Access gated by core
`administer site configuration` (the submodule defines no permissions of its own).

## How it works
The submodule decorates the core `plugin.manager.mail` service (`MailManager`,
`decorates: plugin.manager.mail`, priority 1). On every `mail()` call it looks for an
`easy_email_override` config entity whose `module` + `key` match the outgoing mail; if found it
builds and sends an Easy Email from the mapped template instead of the default message.

## The `easy_email_override` config entity
Config prefix `easy_email_override.easy_email_override.*`. Exported fields:

| Field | Purpose |
|---|---|
| `id`, `label` | Machine id + label |
| `module` | Target module whose email to override (e.g. `user`) |
| `key` | Target mail key (e.g. `password_reset`) |
| `easy_email_type` | The Easy Email template used to build the replacement |
| `param_map` | Sequence of `{source, destination}` — maps the original mail params (e.g. the `account` user) onto template fields |
| `copied_fields` | Per-part booleans: `from`, `reply_to`, `to`, `cc`, `bcc`, `subject`, `body_html`, `body_plain`, `attachments` — TRUE = copy that part from the original mail; FALSE = take it from the template |

## Steps to override an email
1. Create an `easy_email_type` template (see the main easy_email configure doc).
2. Add an override at the overrides collection; pick the declared email (module + key), the
   template, map its params (e.g. `account` → a user reference field), and choose `copied_fields`.
3. Trigger the original email — it is now sent as your HTML template.

## Which emails can be overridden
Any email declared as a plugin in a `{module}.emails.yml` file (discovered by
`plugin.manager.easy_email_override`). This submodule ships declarations for core **user** emails:
`register_admin_created`, `register_pending_approval`, `register_pending_approval_admin`,
`register_no_approval_required`, `status_activated`, `status_blocked`, `cancel_confirm`,
`status_canceled`, `password_reset`. The `easy_email_commerce` submodule declares
`commerce.order_receipt`. To make a new email overridable, ship your own `emails.yml` — see the
api doc.

Overrides are config, so they export/deploy with `drush config:export`.
