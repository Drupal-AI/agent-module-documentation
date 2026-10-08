# Submit and continue — manual setup guide

**Submit and continue** (`submit_and_continue`) adds a button to Drupal forms that
submits the form and then drops you straight back onto a fresh, empty copy of the
same form — so you can immediately start the next entry. It is built for
repetitive, bulk data entry, where round-tripping back to a form again and again is
the slow part.

The problem it solves is the friction of adding many similar things in a row.
Adding ten nodes of the same type, ten menu items, or a batch of example content
normally means submitting, navigating back to the add form, and starting over each
time. With this module you click *Submit and continue* instead of the normal save
button, and Drupal returns you to a clean form ready for the next record. Because
the button names and their target routes are stored as configuration in YAML, a
configuration override can adjust or extend the default options the module
provides.

It works on **any Drupal form**, which is what distinguishes it from similar
node-only modules (*Add another*, *Create and continue*). It has **no module
dependencies**, no PHP or library requirements, and it does not change how your
form is validated or who may submit it — the submission is still governed by the
form's normal access and validation. The module's only job is the post-submit
redirect back to a fresh form; it plays no access-control role.

This guide is written for a **human** setting the module up. If you are an AI coding
agent, read the terser sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## How to use it

Once enabled, the *Submit and continue* action becomes available on forms. Use it
in place of the usual save button when you are adding several records in a row:
submit, and you land back on an empty version of the same form to enter the next
one. The available button names and the routes they return to are defined in the
module's YAML configuration, so if you need to change the default label or target
you can do so with a configuration override rather than a code change.
