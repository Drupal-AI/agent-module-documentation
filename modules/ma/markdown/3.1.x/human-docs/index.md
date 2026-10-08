# Markdown — manual setup guide

**Markdown** (`markdown`) lets content authors write in plain-text Markdown that
is converted to valid HTML on output. It plugs into Drupal in three ways: a
**text-format filter** you add to any text format, a **programmatic parsing
service** for custom code, and a **Twig `|markdown` filter** for templates —
all backed by pluggable Markdown parser libraries (CommonMark, Parsedown, PHP
Markdown).

The most common use is the filter: you enable "Markdown" on a text format (for
example a dedicated "Markdown" format for documentation), pick which parser it
uses, and from then on anything written in that format is rendered from Markdown
to HTML when displayed. An admin page lists every parser, shows which ones are
actually installed, and lets you configure each one — its options, its enabled
extensions (such as GitHub-Flavored Markdown tables and autolinks), and how
strictly it filters the HTML it emits.

Two important things to know. First, the **parser libraries are external Composer
packages you install yourself** — the module ships the adapters but not the
libraries, so you install, for example, `league/commonmark` to get the CommonMark
parser. Second, it depends on core's **Filter** module and on the PHP `dom` and
`libxml` extensions (plus the `composer/semver` library, which Composer pulls in).
The module adds an *Administer markdown configuration* permission and defines
three plugin types (parsers, extensions, allowed-HTML) for developers. It ships no
submodules.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module and at least one
   parser library with Composer, then enable it.
2. [Configuration](configuration/index.md) — enable the Markdown filter on a text
   format, choose and configure a parser, and use it in Twig or code.

## Where it lives in the admin menu

The Markdown admin page is at **Configuration → Content authoring → Markdown**
(`/admin/config/content/markdown`). The filter itself is switched on per text
format at **Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`).
