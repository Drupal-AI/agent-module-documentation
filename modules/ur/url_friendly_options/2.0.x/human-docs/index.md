# URL-friendly Options — manual setup guide

**URL-friendly Options** (`url_friendly_options`) makes sure the **keys** of your
option-list fields stay safe to drop straight into a URL. Option-list fields (the
"List (text)", "List (integer)", and "List (float)" field types) store a set of
allowed values, each with a key and a human label. This module enforces that every
key contains only letters, digits, and hyphens — so a key like `breaking-news`
works cleanly as a URL segment or a Views contextual-filter argument, and something
like `second value!` is never allowed to slip in.

Enabling the module *is* the configuration — there is nothing to set up. It quietly
changes the field settings form in two ways: it **rejects saving** a field whose
allowed-values keys are not URL-friendly (with a clear error telling you which keys
are the problem), and it makes the auto-suggested machine-name key use **hyphens
instead of underscores** as you type a label (so "Breaking News" suggests
`breaking-news`). It also adds a check to the site's **Status report** that flags
any existing list fields whose keys do not comply, so you can audit a legacy site.

Importantly, it never rewrites values you already have. Fields created before you
enabled the module keep their existing keys; you simply cannot add or edit their
allowed values until the keys comply. If one specific field genuinely needs to keep
non-compliant keys, a developer hook lets another module exempt it. The module
depends only on core's **Options** module and has no settings page, permissions, or
Drush commands.

This guide is written for a **human** setting the module up. If you want terse,
token-cheap references for an AI coding agent — including the exact regex and the
bypass hook — read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

There is no configuration. Once the module is enabled it works everywhere on its
own:

- **Adding or editing an option-list field** — on the field's settings form, the
  allowed-values table now only accepts keys made of letters, digits, and hyphens.
  If a key does not comply, the form shows an error and will not save until you fix
  it. As you type a label, the suggested key uses hyphens.
- **Auditing existing fields** — visit **Reports → Status report**
  (`/admin/reports/status`). URL-friendly Options adds an entry there: green ("All
  option list keys are URL-friendly") when everything is clean, or an error listing
  the fields whose keys still need fixing.
- **Exempting one field** — if a particular field must keep non-URL-friendly keys
  (for example a legacy field imported with underscores), a developer can implement
  `hook_url_friendly_options_bypass_field_validation()` in a custom module to skip
  both the form check and the status-report check for that field. See the
  [`agent/`](../agent/start.md) docs for the hook signature.

Because it only blocks new or edited non-compliant keys and never touches stored
values, it is safe to enable on an existing site — worst case, the Status report
tells you which fields to tidy up when you next edit them.
