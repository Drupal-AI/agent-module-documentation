# Page links — manual setup guide

**Page links** (`page_links`) gives editors a compact inventory of the hyperlinks
buried in a Basic page's body — right on the node edit form, so they no longer
have to open the WYSIWYG "source" view to find and manage them. When a Basic page's
body contains links, the module adds a collapsible **Page links [N]** panel to the
form's advanced sidebar. Each row lists a link, marks it as **Local** (internal, no
scheme) or **Remote** (external, has a scheme), and offers a control to remove it;
a submit action then applies your changes back to the page.

It targets core's **Basic page** (`page`) content type specifically, has no
dependencies beyond core, and defines no permissions of its own — it rides the node
edit form's existing access, so anyone who can edit a Basic page can use the panel.
The panel only appears when the body actually contains links, and it stays hidden
otherwise.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

There is **no settings page** for this module — it has no configuration form. It
works automatically on the Basic page edit form, described in "How to use it"
below.

## Where it lives in the admin menu

Page links adds no admin page. You use it entirely from a Basic page's edit form
(**Content → *(a Basic page)* → Edit**), where the **Page links** panel appears in
the advanced sidebar whenever the body has links.

## How to use it

1. Edit any **Basic page** whose body contains one or more hyperlinks.
2. In the form's advanced sidebar (the same area as *Authoring information*,
   *URL alias*, and so on), open the **Page links [N]** panel — the number shows
   how many links were found.
3. Review the table: each link is listed with its resolved URL and a **Local** or
   **Remote** classification, so you can spot an external link that should have
   been internal (or vice versa) at a glance.
4. Use the delete control next to any link you want to remove, then submit the
   form to apply the changes to the page.

This is handy for editorial review of link‑heavy landing pages, content cleanup,
and migration QA — all without touching raw HTML.
