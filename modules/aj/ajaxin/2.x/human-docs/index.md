# Ajaxin — manual setup guide

**Ajaxin** (`ajaxin`) provides a simple, modern loading animation that appears
while an AJAX request is in progress. Whenever the site is busy fetching
something over AJAX, visitors see a clean spinner so they know something is
happening rather than staring at an unresponsive page.

It is a small front-end UX enhancement with no security surface and nothing you
must configure to get the basic effect. The main thing to check is that the
loader's look fits your theme.

Note that Ajaxin depends on the **Blazy** module (version 3.x or newer), so
Blazy is installed and enabled alongside it.

This guide is written for a **human** installing and using the module. If you
want terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer
   (Blazy comes with it) and enable it.

## How to use it

Once enabled, the loading animation is shown automatically during AJAX
operations — there is nothing you must switch on. Confirm the spinner suits your
theme's look, and test it on your own site before relying on it in production.
See the [`agent/`](../agent/start.md) docs for orientation.
