# Admin delete form, route & permission (forms)

## Route & access

`orphans_media.routing.yml`:

```yaml
orphans_media.delete:
  path: '/admin/config/media/orphans-media'
  defaults:
    _title: 'Orphans Media'
    _form: 'Drupal\orphans_media\Form\OrphansMediaDeleteForm'
  requirements:
    _permission: 'access orphans media delete'
```

- Single route, single form. Access is gated by the module's own permission
  `access orphans media delete` (defined in `orphans_media.permissions.yml`).
- Menu link `orphans_media.delete` (`orphans_media.links.menu.yml`) puts it under
  `system.admin_config_media` (*Administration → Configuration → Media*).
- It is also the module's `configure` link (`info.yml: configure: orphans_media.delete`).

## Form structure — `OrphansMediaDeleteForm`

`src/Form/OrphansMediaDeleteForm.php`, form id `orphans_media_delete`, extends `ConfirmFormBase`.
It composes two traits: `ListFormTrait` (the list + filters) and `ConfirmFormTrait` (the
confirmation step). Because it is a normal Form API form, the standard **form CSRF token** protects
submission.

`buildForm()` chooses which screen to render based on form storage:

```php
$storage = $form_state->getStorage();
return !isset($storage['confirm'])
  ? $this->buildListForm($form, $form_state)   // screen 1
  : $this->buildConfirmForm($form, $form_state); // screen 2
```

Dependencies wired in `create()`: the manager (`orphans_media.manager`), `request_stack`,
`pager.manager`.

## Screen 1 — list & filter (`ListFormTrait::buildListForm`)

- Renders a `tableselect` (`$form['table']`) of unused media. Columns: Title (`name`), ID (`mid`),
  Type (`bundle`), Created (`created`), Updated (`changed`), plus per-row **Edit** and **Delete**
  links to the core routes `entity.media.edit_form` / `entity.media.delete_form`.
- Totals from `OrphansMediaManager::getTotalUnusedMedias()`; rows from `getUnusedMedias()`; paging via
  `pager.manager`.
- **Filters** live in a `details` element and are carried as **query-string parameters** (read in
  `getFilterValues()` / applied on submit by `submitFilter()`, cleared by `resetFilter()`):

  | Filter field | Query param | Applied as (see `OrphansMediaManager::applyFilters`) |
  |---|---|---|
  | Title | `title` | `name` LIKE `%…%` (value passed through `Connection::escapeLike`) |
  | Created from / to | `created_from` / `created_to` | `created >= strtotime(date 00:00:00)` / `<= …23:59:59` |
  | Updated from / to | `updated_from` / `updated_to` | `changed >= …` / `<= …` |
  | Media bundle | `media_bundle[]` | `bundle IN (…)` (options from `getAvailableMediaBundles()`) |
  | Items per page | `items_per_page` | pager page size; default `DEFAULT_ITEMS_PER_PAGE = 25`, select options 25–1000 |

- **Sorting** uses the `order` / `sort` query params matched against the table header (`name`, `mid`,
  `bundle`, `created`, `changed`); default sort is `created DESC`.
- The "Delete selected items" submit runs `validateListForm()` (errors if nothing is selected) and is
  `#disabled` when the total is `0`.

## Screen 2 — confirm (`ConfirmFormTrait::buildConfirmForm`)

`submitForm()` collects the checked rows into `storage['references']` as `[mid => label]`, sets
`storage['confirm'] = TRUE`, and rebuilds:

```php
foreach ($form_state->getValue('table') as $reference) {
  $media = Media::load($reference);
  if ($media) {
    $references[$media->id()] = $media->label();
  }
}
$form_state->setStorage(['references' => $references, 'confirm' => TRUE])->setRebuild();
```

The confirm screen (theme `confirm_form`, title *"Delete these items ?"*) lists the labels and, on
confirm (`submitConfirmForm()`), calls `OrphansMediaManager::deleteMediaBatch($references)` which
sets a Drupal batch (see [../api/manager.md](../api/manager.md)). Cancel returns to
`orphans_media.delete` (`getCancelUrl()`).
