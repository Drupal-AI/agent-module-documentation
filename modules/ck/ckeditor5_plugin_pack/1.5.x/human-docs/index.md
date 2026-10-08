# CKEditor 5 Plugin Pack — manual setup guide

**CKEditor 5 Plugin Pack** (`ckeditor5_plugin_pack`) bundles a large set of
additional CKEditor 5 plugins and toolbar buttons for Drupal's default rich-text
editor. It ships as an umbrella project: a small base module provides the shared
plumbing (a settings form, a library-version checker and a config handler), and
each individual feature — font controls, highlighting, find & replace, word
count, media embed, emoji, fullscreen and many more — is its own submodule you
enable only when you need it. Because every editor button is opt-in, a site only
loads the JavaScript for the features it actually uses.

Most of the bundled features are **free**. The pack also builds on the
**CKEditor 5 Premium Features** module (a dependency), so with a valid license
key you can additionally unlock CKEditor's premium plugins. Whichever features
you turn on, you make them appear for editors the same way: by dragging the new
buttons into the **active toolbar** of a text format that uses CKEditor 5.

This guide is written for a **human** clicking through the admin UI. It walks you,
step by step, from installing the module to entering global settings and adding
the new buttons to a text format's toolbar. If you are looking for terse,
token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

![The CKEditor 5 Plugin Pack settings page](images/settings.png)

## Where it lives in the admin menu

The base module's global options live at **Configuration → CKEditor 5 Plugin Pack
settings** (`/admin/config/ckeditor5-plugin-pack`). This page controls where the
CKEditor library assets are loaded from and a couple of related options — it does
**not** contain the individual feature buttons.

The buttons themselves are enabled **per text format**, over at **Configuration →
Content authoring → Text formats and editors**
(`/admin/config/content/formats`). There you edit a format that uses CKEditor 5
and drag the Plugin Pack buttons into its toolbar.

## Contents

1. [Installation](installation/index.md) — install the module with Composer,
   enable it and the submodules you want, and note what premium features require.
2. [Configuration](configuration/index.md) — set the global asset options, then
   add the new Plugin Pack buttons to a text format's toolbar.
