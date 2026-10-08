<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Configuring translation redirects

Redirects are **config entities** of type `content_translation_redirect`, stored as config
objects named `content_translation_redirect.entity.<id>`.

## The config entity

```yaml
# content_translation_redirect.entity.<id>
langcode: en
status: true
dependencies: {  }
id: node__article          # see id scheme below
label: 'Node: Article'     # auto-generated on create from the entity type / bundle label
code: 301                  # 300|301|302|303|304|305|307, or null = disabled
path: ''                   # '' = redirect to the original untranslated content; else '/some/path'
mode: all                  # translatable | untranslatable | all
```

Exported keys (`config_export`): `id`, `label`, `code`, `path`, `mode`.

## Id scheme (which content it targets)

- **`default`** — the locked **Default** redirect; applies to *every* supported entity type.
  Ships installed with `code: null`, `mode: translatable` (i.e. disabled until you set a code).
- **`<entity_type>`** — all bundles of one entity type, e.g. `node`, `taxonomy_term`.
- **`<entity_type>__<bundle>`** — one bundle, e.g. `node__article`.

At request time the most specific match wins: bundle → entity type → Default (see
[api/mechanism.md](../api/mechanism.md)).

## Fields

- **Redirect status** (`code`) — the HTTP code, or "- Disabled -" (null) to keep the rule but
  do nothing. Valid: 300, 301, 302, 303, 304, 305, 307.
- **Redirect path** (`path`) — a Drupal path starting with `/`. Blank redirects to the same
  entity in its **original (untranslated) language**.
- **Act on** (`mode`) — `translatable` (only translatable entities), `untranslatable` (only
  untranslatable ones), or `all`.

## Admin UI

Collection `/admin/config/regional/content-translation-redirect`
(route `entity.content_translation_redirect.collection`, permission
**`administer content translation redirects`**). "Add content translation redirect" offers a
**Type** select of every supported entity type / bundle that does not already have a redirect
(the label is derived automatically on save). The Default redirect always sorts first and cannot
be deleted.

## Scriptable

```php
$storage = \Drupal::entityTypeManager()->getStorage('content_translation_redirect');
$storage->create([
  'id' => 'node__article', 'code' => 301, 'path' => '', 'mode' => 'all',
])->save();                       // label is filled in automatically in preSave()

// read
$r = $storage->load('node__article');
$r->getStatusCode();   // 301
$r->getTranslationMode(); // 'all'
```

Read a redirect's config: `drush cget content_translation_redirect.entity.node__article`.
Supported entity types are those that are content entities, translatable, have a `canonical`
link template, and are not in the excluded list (block_content, comment, contact_message,
menu_link_content, shortcut).
