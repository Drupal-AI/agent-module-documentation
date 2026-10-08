# Ajax Dependency — manual setup guide

**Ajax Dependency** (`ajax_dependency`) is a developer helper service that makes
it easy to build AJAX dependencies between form elements — so one element can
update or refresh another over AJAX without writing repetitive boilerplate each
time.

It is a Form API utility, not an end-user feature: there is no settings page and
nothing changes on your site just by turning it on. You use its service from
your own form code when you want, for example, one select list to refresh the
options or visibility of another. Refreshed content still respects its own
access rules — the module provides plumbing only and has no access-control role.

The project ships an example submodule, **`ajax_dependency_example`**, which
demonstrates the pattern in a working form. Enable it if you want a concrete
reference to copy from, then disable it once you have the hang of it.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it, and optionally enable the example submodule.

## How to use it

After enabling, call the helper service from your own form definitions to wire
up AJAX dependencies between elements, instead of hand-rolling the AJAX
callbacks and `#states`/`#ajax` boilerplate yourself. The
`ajax_dependency_example` submodule is the best starting point — read its form
code to see how the service is invoked. See the [`agent/`](../agent/start.md)
docs for the developer-facing details.
