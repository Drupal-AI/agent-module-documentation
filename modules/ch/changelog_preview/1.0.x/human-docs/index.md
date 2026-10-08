# Changelog Preview — manual setup guide

**Changelog Preview** (`changelog_preview`) renders one or more project or module
`CHANGELOG` files inside the Drupal admin UI, so editors and stakeholders can see
what has changed — which features were added, what was fixed — without digging
through the codebase. You point the module at a Markdown changelog file on disk,
and it converts it to a readable HTML view within your site, with code blocks
highlighted in grey.

You can register several changelogs through a settings form, each with its own
file path and a browser path where users go to read it. Roles you choose can be
granted a "view changelog" permission so the right people can see the notes.

Two things are worth knowing up front. First, the changelog file path is
**relative to your Drupal root folder**, and the module reads files from disk —
so treat the view‑changelog permission as sensitive and grant it only to trusted
roles. Second, this project is **not covered by Drupal's security advisory
policy**, which is worth factoring into your risk assessment before using it on a
public site. The module depends on the `michelf/php-markdown` library to render
Markdown, but it pulls that in for you automatically.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — register your changelog files, set
   their paths, and grant the view permission.

## Where it lives in the admin menu

Once enabled, the settings form sits at `/admin/changelog_manage`, where you
register the changelog files and their browser paths. Each registered changelog
is then viewable at the browser path you assigned to it, by users who hold the
view permission.
