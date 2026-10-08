<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Bundle Classes (bundle_classes) — agent index

A **reference/teaching module** with worked examples of Drupal entity **bundle classes**. Explicitly
**NOT for production** — read the code and copy the patterns into your own project module. Version
**1.0.0-alpha2**. Core `^10.5 || ^11.2 || ^12`. License GPL-2.0-or-later.

- **Dependency:** `bca:bca` (Bundle Class Attribute, `drupal/bca ^1.1.1`) — provides the `#[Bundle]`
  attribute used to register a bundle class.
- **Provides:** no routes, no permissions, no config, no Drush. One autowired hook service, one
  bundle class, and a bundled demo theme.

## What it actually is (from source)

- **`src/Entity/Node/Article.php`** — `final class Article extends Node`, annotated
  `#[Bundle(entityType: 'node', bundle: 'article')]`. Adds `getLastUpdatedDate(): array` which
  returns a render array from `$this->get('changed')->view([...])` (a `timestamp` formatter, inline
  label, custom date format `j F Y - g:ia`) with `#title` set to a `TranslatableMarkup('Last updated')`.
- **`src/Hook/BundleClassesHooks.php`** — `#[Hook('entity_bundle_info_alter')]` static method
  `entityBundleInfoAlter()` that sets `$bundles['node']['article']['class'] = Article::class` when the
  article bundle exists. Registered as an autowired service in `bundle_classes.services.yml`.
- **`bundle_classes.module`** — thin `#[LegacyHook]` shim delegating
  `hook_entity_bundle_info_alter()` to the service. No global logic.
- **`themes/bundle_class_demo/`** — an Olivero sub-theme whose `node--article.html.twig` calls
  `{{ node.getLastUpdatedDate }}`. Documented as a nested "submodule" tree here:
  [modules/bundle_class_demo/1.0.x/agent/start.md](../modules/bundle_class_demo/1.0.x/agent/start.md).
- **`tests/src/Kernel/ArticleBundleClassTest.php`** — kernel test asserting `Node::load()` returns
  the `Article` instance for article nodes (and not for other bundles), and that
  `getLastUpdatedDate()['#title']` is `"Last updated"`.

## Solution docs

- **How the bundle class + OOP hook work, and how to copy the pattern into your own module** →
  [api/bundle-class.md](api/bundle-class.md)
- **The bundled Bundle Class Demo theme (template calling the method)** →
  [modules/bundle_class_demo/1.0.x/agent/start.md](../modules/bundle_class_demo/1.0.x/agent/start.md)

No configuration UI, no `configure` route, no settings to manage.
