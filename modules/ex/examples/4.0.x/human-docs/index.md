# Examples for Developers — manual setup guide

**Examples for Developers** (`examples`) is a learning resource, not a
production feature. It's a collection of roughly 30 heavily‑commented example
submodules, each demonstrating one Drupal core API — Form API, AJAX, Batch, blocks,
entities, plugins, queues, cron, theming, and more — so developers can learn by
reading and running working, well‑documented code.

The top‑level `examples` module itself is just a small stub: it depends on core's
**Toolbar** module and adds an **Examples** toolbar tray that links to whichever
example submodules you've enabled (plus an "Enable Examples" shortcut to the Extend
page). All the real value is in the individual submodules — you enable the one API
you want to study, read its richly commented source and its automated tests, then
uninstall it when you're done.

Because these are teaching modules, they are **not** meant to be left enabled on a
production site. Think of them as a reference library and as copy‑paste scaffolding
for your own custom modules. There is no global configuration, no permissions on
the parent module, and no config schema.

This guide is written for a **human** developer. If you want terse, token‑cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead — and note that the individual example submodules are best understood
by reading their own source code directly.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable just
   the example submodules you want to study.

## Where it lives in the admin menu

Once the parent module is enabled, an **Examples** tray appears in the admin
toolbar, listing links to each enabled example submodule. Each submodule also
provides its own landing/description page and routed demo pages.

## The example submodules

Enable each independently. Each name maps to the API it teaches:

| Submodule | Teaches |
|-----------|---------|
| `action_example` | Custom actions |
| `ajax_example` | AJAX callbacks |
| `batch_example` | The Batch API |
| `block_example` | Custom block plugins |
| `cache_example` | The Cache API |
| `config_entity_example` | Configuration entities |
| `config_simple_example` | Simple configuration |
| `content_entity_example` | Building a content entity type |
| `cron_example` | Cron / scheduled tasks |
| `dbtng_example` | The database abstraction layer |
| `email_example` | Sending mail |
| `events_example` | Event subscribers |
| `field_example` | Custom field type / widget / formatter |
| `field_permission_example` | Field‑level access control |
| `form_api_example` | The Form API |
| `hooks_example` | Implementing common hooks |
| `image_example` | Image handling / derivatives |
| `js_example` | Attaching and using JavaScript |
| `menu_example` | Menus and routed pages |
| `node_type_example` | Creating a node type programmatically |
| `page_example` | Routed pages |
| `pager_example` | Pagers |
| `plugin_type_example` | Defining a custom plugin type |
| `queue_example` | The Queue API |
| `render_example` | Render arrays |
| `session_example` | Sessions and the private tempstore |
| `stream_wrapper_example` | Implementing a stream wrapper |
| `tabledrag_example` | Draggable tables |
| `tablesort_example` | Sortable tables |
| `testing_example` | Writing PHPUnit / Kernel / Functional tests |
| `theming_example` | Theming (hooks, templates, preprocess) |

## How to use it

1. Enable the parent module and the specific example you want to learn from (see
   [Installation](installation/index.md)).
2. Open the **Examples** toolbar tray and click through to that example's pages.
3. Read the submodule's source under
   `web/modules/contrib/examples/modules/<name>/` — the code and its tests are the
   real documentation.
4. Uninstall the example when you're done. Don't leave these enabled in production.
