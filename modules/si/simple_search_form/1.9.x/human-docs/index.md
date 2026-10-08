# Simple Search Form — manual setup guide

**Simple Search Form** (`simple_search_form`) gives you a small, configurable
search block: a single text input and a submit button that, when submitted, sends
the visitor to a path of your choosing with their typed text as a URL query
parameter — for example `/search?search_api_fulltext=hello`. It's the quick way to
drop a search box into a header, sidebar, or footer that feeds a Views results page
or a Search API index, without writing a custom form.

The module ships one block plugin, **Simple search form**, which you place through
the normal Block layout UI. Each block instance is configured on its own: at
minimum you set the **Path** it submits to and the **GET parameter** name for the
query string. The form uses the HTTP `GET` method with no form token, so submitting
simply navigates the browser to `path?parameter=<value>`.

Beyond the two required fields, the block form offers plenty of polish: the input
element type (HTML5 `search`, plain textfield, or autocomplete when Search API
Autocomplete is installed), the label and how it displays, a placeholder, custom
CSS classes, whether to show the submit button and its label, whether to keep the
typed value in the box after redirect, and a list of existing URL query parameters
to preserve through the search. If Views is installed, it can even auto‑guess the
path and parameter from a View you tag `simple_search_form`.

It has no admin settings page of its own — everything is configured per block
instance. Optional integrations: **Search API** (match the parameter to a fulltext
filter) and **Search API Autocomplete** (suggestions in the input).

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent — including the Search API
wiring and caching details — read the sibling [`agent/`](../agent/start.md) docs
instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.
2. [Configuration](configuration/index.md) — place the block and set every option,
   field by field.

## Where it lives in the admin menu

The module adds no settings page. You work with it entirely from **Structure →
Block layout** (`/admin/structure/block`), where you place and configure the
**Simple search form** block (found under the *Search* category). It adds no
permissions of its own and no Drush commands.
