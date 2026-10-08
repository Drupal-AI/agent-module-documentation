# Shorthand — manual setup guide

**Shorthand** (`shorthand`) connects your Drupal site to a
[Shorthand](https://www.shorthand.com/) account so you can publish Shorthand's
immersive, full-bleed "stories" directly inside Drupal pages. Instead of
iframing or hand-copying a story, you browse your remote Shorthand stories from
the Drupal admin, download the one you want, and Drupal serves the whole story —
HTML, images, scripts — from its own public files directory.

Once a story is downloaded, you display it by attaching a **Shorthand select**
field to any fieldable entity (a content type, a taxonomy term, a user profile,
and so on). The field's widget is a simple dropdown of the stories you have
downloaded; its formatter reads the extracted `article.html` and `head.html`,
rewrites the story's asset paths to local URLs, and outputs the finished markup.
If you also run the [Metatag](https://www.drupal.org/project/metatag) module, the
story's own `<meta>` tags (including social-share images) can be copied onto the
host entity automatically.

Configuration is deliberately small: a single **API token** identifies your
Shorthand account, and everything else happens through the remote story list and
the field you add. The module ships a Drush clean-up command for pruning old
downloaded story versions, two permissions, and an optional
**shorthand_example** submodule that gives you a ready-made "Shorthand story"
content type to get started fast.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, enable the
   module, and (optionally) the example submodule.
2. [Configuration](configuration/index.md) — enter your API token, download
   stories, and add a Shorthand field to display them.

## Where it lives in the admin menu

- **Settings (API token):** **Configuration → Web services → Shorthand**
  (`/admin/config/services/shorthand`).
- **Remote story list / downloads:** **Content → Shorthand**
  (`/admin/content/shorthand`).

## How to use it

The end-to-end flow is: enter your token, download a story, then add a
**Shorthand select** field to the entity you want to render it on and pick the
story in that field. For a clean, full-page story you typically hide the entity's
other fields (or use a dedicated bundle from the example submodule) so the story
fills the page. See [Configuration](configuration/index.md) for the step-by-step.
