# Accessibility Statement — manual setup guide

**Accessibility Statement** (`accessibility_statement`) publishes a dedicated,
legally structured accessibility statement page for your site. Instead of
hand-writing a free-text node that drifts out of date and skips required
details, you fill in a structured admin form and the module renders a consistent,
semantic statement page from that configuration.

It exists to help you meet specific legal duties. EU Directive 2016/2102 requires
public-sector sites to publish a structured accessibility statement, and since
June 2025 the European Accessibility Act (2019/882, implemented in Germany as the
BFSG) extends similar duties to private products and services. The form adapts to
which of these applies: choose a **public-sector body** statement and it adds an
enforcement / arbitration body section; choose a **product or service** statement
and it adds a market-surveillance authority section.

The public page defaults to `/accessibility-statement` and is deliberately
reachable by everyone — an accessibility statement has to be. You can change that
path (for example to a localized `/barrierefreiheitserklaerung`). The page renders
only from your saved configuration: no visitor input is stored or shown back, dates
appear as machine-readable `<time>` values, and the contact phone becomes a
sanitized `tel:` link. A footer menu link to the statement is added when you
install the module, and the page template is themeable.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field,
   where you build the statement itself.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Accessibility Statement**
(`/admin/config/system/accessibility-statement`) and is gated by the
**Administer accessibility statement** permission. The public statement is
published at `/accessibility-statement` (or whatever path you set) and is linked
from the site footer.
