# Sample Drupal Module — manual setup guide

**Sample Drupal Module** (`sample_drupal_module`) is a bare module skeleton: an
`.info.yml` file plus an otherwise empty `.module` file. It is provided as
starter boilerplate — the smallest thing that still counts as an installable
Drupal module.

It does nothing on its own. There are no routes, permissions, services,
configuration, schema, plugins or hooks, so enabling it has no functional effect
on your site. It exists to be copied and renamed as the starting point for your
own custom module, or to serve as a reference for the minimal files a Drupal
module needs. There are no dependencies and no submodules.

Because it ships no code paths, there is nothing to configure and nothing to
operate. The only real tasks are enabling and uninstalling it. It has no security
surface at all — no endpoints, no data handling, no external calls and no
secrets. Treat it as a template rather than a feature.

This guide is written for a **human**. If you want a terse, token‑cheap reference
for an AI coding agent, read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable it
   (there is nothing to configure).

## How to use it

Copy the module's directory, rename the folder, the `.info.yml` file and the
machine name inside it, and you have a clean scaffold to start adding your own
routes, services or hooks. Enabling the module as‑is simply confirms that module
discovery and installation work.
