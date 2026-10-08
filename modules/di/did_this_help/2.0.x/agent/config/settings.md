<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration & settings

## Install / enable
`drush en did_this_help -y`. Pulls core `views` (dependency of the shipped report View). On install
Drupal creates the `did_this_help` DB table (`did_this_help.install` `did_this_help_schema()`) and
imports the default config below. Then place the **Did this help?** block (plugin id `did_this_help`)
in a region via block layout to show the widget.

## Config object: `did_this_help.settings`
Two keys, schema in `config/schema/did_this_help.schema.yml` (`config_object`):

| Key | Type | Meaning |
|-----|------|---------|
| `question` | string | Prompt shown above the Yes/No buttons. |
| `no_answers` | string | Newline-separated list of preset reasons offered when "No" is chosen. |

Note: the schema file labels the first key `message`, but every reader/writer uses `question`.
Install defaults live in `config/install/did_this_help.settings.yml` (question `"Did this help?"`
and five default `no_answers`, one per line).

## Settings form
`Drupal\did_this_help\Form\DidThisHelpSettingsForm` (`src/Form/DidThisHelpSettingsForm.php`),
extends `ConfigFormBase`, form id `did_this_help_admin_settings`, editable config
`did_this_help.settings` (`SETTINGS` const).

- Route `did_this_help.settings` → `/admin/config/did_this_help/settings`
  (`did_this_help.routing.yml`), requires permission **administer did this help**.
- Admin-menu link under *Configuration* (`did_this_help.links.menu.yml`, parent
  `system.admin_config_content`).
- Fields: `question` (required textfield), `no_answers` (required textarea, "One answer per line").
  `submitForm()` saves both keys back to the config object.

## Permissions (`did_this_help.permissions.yml`)
- **administer did this help** — change the question and answers; `restrict access: true`.
- **view did this help reports** — view the report View page.

Submitting feedback itself needs no special permission — it is gated only by who can see the block
(block layout visibility). The form is a core `FormBase`, so it carries Drupal's standard form/CSRF
token; there is no per-vote flood limit, so scope block visibility appropriately.

## Runtime rendering of the question
`DidThisHelpForm::buildForm()` prints the configured `question` inside a `<div class="question">`.
Keep edit access to these settings limited to trusted admins (the permission is already
`restrict access: true`).
