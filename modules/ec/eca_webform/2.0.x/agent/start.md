<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# ECA Webform — agent index

Integrates [Webform](https://www.drupal.org/project/webform) with [ECA](https://www.drupal.org/project/eca).
You use it entirely from inside ECA models (`eca.eca.<id>` config entities) — no admin UI,
no configure route, no permissions, no Drush. Depends on `eca` and `webform`.

Two things it provides:
- **Events** — one derived ECA event plugin, base id `webform`, with 25 derivatives
  (`webform:<hook>`), one per Webform alter/access hook. Args are exposed as `[webform:*]` tokens.
- **Actions** — four core `#[Action]` plugins for reading/writing submission data and webform
  third-party settings.

Docs:
- **The event derivatives, the four actions, their config keys and tokens, and how to
  reference them in a model** → [plugins/events-and-actions.md](plugins/events-and-actions.md)

Key facts:
- Event base plugin id `webform`; derivative id = `webform:` + hook key, e.g.
  `webform:submission_form_alter`, `webform:submission_access`, `webform:element_alter`,
  `webform:options_alter`, `webform:access_rules`. Discover with
  `drush php:eval` over `plugin.manager.eca.event`.
- Actions (in `plugin.manager.action`): `eca_webform_submission_get_data` /
  `eca_webform_submission_set_data` (type `webform_submission`, keys `field_name` +
  `token_name`/`field_value`); `eca_webform_get_third_party_setting` /
  `eca_webform_set_third_party_setting` (type `webform`, keys `provider`, `setting_name`,
  `token_name`/`setting_value`).
- `field_name` is the element machine name; get-data writes the value into `token_name`,
  set-data writes `field_value` into the element. All fields are token-replaced.
- Three events are **collectors** (`access_rules`, `element_input_masks`, `help_info`): an
  after-execution subscriber reads the model's mutated `webform` token back into the event,
  so a model can *contribute* rules/masks/help.
