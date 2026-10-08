# Search Autocomplete — manual setup guide

**Search Autocomplete** (`search_autocomplete`) adds typeahead ("search as you
type") suggestions to input fields on your site. As a visitor types into a search
box, a dropdown of matching suggestions appears, and clicking one can fill the
field, submit the form, or jump straight to the matching page.

The module is built around reusable **autocompletion configuration** entities.
Each one connects a target field — identified by a CSS selector — to a
**suggestion source**, and tunes how the dropdown behaves: how many characters
someone must type before suggestions appear, how many suggestions to show, whether
to auto‑submit or redirect, custom "no results" and "view all results" messages,
and which CSS theme to use for the dropdown.

Three configurations ship enabled out of the box, so the core search block and the
content and user search forms get suggestions immediately after you install the
module. You can edit those, or add your own configuration pointing at any input
field. A suggestion source can be a callback URL or a **View** (written as
`view_id::display_id`), which lets you build a JSON suggestion endpoint from any
listing you can express in Views.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — the autocompletion configuration
   entities field by field, the shipped defaults, the admin helper, and
   permissions.

## Where it lives in the admin menu

The admin UI is at **Configuration → Search and metadata → Search Autocomplete**
(`/admin/config/search/search_autocomplete`) — a list of autocompletion
configurations with Add, Edit, and Delete links. It is gated by the **Administer
search autocomplete** permission.

## How to use it

For the common case you don't have to do anything: enable the module and the core
search block already has suggestions. To add autocompletion to another field, or
change how suggestions behave, create or edit an autocompletion configuration — see
[Configuration](configuration/index.md) for the full walkthrough.
