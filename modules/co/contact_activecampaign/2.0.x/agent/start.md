<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Contact ActiveCampaign — agent index

info.yml name: **Contact ActiveCampaign** (`contact_activecampaign`). Version **2.0.0**. Core `^11`.

Forwards **core Contact-form submissions** (`contact_message` entities) to **ActiveCampaign** (email
marketing / CRM SaaS). Per contact form and per configured ActiveCampaign account, an admin maps
individual contact-form fields to ActiveCampaign contact fields, custom fields, account fields, list
subscriptions, and tags. On submit the mapping is applied and the submitter becomes (or updates) an
ActiveCampaign contact — created/updated **asynchronously on cron**, not during the web request.

All actual API transport and credentials are handled by the **`activecampaign_api`** dependency (this
module never talks HTTP directly). Dependencies: `drupal:contact`, `activecampaign_api:activecampaign_api`.
No Drush commands, no JS/CSS libraries. Provides a config schema and one permission. Maintainer: Ruud
Simons (Groowup). Not covered by Drupal's security advisory policy.

- **submit → queue → cron send flow, field mapping, accounts, lists, tags** → [send-flow.md](send-flow.md)

## Where credentials live (important)

This module stores **no** ActiveCampaign credential. The API **base URL** and **API token** are
properties of the `activecampaign_api_account` config entity, entered on the ActiveCampaign API
account form at `/admin/config/services/activecampaign-api/account` (provided by the
`activecampaign_api` module). This module only selects one of those accounts and calls its endpoint
factory (`@activecampaign_api.endpoint_factory`).

## Routes (`contact_activecampaign.routing.yml`)

Both require permission **`manage contact_activecampaign form settings`** and are `_admin_route`.

- `entity.contact_form.contact_activecampaign` — `/admin/structure/contact/manage/{contact_form}/activecampaign`
  → `ContactFormActiveCampaignController::page()`. If no AC API account exists, shows a message linking
  to the account collection; otherwise redirects to the settings form for the first account.
- `entity.contact_form.contact_activecampaign_api_account` —
  `/admin/structure/contact/manage/{contact_form}/activecampaign/{activecampaign_api_account}` →
  `Form\ContactFormSettingsForm`. The per-form/per-account mapping UI.

A local task tab ("Send submitted forms to ActiveCampaign") is added to each contact form via
`contact_activecampaign.links.task.yml` + `Plugin/Derivative/ActivecampaignApiAccountLocalTasks`.

## Permission (`contact_activecampaign.permissions.yml`)

- `manage contact_activecampaign form settings` — gates both routes above. Admin-level: it governs how
  submitted data leaves the site for a third party. (Not marked restricted, but effectively so.)

## Settings form (`Form/ContactFormSettingsForm.php`)

Drupal `FormBase` (CSRF token applies). Per contact form + account it configures: `enabled`,
`send_when` (`always` or "when boolean field X checked"), contact-determination method (email —
mapping the special `contact:email` option is required, enforced in `validateForm`), create-contact-
when-missing, and (only if the AC subscription supports accounts) the account-determination method and
create-account-when-missing. It builds a **field-mapping** matrix of every eligible `contact_message`
field × column against AC field options (built-in contact fields + AC custom fields + account fields
fetched live from the API), plus per-list subscription selects and a tag checkbox set (lists/tags
fetched live). Settings are saved to `contact_activecampaign.<form>.<account>` config
(see [send-flow.md](send-flow.md)).

## Field-mapper plugin type

Annotation-based plugin type `@ContactActivecampaignFieldMapper` (`FieldMapperPluginManager`,
`FieldMapperPluginBase`/`Interface`, `Annotation/ContactActivecampaignFieldMapper`). Each plugin
declares which Drupal field types it can map and how to extract a value:
- `DefaultFieldMapper` — integer, string, email, string_long, text_long, list_string, list_integer,
  boolean, datetime, telephone, phone_international.
- `AddressFieldMapper` — `address` (only when the `address` module is installed).
- `EntityReferenceFieldMapper` — `entity_reference`; sends the referenced entity's label
  (`hook_contact_activecampaign_entity_reference_field_mapper_label_alter` can rewrite it).

## Runtime pieces

- `contact_activecampaign_entity_insert()` (`.module`) — queues each enabled submission.
- `MessageQueueWorker` — `contact_activecampaign_message` cron queue (30s), drains to
  `ContactFormManager::sendToActiveCampaign()`.
- `Service/ContactFormManager` — the core: enabled/send-when checks, field mapping application,
  contact/account create-or-update, list subscriptions, tags. See [send-flow.md](send-flow.md).

## Hooks provided (`contact_activecampaign.api.php`)

- `hook_contact_activecampaign_mapped_field_value_alter(&$value, $field, $ac_property)` — rewrite a
  value before it is sent.
- `hook_contact_activecampaign_allowed_base_fields_alter(&$allowed_base_fields)` — change which core
  base fields (`name`, `mail`, `subject`, `message`) are offered for mapping.
- `hook_contact_activecampaign_entity_reference_field_mapper_label_alter($label, $entity)`.

## Install / updates (`contact_activecampaign.install`)

No `hook_requirements`. Update hooks migrate old field-mapping key formats: `update_8001` adds schema
column suffixes, `update_9001` moves third-party settings into `contact_activecampaign.*.*` config for
`activecampaign_api` 2.x (depends on `activecampaign_api` update 8801), `update_9002` switches the
`field_column` separator to `:`.

## Key facts

- Sends are **not immediate** — they happen on the next cron run via the
  `contact_activecampaign_message` queue.
- Mapping the ActiveCampaign contact **email** property to a form field is mandatory (form validation
  blocks saving otherwise); it is the key used to find/create the contact.
- "Accounts" (company records) features are shown only if the connected ActiveCampaign subscription
  supports them; otherwise a warning is displayed and those settings are hidden.
- Only mapped, non-empty fields are forwarded; unmapped fields are never sent.
- Multiple ActiveCampaign accounts can be targeted from the same contact form (one settings page per
  account); a submission is queued once per enabled account.
- Data forwarded to ActiveCampaign is PII (submitter name/email/message + mapped fields) — an
  operator consent/DPA consideration.
