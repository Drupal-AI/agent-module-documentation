# Autocomplete widget with mixed matching — manual setup guide

**Autocomplete widget with mixed matching** (`autocomplete_mixed_matching`) is an
entity‑reference autocomplete that ranks results the way people actually expect.
Drupal core lets a reference field use only one matching rule at a time:
**Starts with**, which finds "Smith" when you type "Smi" but misses it when you
type "mith"; or **Contains**, which finds it either way but buries the exact match
among everything else that happens to contain those letters. This widget combines
both — prefix matches are listed first, and substring matches follow underneath —
so typing "smith" offers *Smith* before *Blacksmith* instead of one or the other.

It is a pure field widget: there is no settings page and no admin menu item. You
select it per field on a bundle's **Manage form display** screen, on any
entity‑reference field.

Two things are worth knowing before you rely on it. First, the **Contains** half of
the match cannot use a normal database index (a leading wildcard forces a scan), so
on a reference target with a very large number of rows the substring search is the
expensive part — measure it against production‑sized data, not a handful of
development records. Second, like all Drupal autocomplete, suggestions respect the
selection handler's access rules, which is exactly what you want: results are
limited to what the current user is allowed to reference, so the widget does not
become a way to discover entity labels a user shouldn't see.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [How to use it](#how-to-use-it) — apply the widget to a reference field.

## Where it lives in the admin menu

The module adds no admin menu item and no global settings page. You select the
widget per field, at **Structure → (your entity type) → Manage form display**.

## How to use it

1. Go to the **Manage form display** screen for the bundle whose reference field
   you want to improve.
2. In the **Widget** column for an entity‑reference field, choose the mixed‑matching
   autocomplete widget provided by this module.
3. Save. On the entity's edit form, typing into that field now lists prefix matches
   first and substring matches below them.
