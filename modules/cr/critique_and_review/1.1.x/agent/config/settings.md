<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuration — settings form & config object

## Enable

`drush en critique_and_review`. `hook_install` is not defined; `hook_schema` creates the
`critique_and_review_reviews` table. No dependencies are declared in `critique_and_review.info.yml`
(the module relies on core `node`, `user`, `block`, `system` being present).

## Route & access

- Route `critique_and_review.admin_settings` (`critique_and_review.routing.yml`):
  path `/admin/config/content/critique_and_review`, `_form:
  \Drupal\critique_and_review\Form\CritiqueAndReviewSettingsForm`, title *"Critique And Review Module
  Settings"*.
- Requirement: `_permission: 'administer critique_and_review module'`.
- **Caveat:** the module ships **no `*.permissions.yml`**, so this permission string is never defined
  and appears on no role's permission page. In practice only user 1 (superuser access bypass) can open
  the form. Edit config directly with `drush cset critique_and_review.settings <key> <value>` or via a
  config import if a non-superuser must change it.
- Menu link `critique_and_review.admin_settings` (`*.links.menu.yml`) sits under
  `system.admin_config_content` (Configuration → Content authoring), weight 10.

## Config object `critique_and_review.settings`

Schema is in `config/schema/critique_and_review.schema.yml` (mapping keyed as `review.settings`,
type `config_object`). Install defaults in `config/install/critique_and_review.settings.yml`.

| Key | Type | Meaning | Default (install) |
|-----|------|---------|-------------------|
| `allowed_types` | sequence of string | Node type machine names on which reviewing is enabled | `['article']` |
| `review_items_titles` | sequence of string | Titles of the default Review Items (template sections) | Introduction / Main Review… / Conclusion |
| `review_items_instructions` | sequence of string | Per-item instruction/help text (index-aligned with titles) | matching guidance strings |
| `intro_text` | text | Optional help text shown at the top of the review form | (unset) |

The form (`CritiqueAndReviewSettingsForm::buildForm`) also reads/writes two boolean keys that are set
but **absent from the schema** (so they lack a declared type): `add_css` (attach the module CSS +
JS to a sidebar-placed form) and `add_more_reviews` (let reviewers add/delete their own Review Items).
`submitForm` additionally calls `->set('override_title', …)` from `$form_state->getValue('override_title')`,
but the form defines **no** `override_title` element, so that value is always null — a dead/no-op write.

## How the settings form builds Review Items

`buildForm` (`src/Form/CritiqueAndReviewSettingsForm.php`):

- `allowed_types` is a `checkboxes` element over `node_type_get_names()`.
- `intro_text` is a `text_format` element with `#format => 'basic_html'`.
- For each existing title it renders a `details` container with a title `textfield`
  (`review_module_item_title{N}`), an instructions `text_format`
  (`review_module_item_instruction{N}`, basic_html), and a *Delete this item* checkbox.
- One extra empty container lets an admin add a new item; a hidden `number_of_items` element carries
  the count.

`submitForm`: filters+sorts `allowed_types`; walks `0..number_of_items`, keeping each item whose
delete box is unchecked (title + `['value']` of the instruction text_format); appends the trailing
new item if its title is filled; saves `add_css`, `add_more_reviews`, `intro_text['value']`,
`review_items_titles`, `review_items_instructions`. Editable config name is
`critique_and_review.settings` (`getEditableConfigNames`).

## Notes

- Deleting a Review Item title in settings only changes the template; it does **not** delete stored
  reviewer rows in `critique_and_review_reviews`.
- Instructions arrays are index-aligned with titles; if an admin deletes a middle item the surviving
  indices are re-packed on save, so title↔instruction alignment is preserved.
