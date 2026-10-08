# Sector External Links — manual setup guide

**Sector External Links** (`sector_external_links`) is a small companion module
for the **Sector** distribution that tailors the popular **External Links**
(`extlink`) module to Sector's conventions. In practice it patches extlink so that
the little "external link" icon is rendered with **Material Symbols**-style span
elements instead of the Font Awesome icons extlink uses by default, keeping the
external-link marking consistent with the rest of a Sector site's iconography.

The problem it solves is purely presentational consistency: if your site (or the
Sector distribution) standardizes on Material Symbols, this module makes extlink's
external-link indicators match, so you do not get a stray Font Awesome dependency
just for link icons. It is a content-display / theming tweak — it changes how
external links are marked and has no content or access-control role.

The module works as soon as it is enabled alongside extlink — there is nothing to
configure here (the external-link behavior itself, such as which links count as
external, is still configured in the **External Links** module's own settings). It
depends on the External Links (`extlink`) module and supports Drupal 10.3 and 11.
Note it is described as minimally maintained and is really meant for Sector
distribution sites.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module alongside External Links.

## How to use it

There is nothing to switch on beyond enabling the module. With both extlink and
Sector External Links enabled, external links across your site are marked using
Material Symbols icons instead of Font Awesome. To adjust *which* links are treated
as external, or other extlink behavior, use the **External Links** module's own
configuration.
