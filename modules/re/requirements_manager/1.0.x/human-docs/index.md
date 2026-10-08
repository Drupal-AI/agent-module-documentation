# Requirements Manager — manual setup guide

**Requirements Manager** (`requirements_manager`) gives you an admin UI to curate
Drupal's **Status Report** (`/admin/reports/status`). That report is the page full
of green, yellow, and red rows telling you about cron, updates, PHP settings, module
health, and so on. Sometimes a row is noisy, irrelevant to your particular
environment, or handled elsewhere (by CI, say) — and you'd rather it stop drawing
attention. This module lets you **hide** individual requirement rows or **change
their severity**, one by one, from a settings form, without patching core or the
module that raised them.

For each requirement it discovers on your site, you pick an action: **Show** (leave
it exactly as-is — the default), **Hide** (drop it from the report), or **Change
severity** (remap it to Info, OK, Warning, or Error). You can also record a free-text
**reason** for each change, which is helpful for the next administrator — and for
severity changes, that reason is shown right on the report next to an audit note
explaining that Requirements Manager altered it.

This is handy for keeping a status report meaningfully green on a purpose-built
environment, downgrading a warning you've knowingly accepted so it stops causing
alert fatigue, escalating a quiet requirement so your team actually notices it, or
just tidying the report before a screenshot or stakeholder demo. Because the
overrides are stored as normal Drupal configuration, you can export and import them
to roll the same curation across environments.

One important caveat: these overrides only change how the status report is
**displayed** — they do not fix or change the underlying condition. Hiding a warning
doesn't make the problem go away; it just stops showing it. Use it deliberately.

The module targets Drupal 11.2+ and PHP 8.3, depends only on core's System module,
and adds no permission of its own — the settings form is gated by core's *Administer
site configuration*.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the settings form field by field:
   hiding rows and changing severities.

## Where it lives in the admin menu

The settings form sits at **Configuration → System → Requirements Manager**
(`/admin/config/system/requirements-manager`). It uses the core **Administer site
configuration** permission, so any administrator who can reach core's other system
settings can use it.

## How to use it

Open the settings form, find the requirement row you want to adjust, choose **Hide**
or **Change severity** (and optionally jot a reason), and save. Reload
`/admin/reports/status` to see the effect. To reverse a change later, set the row
back to **Show** — even rows you previously hid stay listed on the form so you can
un-hide them. See [Configuration](configuration/index.md) for the full walkthrough.
