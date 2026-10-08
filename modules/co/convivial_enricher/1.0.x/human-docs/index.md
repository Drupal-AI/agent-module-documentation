# Convivial Enricher — manual setup guide

**Convivial Enricher** (`convivial_enricher`) enriches a visitor's or user's
profile with data pulled from external services. It is part of the Convivial
toolkit built by Morpht, and its job is *progressive profiling*: when a visitor
arrives carrying an identifier (for example a unique code in an email campaign
link), the module reaches back out to a configured backend data source, retrieves
more information about that person, and stores it — typically in a temporary
cookie — so other profile tools (such as the Convivial profiler/basil tooling)
can read it and personalize the experience.

Out of the box the module ships a *dummy* data source plugin for testing. To pull
real data you enable and configure a datasource — the module's own documentation
describes a bundled **Enricher ActiveCampaign** submodule that lets you configure
enrichment from an ActiveCampaign account, and you can write your own datasource
plugin as well. So the module does nothing useful on enable alone: you must add
and configure at least one enricher. It depends on the **Convivial Core**
(`convivial_core`) module, which Drupal will pull in for you.

Because this module **fetches personal data from a third-party service (egress)
and augments profiles with third-party PII**, treat it as a privacy-sensitive
integration. Vet the data sources you connect, disclose the enrichment in your
privacy policy, obtain any consent your jurisdiction requires, and store the
provider's API credentials as secrets (never in exported configuration). A single
powerful permission — **Administer enrichers** — controls the whole feature, so
grant it only to trusted users.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module and Convivial Core, and enable a datasource submodule.

There is no single "settings" form for this module, so there is no separate
configuration page in this guide — you manage enrichers from a list page in the
admin UI, described under "How to use it" below.

## Where it lives in the admin menu

Once enabled, enrichers are managed from the **Web services → Enrichers**
configuration list page. From there a user with the **Administer enrichers**
permission can add, configure, enable, disable, and delete individual enrichers.

## How to use it

1. Grant the **Administer enrichers** permission (Administration → People →
   Permissions) to the trusted role that will manage enrichment. The module's
   documentation flags this as its most powerful permission.
2. Enable a datasource — the bundled **Enricher ActiveCampaign** submodule, or a
   custom datasource plugin of your own — and enable the base **Convivial Core**
   module if it is not already on.
3. Go to **Web services → Enrichers**, add an enricher, and point it at your data
   source with the provider credentials it needs.
4. Test with the dummy datasource first before wiring in a real provider.

> **Troubleshooting.** If enriched data is not coming back, check the recent log
> messages for exception entries. If you hit a redirect loop, it is a known
> interaction with the Redirect module — see that project's issue queue.
