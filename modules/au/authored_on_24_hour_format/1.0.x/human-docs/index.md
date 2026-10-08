# Authored On 24-hour format — manual setup guide

**Authored On 24-hour format** (`authored_on_24_hour_format`) forces the node
add/edit form's **Authored on** date/time widget to use a 24-hour time format.
It is a small editorial-UX tweak for teams and locales that expect 24-hour time
rather than 12-hour AM/PM.

The module attaches a small JavaScript library to the node form via a form-alter
hook, and that script sets the *Authored on* time input to display in 24-hour
format. It applies to every content type automatically, because it hooks the base
node form rather than any specific type.

The change is purely client-side and presentational: it affects how the time is
entered in the widget, not the value that is stored, and it does not touch
validation. That makes it safe to enable or disable at any time with no data
migration. The module adds no routes, permissions, services, or settings — there
is nothing to configure. It supports Drupal 8, 9, and 10.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

There is nothing to set up beyond enabling it. After enabling, **clear caches**
so the JavaScript library attaches, then open any node add or edit form — the
*Authored on* time field will use a 24-hour picker. To combine it with
consistent display formatting elsewhere, adjust your site's regional/date
settings separately. To turn the behaviour off, simply uninstall the module; no
stored data is affected.
