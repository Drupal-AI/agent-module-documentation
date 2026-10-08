# Style Options Domain — manual setup guide

**Style Options Domain** (`style_options_domain`) is a lightweight integration
between the Style Options and Domain modules. On a multi-domain site, it lets you
control which style choices editors see on a **per-domain** basis — so each domain
can expose its own set of styling options — without forking content types,
creating separate fields, or writing custom code.

The problem it solves is domain-specific styling on a shared content structure. It
works by decorating Style Options' discovery service to filter the available
options according to the active domain: an option can be disabled by default
across all domains and then selectively re-enabled for specific domain machine
names. You declare this domain context directly in your `*.style_options.yml`
files using a `contexts.domain` key, following the same opt-in pattern Style
Options uses for its other context types.

The **Domain** module is a soft dependency: if it is absent, or if no domain is
negotiated (as during CLI operations or site install), all style options are shown
unchanged and no errors occur. Style Options Domain depends on **Style Options**,
provides its own permissions, and supports Drupal 10 and 11. It is a theming and
site-building enhancement with no content or access role of its own, configured
through YAML rather than an admin form.

This guide is written for a **human** setting the module up. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is no settings screen. In a paragraph type's (or component's)
`*.style_options.yml` file, add a `contexts.domain` key to the options you want to
scope by domain: disable an option by default across all domains, then re-enable it
for the specific domain machine names that should offer it. When a domain is
active, editors on that domain see only the options enabled for it; when no domain
is negotiated, all options show as normal.
