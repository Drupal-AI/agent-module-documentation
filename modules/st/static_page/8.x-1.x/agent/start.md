<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Static Page (static_page) — agent index

Makes selected **node types** render their entire page from **one long-text field**, returned as the
raw HTTP response with **no theme layer**. Package `Other`. Depends only on core **`node`**. Core
requirement `^9 || ^10 || ^11`. License GPL-2.0-or-later. Version 8.x-1.x (8.x-1.0-rc1).

- **Full mechanism, the settings form, config object/schema, routes & permissions** →
  [config/settings.md](config/settings.md)

## What it actually is

- **No entity type, no field type, no plugin, no permission, no hook, no Drush.** The whole module
  is one config form + one event subscriber.
- An **event subscriber** `StaticPageSubscriber` (`src/EventSubscriber/StaticPageSubscriber.php`,
  service `static_page.subscriber`, tagged `event_subscriber`) listens on `KernelEvents::REQUEST`
  (`onRequest`). On `entity.node.canonical` / `entity.node.revision` it loads the node, looks up the
  field mapped to the node's bundle in config `static_page.fields`, and if one is mapped calls
  `$event->setResponse(new Response($node->get($field)->value))` — the field's stored value becomes
  the entire page body, short-circuiting rendering/theming.
- A **settings form** `StaticPageSettingsForm` (`src/Form/StaticPageSettingsForm.php`, a
  `ConfigFormBase`) at route `static_page.settings` (`/admin/config/content/static_page`,
  `_permission: administer site configuration`) lists every node type with a select of its eligible
  long-text fields and writes the bundle→field map into `static_page.fields`.

## Config

- Object **`static_page.fields`** — one key `fields`, a sequence mapping `node_type => field_machine_name`.
  Schema `config/schema/static_page.schema.yml` (`config_object`, sequence of strings). Install default
  `config/install/static_page.fields.yml` = `fields: {}` (empty; no type is static until configured).

## Eligible fields

Selectable fields are those on the bundle whose type is `string_long`, `text_long` or
`text_with_summary`, excluding `revision_log` (`StaticPageSettingsForm::buildForm()`).

## Menu

`static_page.links.menu.yml` places the settings link under **Configuration → Content authoring**
(`parent: system.admin_config_content`).
