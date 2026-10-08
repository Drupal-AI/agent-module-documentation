# Allowed Languages — manual setup guide

**Allowed Languages** (`allowed_languages`) lets you limit which languages each
user is allowed to **manage content in**. On a multilingual site you can assign
one editor to English, another to German, another to French — and the module then
blocks each of them from editing, deleting, or translating content in any language
they haven't been given.

It works by adding an **Allowed languages** field to every user account. An
administrator ticks the languages a user may work in (or ticks "Allow all
languages"). From then on the module enforces those choices in several places at
once: it forbids editing and deleting content in other languages, restricts the
translation add/edit/delete operations to permitted languages, strips the
operation links for disallowed languages from the translations overview page, and
removes disallowed languages from the language selector when creating new content.
A **Views filter** is also provided so you can scope any content listing down to
the current user's allowed languages — handy for per‑editor dashboards.

Two permissions govern it. **Administer allowed languages** controls who can see
and set the per‑user field, and **Translate all languages** is a bypass that
exempts trusted leads and admins from every restriction. There is no permission
that "turns the restriction on" — restriction is simply the default for anyone
who does not hold the bypass, so a user with no languages assigned (and no bypass)
is effectively locked out of editing translatable content.

The module builds on Drupal core's **Content Translation** and **User** modules
and needs nothing else. It has **no global settings page** — configuration is a
matter of setting the two permissions and assigning languages on each user
profile.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — set the two permissions, assign
   allowed languages to each user, and use the Views filter.

## Where it lives in the admin menu

There is no dedicated settings page. You configure the module in two familiar
places:

- **People → Permissions** (`/admin/people/permissions`) — grant *Administer
  allowed languages* and *Translate all languages*.
- Each user's edit page (**People → *(user)* → Edit**) — tick that user's allowed
  languages.

## How to use it

Grant the permissions, then edit each editor's account and tick the languages they
are responsible for. See [Configuration](configuration/index.md) for the details.

## Good to know

Editing, deleting, and translation management are enforced on the server. On the
**create** form, disallowed languages are removed from the language selector.
