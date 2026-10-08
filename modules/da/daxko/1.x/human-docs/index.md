# Daxko — manual setup guide

**Daxko** (`daxko`) provides a basic integration between Drupal and
[Daxko](https://www.daxko.com/), the membership-management and payment platform
used by YMCAs, gyms, and similar organisations. It was created for the **Open Y**
distribution and connects to Daxko's CRM API to bring membership data into
Drupal.

In practice, the module talks to Daxko's API — which handles member records and
payments — and caches membership-type data locally so a Drupal site can use it. It
provides a `daxko.data_wrapper` service with helper methods to populate and clear
that cached membership data (run via Drush, shown in "How to use it" below). It
depends on two Open Y modules, `openy_socrates` and `openy_mappings`, so it is
really intended for an Open Y (or Open Y-style) site rather than a stand-alone
Drupal install.

Because it connects to a live membership/payment platform, treat it as sensitive
infrastructure. The **API credentials are secrets** — keep them out of plain
configuration (see the Installation page for how to store them safely) — and the
data exchanged (member records, potentially payment-related information) is
personal and financial, so restrict who can administer the integration and confirm
exactly what data flows between the two systems before you go live.

> **Note on maturity:** this is described as a *basic* / initial integration and is
> minimally maintained. Test it thoroughly against your own Daxko account and data
> before relying on it in production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer, store
   the Daxko API credentials securely, and enable it.

There is **no dedicated settings form** documented for this module. It exposes its
behaviour through the `daxko.data_wrapper` service and Drush, rather than an admin
configuration page.

## How to use it

Once installed, configured with credentials, and enabled, you drive the membership
cache from Drush.

Cache (populate) the Daxko membership types:

```bash
drush ev '\Drupal::service("daxko.data_wrapper")->populateDaxkoMembershipTypes();'
```

Remove all cached membership-type mappings:

```bash
drush ev '\Drupal::service("daxko.data_wrapper")->deleteMembershipTypeMappings();'
```

(Prefix with `ddev` from your host — `ddev drush ev '…'` — or run inside
`ddev ssh` without the prefix.)
