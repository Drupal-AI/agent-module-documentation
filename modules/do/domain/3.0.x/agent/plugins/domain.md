<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Plugins Domain ships

Domain defines **no plugin type of its own** (`provides_plugin_types: []`); it ships
implementations of core plugin types that you configure, not extend. Reach for these
instead of writing custom code.

## Blocks

- **Domain switcher** (`domain_switcher_block`) — dropdown/links to switch between domains
  (perm `use domain switcher block`).
- **Domain navigation** (`domain_nav_block`) — nav list linking to each domain
  (perm `use domain nav block`; config: `link_options`, `link_theme`, `link_label`).
- **Domain server** (`domain_server_block`) — debug block showing negotiation details.
- **Domain token** (`domain_token_block`) — renders domain tokens.

## Condition — `domain`

Show/hide any block (or other condition-aware plugin) per active domain. Config schema
`condition.plugin.domain` with a `domains` sequence of domain machine names. Configure it
in a block's "Visibility → Domain" tab.

## Views plugins

- **Access** `domain` — restrict a whole View display to listed domains.
- **Filter** `domain_filter` — filter rows by domain (in-operator).
- **Argument default** `domain` — default a contextual filter to the active domain.

## Entity-reference selection

- `domain` (`DomainSelection`) and `domain_admin` (`DomainAdminSelection`) — use these as
  the reference selection handler when a field references domain entities (the
  `domain_access`/`domain_source` fields target `domain` this way).

## Actions

Bundled actions operate on domain records (used from the admin list / VBO):
`domain_default_action`, `domain_enable_action`, `domain_disable_action`,
`domain_delete_action`.

## Language negotiation

`LanguageNegotiationDomainUrl` — a language negotiation plugin that derives the language
from the active domain (enable it under Language → Detection, needs
`domain.settings:language_negotiation`).

## Validation constraints

Hostnames on the `domain` entity are validated by the `DomainHostname` and
`DomainUniqueHostname` constraints — reuse them if you build hostnames programmatically.
