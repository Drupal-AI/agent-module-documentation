# Noopener Filter — manual setup guide

**Noopener Filter** (`noopener_filter`) adds `rel="noopener"` to links that open
in a new tab (`target="_blank"`), closing a small but real security hole called
*reverse tabnabbing* — where a page you link to can reach back through
`window.opener` and, for example, redirect your original tab to a phishing page.

The module ships two independent mechanisms, and you can turn on either or both.
The first is a **text-format filter** ("Add noopener to all links") that you
enable per text format. When editors write body content through CKEditor, the
filter scans the rendered HTML, finds every `<a>` whose `target` is exactly
`_blank`, and adds `noopener` to its `rel` attribute — preserving any existing
`rel` value such as `nofollow`. The second is a global **link-alter option**
that does the same for links Drupal itself generates (menu links, link-generator
output, and so on) that carry `target="_blank"`. That one is off by default and
controlled by a single checkbox on a tiny settings form.

Noopener Filter adds only `noopener` (never `noreferrer`) and only ever touches
links whose target is `_blank`, so same-tab links are left completely alone. It
has no field type, no plugin type, and no dependencies beyond Drupal core; its
only stored state is that one boolean setting.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — enable the filter on your text
   formats and turn on the optional global link-alter option.

## Where it lives in the admin menu

There are two touch points. The text-format filter is enabled from
**Configuration → Content authoring → Text formats and editors**
(`/admin/config/content/formats`) by editing a format. The module's own small
settings form — the global link-alter toggle — lives under **Configuration →
Content** at `/admin/config/noopener-filter/settings`.
