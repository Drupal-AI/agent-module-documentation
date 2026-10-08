<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Default content

`drupalorg_test_content.info.yml` declares only `dependencies: [default_content:default_content]`. The module has no `src/`, routing, services, config or hooks — its entire payload is the `content/` directory of `default_content` YAML exports (each keyed by entity UUID). `default_content` imports these when the module is enabled.

## What ships (`content/`)

| Directory | Entities | Approx. count |
|---|---|---|
| `content/node/` | nodes (with embedded paragraph entities) | ~33 nodes |
| `content/media/` | media entities | ~51 |
| `content/file/` | files | ~118 |
| `content/taxonomy_term/` | taxonomy terms | ~94 |
| `content/block_content/` | custom block content | 2 |
| `content/user/` | users | 3 |

## Install

```bash
drush en drupalorg_test_content -y
```

Content imports automatically via `default_content`. Because it depends on entity types/bundles and fields defined elsewhere (core + the parent `drupalorg` setup), enable it on a site where those exist. Development/local use only — do not enable in production.
