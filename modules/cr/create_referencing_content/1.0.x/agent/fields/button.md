<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configure and place the Create Referencing Content button

Source: `src/Plugin/ExtraField/Display/CreateReferencingContentButton.php`, `create_referencing_content.module`, `components/create-referencing-content-button/`.

## Install / enable
```
composer require 'drupal/create_referencing_content:^1.0@alpha'
drush en create_referencing_content -y
```
Pulls in `epp`, `extra_field_plus`, `extra_field_configuration` automatically. `extra_field_plus` is used only behind the scenes.

## Concept
Two content types are involved:
- **Referenced** type (e.g. Article) — the content being viewed; the button is displayed on it.
- **Referencing** type (e.g. Review) — has an entity-reference field pointing back at the referenced type; its add form is what the button opens.

The button is a pseudo-field ("extra field"), not a real field, so it is enabled per bundle through Extra Field Configuration and then arranged/configured on the referenced type's Manage Display page.

## Setup steps
1. `/admin/structure/extra-field/add` — add an Extra Field Configuration, choose **Create Referencing Content button** as the provider, and select the referenced content type(s) under "Enable On".
2. `/admin/structure/types/manage/<referenced_bundle>/display` — enable the new pseudo-field (move it out of "Disabled"), click its gear icon, and set:
   - **Button label** — anchor text (`label`).
   - **Tooltip** — link `title` text, already translated (`tooltip`).
   - **Classes** — space-separated CSS classes; default `button is-primary is-medium` (`classes`).
   - **Target field** — a `select` (`#required`) of entity-reference fields on the referencing bundle whose `target_type` matches this entity type and whose `handler_settings.target_bundles` include this bundle (`target_field`, value = `entity_type.bundle.field_name`).
3. Click **Update** on the field settings, then **Save** the whole Manage Display form.

## Settings form internals
- `extraFieldSettingsForm()` defines the label/tooltip/classes textfields.
- `getExtraFieldSettingsForm()` loads all `field_config` entities, filters to `entity_reference` fields whose `target_type` equals the current `$entity_type_id` and whose `target_bundles` contain the current `$bundle`, and builds the required `target_field` select.
- `defaultExtraFieldSettings()` defaults: `label=''`, `tooltip=''`, `classes='button is-primary is-medium'`, `target_field=FALSE`.
- `settingsSummary()` renders a one-line summary of target field / label / tooltip / classes on the Manage Display row.

## Automatic EPP wiring
On saving the display, `create_referencing_content_form_entity_view_display_edit_form_alter()` appends `create_referencing_content_display_to_field_settings_form_submit()` to the form submit handlers. For each non-hidden extra field with a `target_field`, it:
- derives `short_field` by stripping a leading `field_` from the field machine name,
- builds token `[current-page:query:<short_field>]`,
- loads the `field_config` for `target_field` and sets its EPP third-party setting `epp.value` to that token, then saves.

So the referencing type's reference field is told to read its default from the query string that the button supplies. (The submit handler and `view()` duplicate the `short_field` logic — noted as a `@TODO` in source.)

## Rendering
`view(ContentEntityInterface $entity)` returns nothing unless `target_field` is set. When set it builds:
```
url = base_path() . <entity_type_id>/add/<bundle>?<short_field>=<entity->id()>
```
and renders the SDC component `create_referencing_content:create-referencing-content-button` with props `url`, `label`, `tooltip`, `classes` (exploded on spaces). The component template (`create-referencing-content-button.twig`) is a single anchor:
```
<a href="{{ url }}" title="{{ tooltip }}" class="{{ classes|join(' ') }}">{{ label }}</a>
```
`url` here points at the referencing type's **add form** (`node/add/<bundle>`), and the current entity's ID is passed as a query parameter for EPP to consume — not a direct write.

## Access / behavior notes
- The button is only a link; clicking it lands on core's standard `entity/add/{bundle}` route, which enforces normal "create <bundle> content" access. The module adds no route and no permission of its own.
- The pre-filled value is the ID of the content currently being viewed (`$entity->id()`), injected into the add form's reference field via EPP.
- Pair with the Read-only field widget module if the pre-filled reference should not be editable by the author.
