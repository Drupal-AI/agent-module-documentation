# Domain Config Pages — manual setup guide

**Domain Config Pages** (`domain_config_pages`) makes
[Config Pages](https://www.drupal.org/project/config_pages) domain-aware on a
[Domain](https://www.drupal.org/project/domain) multi-site. Config Pages gives
site builders a fielded settings form — a contact address, a footer notice, a set
of social links, an announcement banner — without writing a settings-form class,
and stores the values as entities that editors can change. This module adds the
missing piece for Domain sites: it supplies a **domain context plugin** so a
single config page can hold *different values per domain*.

That matters because the whole point of the Domain module is one installation
serving several sites, and a footer address that is identical across all of them
defeats the arrangement. With this module enabled, you turn on the domain context
for a config page type and each domain gets its own set of values.

Two things are worth settling early, both carried over from the module's own
guidance:

- **A per-domain value is a per-domain cache context.** Anything that renders these
  values must vary its cache by domain, or one site can be served another's footer.
  Because Domain sites share one installation, getting this wrong is a *cross-site
  content leak*, not just a cosmetic glitch — so it is worth verifying rather than
  assuming.
- **The fallback rule is the real design decision.** Decide what a domain with no
  value of its own should get — the default domain's value, an empty field, or the
  field's own default. That choice determines whether adding a new domain is safe
  by default or silently publishes another domain's content. Settle it *before* you
  create your second domain, while it is still cheap to change.

There is nothing to configure in the module itself; the setup is done on your
Config Pages types, described below.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer (alongside
   Config Pages and Domain) and enable it.

There is **no settings form of its own**. You enable the domain context on each
Config Pages type through the Config Pages admin UI, described in "How to use it"
below.

## Where it lives in the admin menu

Domain Config Pages does not add an admin page. You use it from the Config Pages
type settings at **Structure → Config pages types → *(your type)* → Manage**
(`/admin/structure/config_pages/types/manage`), where enabling this module adds
the option to make that type domain-aware.

## How to use it

1. Make sure both **Config Pages** and the **Domain** module are set up, with your
   domains created.
2. Go to **Structure → Config pages types**, edit (or add) a config page type, and
   **enable the domain context** for it.
3. Optionally, provide a **default domain context** so there is a defined fallback
   for domains without their own value — decide this deliberately (see the
   fallback note above).
4. Edit the config page and enter per-domain values. Each domain now sees its own
   values where that config page is rendered.
5. Confirm that anything displaying these values varies its cache by domain.
