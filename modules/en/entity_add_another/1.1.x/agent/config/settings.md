<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Entity Add Another — mechanism, config & permissions

How the "Save and Add Another" button is injected, where its redirect goes, and how to enable it.
Source: `src/Hook/EntityAddAnotherHooks.php`, `src/Form/EntityAddAnotherSettingsForm.php`,
`entity_add_another.module`, `entity_add_another.routing.yml`, `entity_add_another.permissions.yml`,
`config/{install,schema}/`.

## Install / enable
- `composer require drupal/entity_add_another`; `drush en entity_add_another`.
- No module dependencies (`entity_add_another.info.yml` has none); core `^10.1 || ^11 || ^12`.
- On install `config/install/entity_add_another.add_another_entities.yml` seeds
  `add_another_entities: []` — the button appears nowhere until you enable at least one type/bundle.

## Configuration
- Settings form `EntityAddAnotherSettingsForm` (`ConfigFormBase`), form id `entity_add_another_settings_form`,
  route `entity_add_another.settings` at `/admin/config/content/entity_add_another`
  (`_admin_route: TRUE`, menu link under *Configuration → Content*).
- `buildForm()` lists every `ContentEntityTypeInterface` definition (from `entity_type.manager`) and each of
  its bundles (`entity_type.bundle.info`) as a `checkboxes` element. Option keys are the entity-type machine
  name (e.g. `node`) and `<entity_type>__<bundle>` (e.g. `node__article`); bundle labels are rendered via the
  escaped `@entity of type @bundle` placeholder.
- `submitForm()` filters out unchecked boxes (`array_values(array_filter(...))`) and writes the surviving keys
  to config object `entity_add_another.add_another_entities` → key `add_another_entities`.
- Schema `entity_add_another.schema.yml`: `config_object` whose `add_another_entities` is a `sequence` of
  `string`. Editable config name declared in `getEditableConfigNames()`.

## Form-alter mechanism
- Hooks live in the OOP class `Drupal\entity_add_another\Hook\EntityAddAnotherHooks` (registered as a service
  in `entity_add_another.services.yml` with `current_user`, `path.current`, `config.factory`, `request_stack`).
  `.module` keeps thin `#[LegacyHook]` wrappers (`entity_add_another_help`, `entity_add_another_form_alter`,
  `entity_add_another_module_implements_alter`).
- `formAlter()` (`#[Hook('form_alter', order: new OrderAfter(modules: ['inline_entity_form']))]`) returns early
  unless ALL of:
  1. current user has permission `use entity add another`;
  2. the form object is a `ContentEntityFormInterface` whose entity is a `ContentEntityInterface`, operation in
     `edit`/`add`/`default`;
  3. the entity `isNew()`, and its `<entity_type>` OR `<entity_type>__<bundle>` key is present in config
     `add_another_entities` (`array_intersect`).
- When all hold it clones the form's existing `actions.submit` into `actions.entity_add_another`, relabels it
  `t('Save and Add Another')`, and appends the static submit callback
  `EntityAddAnotherHooks::entityAddAnotherSubmitHandler` (which resolves the service and calls
  `submitEntityAddAnother()`). The button therefore reuses the entity form's own save/validation path.

## Redirect behavior
- `submitEntityAddAnother(FormStateInterface)` removes the `destination` query param from the request, takes
  the current internal path from `path.current` (`getPath()`), re-appends the remaining query string, and calls
  `$form_state->setRedirectUrl(Url::fromUserInput($redirect))`.
- Net effect: after saving, the editor is returned to the same add form (internal path only) with its query
  string preserved (minus `destination`), so they can immediately create another entity.

## Permissions (`entity_add_another.permissions.yml`)
- `administer entity add another` — gates the settings route.
- `use entity add another` — required for `formAlter()` to show/attach the button.

## Ordering note
- `entity_add_another_module_implements_alter()` (and the `OrderAfter` attribute) force this module's
  `form_alter` to run right after `inline_entity_form`'s, so the button is added to the correct `actions`
  element when IEF is present.
