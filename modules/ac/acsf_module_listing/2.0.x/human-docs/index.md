# ACSF Modules Listing — manual setup guide

**ACSF Modules Listing** (`acsf_module_listing`) is a reporting tool for
operators of an **Acquia Cloud Site Factory** (ACSF) environment. A Site
Factory can host hundreds of sites from one code base, and it is easy to lose
track of which modules are actually enabled where. This module surfaces that
information — it lists the modules enabled across the sites in the factory, so
you can audit usage and check for consistency across the fleet.

It is purely an operations and governance aid. It adds no content, no blocks,
and no front-end features — it exists to answer the question "what is turned on
across our sites?" for the people running the factory. Access is restricted to
users who hold the **Administer ACSF environment entity**
(`administer acsf_environment_entity`) permission, so ordinary editors never see
it.

The module runs on Drupal 8, 9, 10, and 11, and has no third-party
requirements. Because it is meaningful only inside an Acquia Site Factory
environment, install it on the factory rather than on a standalone site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

The listing is an administrative report gated by the **Administer ACSF
environment entity** permission. Grant that permission to your factory operators
(under **People → Permissions**), then use the module's listing to review which
modules are enabled across the environment's sites. There is no settings form to
fill in — it works as a read-only report once the module is enabled and you are
running inside an ACSF environment.
