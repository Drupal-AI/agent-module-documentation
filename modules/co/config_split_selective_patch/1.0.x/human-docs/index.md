# Config Split Selective Patch — manual setup guide

**Config Split Selective Patch** (`config_split_selective_patch`) is an add-on for
the popular [Configuration Split](https://www.drupal.org/project/config_split)
module. It fills a specific gap for teams who run Config Split 2.x but keep the
**"Do not patch dependents"** option turned on.

Some background: Config Split 2.x can export the differences between your active and
sync configuration as compact, schema-aware **patch files** (`config_split.patch.*`)
— that is the default in 2.x. Many teams, however, enabled *Do not patch dependents*
to avoid a large, disruptive switch, keeping the familiar 1.x-style behaviour where
dependents are fully split and Partial Split items are stored as full config copies
when their values differ. The trouble is that in that mode there is no way to say
"but export *these* specific items as patches." That is exactly the gap this module
fills.

It adds a third field to each split — **Partial Split (Patch)** — whose selected
configuration is exported using Config Split's patch strategy *even when* "Do not
patch dependents" is checked. Everything else about the split stays unchanged. This
lets a team adopt 2.x patches gradually, on one or two low-risk config objects they
know and trust, while leaving the rest of the split alone — a confidence-building
step before any wider rollout, or a clean way to keep an environment-specific
override (a single view, a `system.site` tweak) in sync while exporting only its
diff. The field supports wildcards just like Config Split's own configuration, and
if the same item appears on both *Partial Split* and *Partial Split (Patch)*, the
patch strategy wins.

This is a developer and site-builder tool that extends Config Split; it depends on
`config_split` and requires Drupal 10.3+ or 11. Import behaviour is unchanged —
Config Split already knows how to merge `config_split.patch.*` entries on import.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

The module has **no settings form of its own** — it simply adds a field to Config
Split's existing split edit form, so there is no separate configuration page.

## Where it lives in the admin menu

You use the module from Config Split's own screen at **Configuration → Development →
Configuration Split**
(`/admin/config/development/configuration/config-split`).

## How to use it

1. Make sure Configuration Split is enabled and configured, then enable this module
   (see [Installation](installation/index.md)).
2. Go to **Configuration → Development → Configuration Split** and edit an existing
   split (or create one).
3. Under **Advanced**, enable **Do not patch dependents**. This is what reveals the
   new **Partial Split (Patch)** fieldset.
4. In **Partial Split (Patch)**, select the configuration you want exported as patch
   files, or add wildcard lines in the **Additional configuration** textarea.
5. Save the split and export configuration as you normally would (`drush cex` or your
   existing workflow). The chosen items are written as `config_split.patch.*` files in
   your split storage; everything else in the split keeps its existing behaviour.

Behaviour at a glance:

- *Do not patch dependents* **off** → the Partial Split (Patch) field is hidden and
  standard Config Split 2.x behaviour applies.
- *Do not patch dependents* **on** + *Partial Split* → conditional full copy when
  values differ (unchanged from before).
- *Do not patch dependents* **on** + *Partial Split (Patch)* → patch files for the
  selected config only.
