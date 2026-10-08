<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Conditional 404 Pages — config entity, forms, routes, the swap mechanism

Everything below is grounded in the module source (`src/**`, `*.yml`,
`config/schema/conditional_404_page.schema.yml`).

## Install / enable

`drush en conditional_404_pages -y`. Core `^10 || ^11`. No composer requirements, no declared
module dependencies; at runtime it uses core `node` (target), `path_alias` (alias lookup) and the
`system`-provided `request_path` condition plugin. No `.install`, no schema install defaults —
records are created only through the UI.

## The config entity

`conditional_404_page` (`src/Entity/Conditional404Page.php`, `@ConfigEntityType`). Properties and
exported config keys (`config_export`):

| Key | Type | Meaning |
|-----|------|---------|
| `id` | string (machine name) | entity id |
| `label` | label | admin label |
| `page` | string | **node id** of the content rendered as the 404 body |
| `pathCondition` | array | serialized core `request_path` condition config (`pages`, `negate`, `context_mapping`) |
| `status` | bool | enabled flag; only `status = TRUE` records are evaluated |
| `weight` | int | tie-breaker; **highest weight wins** when several match |

Schema: `config/schema/conditional_404_page.schema.yml` types `pathCondition` as
`condition.plugin.request_path`, so it reuses core's condition schema. Accessors are defined on
`Conditional404PageInterface` (`getPage`/`setPage`, `getPathCondition`/`setPathCondition`,
`getStatus`/`setStatus`, `getWeight`/`setWeight`).

Example exported record (`conditional_404_page.conditional_404_page.<id>.yml`):

```yaml
id: brand_a
label: 'Brand A 404'
page: '42'
pathCondition:
  id: request_path
  negate: false
  context_mapping: {  }
  pages: "/brand-a\n/brand-a/*"
status: true
weight: 10
uuid: ...
```

## Admin UI, routes & permission

Routes come from `Conditional404PageHtmlRouteProvider` (extends core `AdminHtmlRouteProvider`; it
just returns `parent::getRoutes()` unchanged), driven by the entity's `links`:

- `entity.conditional_404_page.collection` — `/admin/structure/conditional_404_page` (the
  `configure` route; menu link "Conditional 404 Page" under *Structure*,
  `conditional_404_pages.links.menu.yml`). List columns: label + machine name
  (`Conditional404PageListBuilder`).
- `entity.conditional_404_page.add_form` — `/admin/structure/conditional_404_page/add` (action link,
  `conditional_404_pages.links.action.yml`).
- `entity.conditional_404_page.edit_form` — `.../{conditional_404_page}/edit`.
- `entity.conditional_404_page.delete_form` — `.../{conditional_404_page}/delete`.
- `entity.conditional_404_page.canonical` — `.../{conditional_404_page}`.

All are gated by the entity's `admin_permission`
**`administer conditional 404 page configuration`** (the only permission the module defines,
`conditional_404_pages.permissions.yml`). Delete is a standard `EntityConfirmFormBase`
(`Conditional404PageDeleteForm`) — CSRF-protected confirm form.

## The form (`Conditional404PageForm`, extends `EntityForm`)

Injects `plugin.manager.condition` and instantiates one `request_path` condition plugin. Fields:
`label`, machine-`id`, `weight` (`#type weight`, delta 50), `page`
(`entity_autocomplete`, `#target_type => node` — pick the node to show on 404), then it merges the
`request_path` plugin's own `buildConfigurationForm()` output (`unset($form['negate'])` — negation
is intentionally not offered), relabels the plugin's `pages` element to "Path Conditions", and a
`status` checkbox. `submitForm()` runs the plugin's `submitConfigurationForm()` and stores the
plugin config into the `pages` form value; `save()` writes it via `setPathCondition()` and
redirects to the collection with a status message.

## How the 404 swap works

Service `conditional_404_pages.conditional_404_page_service` (`Conditional404PageService`, args
`@plugin.manager.condition`, `@entity_type.manager`, `@path_alias.manager`):

- `getApplicableConfigEntities()`: `entityTypeManager->getStorage('conditional_404_page')
  ->loadByProperties(['status' => TRUE])`, creates one `request_path` condition, and for each entity
  calls `$condition->setConfiguration($config->getPathCondition())` then `$condition->evaluate()`;
  matches are collected.
- `getConditional404Path(array $entities)`: `usort` by `getWeight()` **descending**, `reset()` the
  first, `$nid = ->getPage()`, returns `aliasManager->getAliasByPath('/node/'.$nid)`.

Decorator `EventSubscriber/ConditionalPageExceptionHtmlSubscriber` (`decorates
exception.custom_page_html`, priority 10; extends core `CustomPageExceptionHtmlSubscriber`) overrides
`on404(ExceptionEvent $event)` only:

1. `$entities = service->getApplicableConfigEntities();`
2. if non-empty → `$path = service->getConditional404Path($entities);` and (if non-empty)
   `makeSubrequestToCustomPath($event, $path, Response::HTTP_NOT_FOUND)` — the inherited core method,
   which renders the path as an access-checked sub-request and keeps the 404 status.
3. else → falls back to `config.factory->get('system.site')->get('page.404')` and sub-requests that.

Note the fallback branch triggers only when there are **no matching enabled entities**; if entities
match but the winner's `page` resolves to an empty path, nothing is swapped and Drupal's default 404
renders.

## Operate it

1. Create/translate the node you want as the section 404.
2. *Structure → Conditional 404 Page → Add*: set label, choose that node in **Page**, enter path
   patterns (e.g. `/shop`, `/shop/*`), set a **weight** (higher = priority on overlap), tick
   **Enabled**, save.
3. Request a non-existent URL under that path — the node renders with a 404 status.
4. Language-prefixed paths render the node's matching translation automatically.
5. Leave everything disabled to keep core's single `system.site:page.404` behaviour.
