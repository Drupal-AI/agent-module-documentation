# Dopup — manual setup guide

**Dopup** (`dopup`) displays a **Webform inside a configurable popup block** — the
kind of pop‑up prompt you see on marketing sites (in the style of sumo.me) for
lead generation: a "Get a Quote" form, a newsletter sign‑up, and similar
call‑to‑action prompts. You build a webform, place a Dopup block, choose which
webform it shows, and set when and where the popup appears.

Each Dopup block has its own settings: which webform to show (only webforms tagged
with the `dopup` **category** are offered in the picker), the popup's **position**
(center, a corner, or a custom spot), its **trigger** (appear a number of seconds
after page load, or once the visitor scrolls to a given percentage of the page),
and **custom CSS** to style it. The chosen webform is rendered into a hidden
container and revealed by the module's JavaScript according to the trigger.

Because it embeds a webform, submissions are collected through the normal Webform
results UI — so you can review and export captured leads exactly as you would for
any other webform. It depends on the **Webform** module, runs on Drupal 8 through
11, provides its own permission (`administer dopup configuration`), and is
security‑advisory covered.

> **Two things to know before deploying.** First, stick to **one popup per page**:
> the author notes that multiple Dopup blocks on the same page are theoretically
> possible but untested. Second, a security caveat: the module's webform
> autocomplete endpoint (`/dopup/autocomplete-webform`) is gated only by "access
> content" and does not enforce entity access, so any visitor — including anonymous
> ones — can enumerate the machine names and titles of *all* webforms on the site.
> Do not treat webform machine names as secret while this module is enabled. The
> admin settings route itself is properly permission‑gated.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it alongside Webform.
2. [Configuration](configuration/index.md) — create and tag the webform, place the
   Dopup block, and configure its webform, position, trigger, and styling.

## Where it lives in the admin menu

Each Dopup block is configured at **`/admin/config/system/dopup/{block}`**, gated
by the **Administer dopup configuration** permission. Blocks are placed through the
standard **Structure → Block layout** page.

## How to use it

In short: create a webform, add the `dopup` category to it so it shows up in the
block picker, place a "Dopup" block in a region, then configure that block's
webform, position, trigger timing, and any custom CSS. See
[Configuration](configuration/index.md) for the step‑by‑step.
