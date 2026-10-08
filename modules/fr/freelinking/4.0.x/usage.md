<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Freelinking is a text-format filter that turns wiki-style `[[indicator:target]]` markup into HTML links, with a pluggable set of link "indicators".

Enabled per text format, the filter parses `[[...]]` tokens and dispatches each to a Freelinking plugin selected by its indicator regex. Bundled plugins include Nodetitle, Node (nid), User, Path alias, Google/Drupal Search, Wikipedia, Drupal.org project, External URL and File. Each plugin resolves its target and returns a render array; unknown or disabled indicators either fall back to a configurable default plugin or render a themeable error, per the format's "Ignore Unknown Plugin Indicators" option. A `FreelinkingManager` service (a cached plugin manager over `container.namespaces`) discovers plugins, and the `freelinking.api.php`/attribute API lets modules add their own. A `freelinking_prepopulate` submodule integrates with the Prepopulate module.

The filter runs on content that has passed a text format's access, so exposure follows who may use that format. Two behaviors are worth noting operationally: the **External** plugin has a "scrape" option (default on) that fetches the author-supplied external URL server-side via Guzzle to derive a link title; and the **User** plugin gates email/user disclosure on permissions (see UserUnauthorized handling). Typical setup: enable the filter on a text format, disable core "Convert URLs into links" if using External, and choose which plugins and default plugin apply.
---
Freelinking is a pluggable text-format filter for wiki-style `[[indicator:target]]` links to internal and external content.
---
- Enable the Freelinking filter on a text format at Configuration → Text formats.
- Choose which freelinking plugins are active for that format.
- Set the default plugin used when no indicator is given.
- Toggle "Ignore Unknown Plugin Indicators" to hide or show errors.
- Link to a node by title with `[[nodetitle:Page One]]`.
- Link to a node by id with `[[node:123]]` (or `[[nid:123]]`).
- Link to a user profile with `[[user:name]]`.
- Link via URL alias with `[[path:some/alias]]`.
- Create a Google search link with `[[google:query]]`.
- Create a site search link with `[[search:term]]`.
- Link to a Wikipedia article with `[[wiki:Topic]]`.
- Link to a Drupal.org project with the DrupalOrg plugin.
- Link to an external URL with `[[http://example.com]]`.
- Auto-fetch an external page's title via the External plugin's scrape option.
- Disable scraping to avoid server-side fetches of external URLs.
- Link to a managed file with `[[file:name.pdf]]` on a chosen scheme.
- Provide custom link text with `[[nodetitle:Page One|Read more]]`.
- Deactivate core "Convert URLs into links" when using External links.
- Add a new indicator by writing a Freelinking plugin (attribute API).
- Use `freelinking_prepopulate` to pass values to a target form.
- Localize link resolution in multilingual sites.
- Show a themeable error for invalid indicators.
- Restrict a format (and thus freelinking) to trusted roles.
