# Simple Add More — manual setup guide

**Simple Add More** (`sam`) tidies up the editing form for multi‑value fields that
have a fixed maximum number of values. By default, a field that allows (say) five
values renders five empty rows up front, which clutters the form. Simple Add More
hides the surplus empty rows and shows just **one** empty element plus an **"Add
another item"** button — each click reveals one more empty row on demand, with help
text telling the editor how many more items can still be added.

It is a front‑end convenience layer. The behaviour is applied with client‑side
JavaScript, so it changes only how the form *looks* — your data and validation are
untouched. It automatically leaves alone the fields it shouldn't touch: it only
acts on fields whose cardinality is greater than one (single‑value and
unlimited‑value fields are ignored), and only on a curated list of common widget
types (text, textarea, email, number, telephone, link, path, uri, entity‑reference
autocomplete, Linkit, and so on).

Editors and site builders keep control. You can opt a specific widget out with a
per‑widget **"Skip simplification"** checkbox on the *Manage form display* screen,
and developers can extend the list of supported widget types with a hook. The
button label, the "Remove" button label, and the singular/plural help text are all
editable on a small settings form.

Simple Add More has no PHP dependencies, defines no services or plugins, and ships
no sub‑modules — it is a lightweight editor‑experience improvement.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — customise the button and help‑text
   labels, and opt individual widgets out.

## Where it lives in the admin menu

- The settings form is at **Configuration → Content authoring → Simple Add More
  Settings** (`/admin/config/content/simple-add-more-settings`).
- The behaviour itself needs no configuration to work — it applies automatically on
  any content form with a supported, fixed‑cardinality field once the module is
  enabled.
