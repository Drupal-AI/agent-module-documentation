<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Settings: enabling content types

## Install / enable

`ddev drush en content_reminders -y`. No contrib dependencies (core node + mail system only);
core `^9 || ^10 || ^11`. `content_reminders.info.yml` declares `configure: content_reminders.form`,
so the module's *Configure* link points at the settings form.

## Settings form & config object

`src/Form/ContentRemindersSettingsForm.php` (`ConfigFormBase`), form id
`content_reminders_settings_form`, route `content_reminders.form` at
**`/admin/config/development/content_reminders`**, requirement `administer site configuration`.

- Editable config: `content_reminders.settings`.
- Single element `content_types` — `checkboxes` (required), options from `getContentTypes()` which
  loads all `node_type` entities (id → label). `submitForm()` writes the selected ids to
  `content_reminders.settings:content_types`.

Config schema (`config/schema/content_reminders.schema.yml`): `content_reminders.settings` is a
`config_object` with `content_types` as a `sequence` of strings.

## Effect

The saved `content_types` list is what `hook_form_alter` checks (`in_array($entity->bundle(),
$allowed_types)`) before injecting the inline "Content Reminder" fieldset on a node's edit form.
Only content types selected here get the inline reminder UI; the standalone
`/admin/structure/content_reminder` add/edit forms work regardless of this setting (their `nid`
field accepts any node via entity autocomplete).

## Example config export

```yaml
# content_reminders.settings.yml
content_types:
  article: article
  page: page
```
