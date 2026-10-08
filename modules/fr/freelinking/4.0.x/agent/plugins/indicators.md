<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Freelinking indicators & plugin surface

## Syntax
`[[indicator:target|optional text]]` — no space after the colon. With no indicator, the format's **default plugin** is used.

## Bundled indicator plugins (`src/Plugin/freelinking/`)
| Indicator | Plugin | Resolves to |
|---|---|---|
| `nodetitle` | NodeTitle | node URL matched by title |
| `node` / `nid` | Node | node by id |
| `user` | User | user profile (email/user disclosure is permission-checked) |
| `path` | PathAlias | internal path/alias |
| `search` | Search | site search results |
| `google` | GoogleSearch | Google search URL |
| `wiki` | Wiki | Wikipedia article |
| (drupalorg) | DrupalOrg | drupal.org project |
| `http` / `https` / `ext` | External | external URL (see scrape below) |
| `file` | File | managed file on a chosen stream scheme |
| (fallback) | Builtin | always-on internal handlers |

## Extending
Register a new plugin with the `#[Freelinking(id, title, settings)]` attribute (or annotation); discovery is handled by the `freelinking.manager` service over `container.namespaces` with cache backend `cache.discovery`. See `freelinking.api.php`.

## Operational notes
- **External scrape:** `settings['scrape']` defaults to `1`. When on and no link text is given, `External::getPageTitle()` issues a server-side Guzzle `GET` to the linked URL to read `<h1>/<h2>` for the title. Set **Scrape external URLs → No** to turn this off.
- Disable core **"Convert URLs into links"** on any format where the External plugin is used.
- Unknown indicators either fall back to the default plugin or render `freelink-error` depending on the format's "Ignore Unknown Plugin Indicators" setting.
