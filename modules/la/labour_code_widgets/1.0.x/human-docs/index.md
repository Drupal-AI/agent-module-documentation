# Labour code widgets — manual setup guide

**Labour code widgets** (`labour_code_widgets`) embeds the official French
government "code du travail" (labour code) widgets — the ones published at
`code.travail.gouv.fr` — directly into your Drupal pages. It does this as a
**field**: you add a "Labour code widgets field" to a content type or other
fieldable entity, choose which government widget it should display, and the chosen
widget renders on the entity's page.

The available widgets cover the ministry's "Code du travail numérique" tools,
including the labour‑code search engine, notice‑of‑dismissal and
departure/retirement calculators, the "understand your dismissal procedure"
helper, severance and precariousness allowance calculators, the collective‑
agreement finder, and document templates. An administrator can enable or disable
individual widgets site‑wide so editors only pick from the ones you want to offer.

The widgets are powered by an external script (`https://code.travail.gouv.fr/widget.js`)
that runs in the **visitor's browser** — the module itself makes no server‑side
calls to the government service. That means one thing to plan for: any page that
displays the field will load a script from an external domain, which is a privacy
and Content‑Security‑Policy consideration. If you enforce a CSP, add that domain to
your `script-src`.

A word of caution on project status: this module is marked **Unsupported /
Obsolete** on drupal.org. It still works, but weigh that before adopting it on a
new site. It depends on core's **Field** module and requires PHP 7.4 or newer.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — enable or disable individual widgets,
   add the field to a content type, and handle the external script in your CSP.

## Where it lives in the admin menu

The widget on/off form sits at **Structure → Labour code widgets → Status**
(`/admin/structure/labour-code-widgets/status`), gated by the **administer
labour_code_widgets** permission. You add and display the field itself from your
content type's **Manage fields** and **Manage display** screens.
