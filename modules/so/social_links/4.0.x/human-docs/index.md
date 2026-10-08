# Social Links — manual setup guide

**Social Links** (`social_links`) adds a *Social Links* pseudo-field to every
entity display, so any content you render — an article, a taxonomy term, a user,
a custom entity — can carry a row of share links. By default those are Twitter/X,
Facebook and email, and each one shares the current page's URL with the page
title pre-filled. It has no dependencies and runs on Drupal 9.3 and 10.

The important thing to know up front is that Social Links has **no admin
settings form**. It is configured entirely in code, through hooks. You turn the
share links on by enabling the *Social Links* component on an entity's view
display (the **Manage display** tab), and you add, remove or replace providers by
writing a small hook in a custom module. This makes it a good fit when you want
share configuration kept in code for reproducible deployments, and a poor fit if
you were hoping to click everything together in the UI.

Under the hood the module registers a component on each bundle's display and, when
the entity renders, builds the links from a provider registry: each provider is a
name mapped to a URL template, which is filled in with the URL-encoded current
page address and title. The output is themed as a simple list with a
`social-links` class and its own small front-end library. Other modules can add
providers such as LinkedIn or WhatsApp, open shares in a popup window, or give a
provider an inline-SVG icon, all through the module's alter hook (documented in
`social_links.api.php`). Nothing untrusted flows into the markup beyond the
url-encoded request URI and page title, and there are no routes, permissions or
config entities to worry about.

This guide is written for a **human** enabling and theming the share links
through the admin UI and a little custom code. If you want terse, token-cheap
references for an AI coding agent, read the sibling [`agent/`](../agent/start.md)
docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## How to use it

Because there is no settings form, you switch the links on per display:

1. Go to **Structure → Content types → [your type] → Manage display** (or the
   Manage display tab of any other entity type and bundle).
2. Choose the view mode you want (for example *Full content* or *Teaser*).
3. Enable the **Social Links** component and drag it to the position you want.
4. Save. Rendered entities in that view mode now show the share links.

To go beyond the three default providers — adding LinkedIn, WhatsApp or Telegram,
replacing the whole set, opening shares in a popup window, or attaching an SVG
sprite icon per provider — implement `hook_social_links_alter()` in a custom
module. The signatures and examples are in the module's `social_links.api.php`.
Provider labels are translatable through Drupal's normal translation system.
