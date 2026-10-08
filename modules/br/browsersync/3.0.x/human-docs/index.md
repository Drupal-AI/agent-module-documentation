# Browsersync — manual setup guide

**Browsersync** (`browsersync`) is a theme-development helper. It injects the
[Browsersync](https://browsersync.io/) Node.js client `<script>` into your Drupal
pages (just before `</body>`) so that a running Browsersync server can live-reload
the browser and inject changed CSS as you work on a theme. Change a Twig, CSS, or
JS file and the browser updates instantly — no manual refresh.

It's important to be clear about what this module does and doesn't do: it only
adds the client script to the page. **You still run the Browsersync server
yourself** from the command line (or via a Gulp/Grunt task). And it's a
development tool — the maintainers state it is not intended for production.

Configuration is deliberately minimal and lives **per theme** on the theme
settings form: an *Enable Browsersync* checkbox plus optional *Host* and *Port*
overrides. The injected script is only shown to users who hold the **Use
browsersync** permission, so anonymous visitors never see it — you grant it to
your developer role. There's no config page of the module's own.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token-cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

## Where it lives in the admin menu

Browsersync has no page of its own. Its settings are attached to the **theme
settings** form:

- **Appearance → Settings → (your theme)**
  (`/admin/appearance/settings/<theme>`) — look for the **Browsersync settings**
  group. (You can also use the global theme settings.)
- **People → Permissions** — grant **Use browsersync** to developer roles so the
  script is injected for them.

## How to use it

1. Install and enable the module (see [Installation](installation/index.md)).
2. Grant the **Use browsersync** permission to your developer role (and to
   yourself). The client script is injected **only** for users who have it, so
   normal visitors are unaffected — leave anonymous without it.
3. Go to **Appearance → Settings → (your theme)**, open **Browsersync settings**,
   and tick **Enable Browsersync**. Optionally set:
   - **Host** — override the auto-detected host if it's wrong (useful under
     Docker/DDEV where the container IP isn't what your browser should hit).
   - **Port** — override the default Browsersync port (`3000`).

   By default the host token is replaced client-side with the page's own hostname,
   and the port is `3000`.
4. Start the **Browsersync server yourself** from the CLI (or a Gulp/Grunt task),
   pointing it at your dev site and watching your theme files.
5. Edit a template, stylesheet, or script and watch the browser live-reload or
   CSS-inject the change.

> **CSS injection note:** while Browsersync is enabled and core CSS aggregation is
> off, the module forces non-core CSS to load as individual `<link>` elements.
> That's deliberate — Browsersync's CSS injection doesn't work with
> `@import`-aggregated stylesheets. This is a development-time behaviour; leave
> aggregation on in production (where you shouldn't be using this module anyway).
