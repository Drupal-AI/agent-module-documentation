# Autocomplete 4xx — manual setup guide

**Autocomplete 4xx** (`autocomplete_4xx`) provides an autocomplete field type
that makes it easier to point HTTP 4xx error pages (such as 403 "access denied"
and 404 "not found") at existing content. Instead of remembering and typing a
path, you start typing a title and pick the page you want from an autocomplete
list.

It is a site-building / content-editing convenience. It provides a field type
and helps you map error responses to content; it has no content or access role
of its own.

There is no central settings page — the module gives you a field type to use
when configuring error pages. Because of that, this guide has two parts: an
overview (this page) and installation.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and
   enable it.

## Where it lives in the admin menu

Autocomplete 4xx does not add its own settings page. It surfaces as an
autocomplete field type you use when configuring which content should be shown
for 4xx error responses.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Where you configure a 4xx (403 / 404) error page, use the autocomplete field
   to start typing a page title and select the existing content you want to
   serve for that error.

This streamlines error-page setup by letting you choose content by title rather
than looking up and pasting paths.
