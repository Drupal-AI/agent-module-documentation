# Create and Continue — manual setup guide

**Create and Continue** (`createandcontinue`) adds a save button to the node form that
creates the node and then hands you a **fresh, empty form of the same type** — the
familiar "save and add another" behaviour that data-entry applications have and
Drupal's node form does not.

Bulk content entry is a real editorial task: adding forty staff profiles, a season of
events, a catalogue of products, a set of records typed in by hand. The default loop
for each one is fill the form, save, land on the created node, navigate back to the add
form, wait for it to load, fill it again. The navigation and the page load are pure
overhead, repeated once per record, and losing the form under you is worse than the
seconds it costs — people entering data work fastest when the interface stays put. This
module replaces that loop with a single button.

It is deliberately minimal: **there is no settings form** — you simply enable the
module, and the button then appears on **every** node form. It has no dependencies and
targets Drupal 10 and 11.

Two things worth keeping in mind. Because the created node vanishes from view the
moment you save and move to a new form, the **confirmation message** is your only
feedback that the save happened — glance at it each time so a mistake isn't repeated
forty times before you notice. And if bulk entry is really the goal and the data
already exists somewhere (a spreadsheet, an export), consider whether an **importer /
migration** would serve you better than forty forms.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the module.

There is **no configuration page** for this module — you can only turn it on or off,
and when on the button appears on every node form. Its behaviour is described below.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open any node-add form. Alongside the usual **Save** button you'll see the module's
   save-and-create-another button.
3. Click it to save the current node and immediately get a fresh empty form of the same
   content type — ready for the next record. Repeat as many times as you need.

Check the confirmation message after each save to be sure the node was created as
expected.
