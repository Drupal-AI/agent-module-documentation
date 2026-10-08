# Analyze — manual setup guide

**Analyze** (`analyze`) adds an **"Analyze" tab** to entities (such as nodes) and
provides a **plugin API** for putting information on that tab. It answers a
recurring question in Drupal: where does per-entity information go? An editor
looking at an article might want to know how many times it has been viewed, how
readable it is, whether its images have alt text, or when it was last
reviewed — and normally each of those arrives as a separate module adding its own
block, tab, or column somewhere different.

Analyze turns each of those into a **plugin on one shared tab**, so the editor
learns a single place to look. That is a small piece of architecture with a
disproportionate effect: information an editor has to go and hunt for is
information they tend not to have. The base module is the framework; the data
comes from plugins, several of which ship as submodules.

Two things are worth keeping in mind. The Analyze tab is a good place for
**information** and a poor place for **controls** — its value is that an editor
can look without changing anything, so plugins should show insights rather than
offer actions. And because a plugin may fetch data (for example analytics) when
the tab is viewed, that can mean an **external request on an admin page load**, so
well-behaved plugins handle caching and failures themselves rather than assuming
the data is free.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and pick the submodules you need.
2. [Configuration](configuration/index.md) — the settings form for the Analyze
   tab.

## Where it lives in the admin menu

Once enabled, an **Analyze** tab appears on entities that support it (view an
article and look at its tabs). The module's own settings form is at the Analyze
settings route (`analyze.analyze_settings`) in the admin configuration area — see
[Configuration](configuration/index.md).
