<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Pagerer example — agent index

Demo submodule of **Pagerer**. Adds one public page that renders sample Pagerer-styled pagers.
No config, no settings, no permissions, no services, no plugins. Depends on `pagerer`.

Everything it does:
- Route `pagerer_example.page` → path **`/pagerer/example`**, requirement `_access: 'TRUE'`
  (publicly accessible), controller
  `Drupal\pagerer_example\Controller\PagererExampleController::examplePage`
  (title callback `::examplePageTitle`, which shows the running Pagerer version).
- The controller runs two paged queries (core `watchdog` element 0, `key_value` element 1) with
  `PagerSelectExtender`, rendering two tables each with its own pager — demonstrating multiple
  pagers on one page.
- It injects `pagerer.style.manager` (the Pagerer style plugin manager), `database`, and
  `extension.list.module`.

Use it to preview/learn Pagerer; uninstall it on production. See the parent module docs at
`../../../../3.1.x/agent/start.md` for pager configuration.
