# Role description — manual setup guide

**Role description** (`role_description`) lets each user role carry an explanatory
**description**, and shows that description beside the role checkboxes on the account
form — so whoever assigns roles knows what each one actually means.

Out of the box a Drupal role has only a machine name and a label, which is fine with
three roles and painful with fifteen. "Content approver", "Editor", "Publisher", and
"Reviewer" are hard to tell apart from their labels alone, and the person assigning
them — often an administrator who did not design the permission scheme — has no easy
way to know which is which. This module attaches a description to each role and
surfaces it exactly where the decision is made: on the user account form, next to the
role checkboxes.

It works with core's native role widget and also with the Role Delegation widget.
Because roles are configuration, the descriptions are configuration too, so they
export with your config and — thanks to the `config_translation` dependency — they
are translatable for multilingual sites (with a current caveat, noted below). The
module supports Drupal 10 and 11.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its `config_translation` dependency).

Configuration is a single form, described below.

## Where it lives in the admin menu

Once enabled, manage the descriptions at **People → Role description**
(`/admin/people/role-description`, the `role_description.settings` route). Access is
gated by core's **Administer permissions** — the same permission that already governs
roles themselves, so the module does not add a permission of its own.

## How to configure it

1. Open **People → Role description** (`/admin/people/role-description`).
2. Enter a plain-language description for each role — what it is for, who should have
   it, what it lets someone do.
3. Save.

The descriptions then appear beside the role checkboxes on the user account form,
helping whoever grants roles pick the right one and reducing mis-assignment.

## Translating descriptions

The descriptions export with your configuration (`drush cex`) and are translatable.
There is one current limitation: because Drupal core does not yet support translating
"sequence" config values through the UI, you cannot translate the descriptions from
the interface. Until core adds that, translate them by placing the relevant keys in a
`language/` config override file (for example a
`language/es/role_description.settings.yml` that overrides only the keys you want in
Spanish).

## Good to know

The Drupal core issue to add a native description field to the role entity is
tracked upstream; this module implements the same idea in a way designed to avoid
conflicts, and if core adopts it the module will eventually be deprecated.
