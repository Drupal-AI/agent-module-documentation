# Openfed Social Links — manual setup guide

**Openfed Social Links** (`openfed_social`) adds social‑share links to your pages
— buttons that let visitors share the current page on social networks. It's part
of the Openfed distribution, but it works as a standalone module on any Drupal
10.3–11 site. A nice property, especially for privacy‑conscious sites: it
**doesn't depend on any external service and doesn't save any information about
the user**. The share links are plain links to the networks, so there's no
third‑party tracking script embedded in your pages.

You choose which networks to offer on a small settings form, then place the
module's block wherever you want the share links to appear. The output is
themeable — there's a Twig template you can override to match your design.

Because the links simply point to social networks (which load their own content
when a visitor clicks), the module has no access‑control role and stores nothing
about your visitors. It's purely a user‑engagement helper.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, choose your networks, and place the block.

## Where it lives in the admin menu

The settings form is at **Configuration → Web services → Openfed Social**
(`/admin/config/services/ofed_social`), where you pick which networks to show.
Unless you're migrating from the old ShareThis module, use the **default** theme
option.

## How to use it

Setup is three quick steps:

1. Enable the module.
2. Go to `/admin/config/services/ofed_social` and select the social networks you
   want to offer. Leave the theme on **default** unless you're migrating from
   ShareThis.
3. Place the **Openfed Social Block** into a region at **Structure → Block
   layout** so the share links appear where you want them.

To customise the markup, override the `ofed-social-links-default.html.twig`
template in your theme.
