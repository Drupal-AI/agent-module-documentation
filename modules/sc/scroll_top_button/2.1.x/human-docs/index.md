# Scroll To Top Button — manual setup guide

**Scroll To Top Button** (`scroll_top_button`) adds a floating "back to top"
button to the front end of your site. Once a visitor has scrolled down far
enough, the button appears; clicking it smoothly scrolls the page back to the
top. It's the kind of small convenience that makes long homepages, blog posts,
FAQ pages, and endless Views listings much nicer to read on both desktop and
mobile.

Everything about the button is driven from a single settings form — there is no
block to place and no code to write. You choose how far the visitor must scroll
before it shows up, what the button looks like (image, plain link, rounded pill,
or edge tab), what text it carries, and how it animates in. The module attaches
a lightweight jQuery script to the front end and applies your choices site‑wide
on the active theme.

By default the button is turned **off**, so nothing appears until you open the
settings form, switch it on, and save. You can also decide whether it should
show on admin pages or stay purely on the public-facing side of the site.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the settings form, field by field.

## Where it lives in the admin menu

The settings form sits at **Configuration → User interface → Scroll To Top
Button** (`/admin/config/user-interface/scroll_top_button`). Any user with the
core **Administer site configuration** permission (an administrator by default)
can reach it.

## How to use it

1. Enable the module (see [Installation](installation/index.md)).
2. Open the settings form and switch the button **on** — remember it ships
   turned off.
3. Pick a style, set the label, and tune how far the visitor scrolls before the
   button appears.
4. Save. The button is now live on the front end of your active theme; reload a
   long page and scroll down to see it.
