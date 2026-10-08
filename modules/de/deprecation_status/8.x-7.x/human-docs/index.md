# Deprecation Status — manual setup guide

**Deprecation Status** (`deprecation_status`) summarises the results of
drupal.org's Project Analysis pipelines — the regular reports that check contributed
projects for deprecated API usage and major-version compatibility — and presents
them in an easy-to-digest, interactive form. It's a tool for making sense of the
readiness of the wider Drupal ecosystem for an upcoming major core version.

An important caveat, straight from the maintainers: **this project was not designed
to install on your own Drupal site.** It powers the live ecosystem dashboard at
`https://dev.acquia.com/drupal11/deprecation_status/projects`, which is where you
should go for up-to-date data. If what you actually want is to check *your own
site's* upgrade readiness, use the
[Upgrade Status](https://www.drupal.org/project/upgrade_status) module instead.

The module supports Drupal 9.3, 10 and 11 and depends only on core's **File**
module. Treat it as a developer/analysis tool rather than a site feature.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it (only if you specifically need to run it yourself).

There is no configuration page, and for most people there is nothing to install at
all — the live hosted dashboard is the intended way to consume this data.

## Where it lives in the admin menu

The module ships no settings form (`configure` is null). Its purpose is to render
the ecosystem deprecation report; it adds no configurable admin page.
