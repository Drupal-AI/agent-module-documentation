# Node Edit Protection — manual setup guide

**Node Edit Protection** (`node_edit_protection`) warns editors before they navigate
away from a node add or edit form that has unsaved changes, so a stray click, a menu
link, or the browser's back button doesn't silently throw away in-progress content.
When the form has been touched but not saved, the browser shows its native "Leave
site?" confirmation — the message the module supplies is *"You will lose all unsaved
work."* — and only fires when there really are unsaved changes.

It's a tiny, **zero-configuration** JavaScript enhancement. Enabling the module is the
entire setup: it automatically attaches its guard to Drupal's node add and edit forms.
The guard marks a form "dirty" as soon as you change any input inside it, lets genuine
save/submit buttons through without a warning, and even detects unsaved rich-text
changes in CKEditor — not just plain form fields. In-page anchor links (`href="#"`)
don't trip it, so normal interactions on the form aren't interrupted.

There is **no settings form, config, permission, Drush command, or plugin**, and the
module has no dependencies beyond core's jQuery and Drupal JavaScript. If you want to
protect a form that isn't a node form, you can attach the same behaviour yourself —
that's described in the agent docs below.

This guide is written for a **human** installing the module. If you want terse,
token-cheap references for an AI coding agent — exactly which forms it hooks, the
dirty-tracking logic, and how to extend it to other forms — read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module. That's the whole setup.

## Where it lives in the admin menu

Nowhere — the module has no admin pages, no settings, and no permissions. Once enabled,
the unsaved-changes guard is simply active on all node add and edit forms.

## How to use it

There is nothing to configure. After you install and enable the module:

1. **Edit any node.** Open a node add or edit form (for example
   **Content → Add content → (type)**, or edit an existing node) and change something —
   type in the title, edit the body, and so on.
2. **Try to leave without saving.** Click a link to another page, hit the back button,
   or close the tab. The browser shows its native "Leave site?" confirmation so you can
   stay and save.
3. **Save normally.** Clicking a real **Save** button submits the form without any
   warning — the guard recognises genuine submits and gets out of the way.

The protection covers plain fields and CKEditor rich-text content alike, and applies
automatically across every content type. To extend the same guard to a non-node form,
see the [`agent/`](../agent/start.md) docs.
