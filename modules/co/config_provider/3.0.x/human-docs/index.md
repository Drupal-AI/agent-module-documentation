# Configuration Provider — manual setup guide

**Configuration Provider** (`config_provider`) is a developer framework, not a
feature you switch on and use through the admin screens. It generalises the way
Drupal answers a deceptively simple question: *"What configuration does a module
or theme actually provide?"*

Out of the box, Drupal core only knows about two fixed places an extension can
ship config — the `config/install` folder (applied when the extension is
installed) and the `config/optional` folder (applied when its dependencies are
met). Configuration Provider turns that fixed behaviour into a pluggable system.
It defines a `ConfigProvider` plugin type and a **collector service** so that
tools — packaging modules like Features, config distribution and update tools,
and custom deployment scripts — can enumerate the complete set of config an
extension would install or update, including config from non-standard locations.

Internally it ships two default provider plugins that mirror core (`config/install`
and `config/optional`), collects everything each provider reports into a shared
in-memory storage, and decorates core's config installer so those providers
participate when an extension is installed. In short, it is plumbing that other
modules build on so they all agree on "where configuration comes from" without
each of them re-implementing core's install-storage logic.

Because it is infrastructure, Configuration Provider has **no admin page, no
settings form, no permissions, and no Drush commands** of its own. You install
it because another module depends on it, or because you are writing code that
uses its plugin type and collector service. The developer-facing details — the
plugin base class and annotation, the collector service, and the config-installer
decorator — live in the sibling agent docs.

This guide is written for a **human**. If you want terse, token-cheap references
for an AI coding agent (including the plugin API and the collector service), read
the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Nowhere — there is no menu item and no settings page. Configuration Provider is a
framework consumed in code by other modules. Once enabled, its `ConfigProvider`
plugin type and its `config_provider.collector` service are available to any
module that requires them.

## How to use it

For site builders, "using" it usually means nothing more than installing it
because a module you want (for example a config packaging or distribution tool)
lists it as a dependency. For developers, you either add your own `ConfigProvider`
plugin to report config from a custom directory, or call the
`config_provider.collector` service to ask which configuration is installable for
a given set of extensions and then read the results back from the
`config_provider.storage` in-memory store. The step-by-step API — the plugin base
class, annotation, provider weights, the two built-in providers, and the
`config.installer` decorator — is documented in the
[`agent/`](../agent/start.md) references.
