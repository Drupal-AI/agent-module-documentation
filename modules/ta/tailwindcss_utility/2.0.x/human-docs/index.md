# Tailwind CSS Utilities — manual setup guide

**Tailwind CSS Utilities** (`tailwindcss_utility`) lets site builders apply
**Tailwind utility classes** throughout Drupal — including on **Layout Builder**
sections and blocks — and then generates and serves the matching CSS automatically.
The idea is utility-first styling without setting up a custom theme build: you (or
your editors) attach Tailwind classes where you want them, and the module compiles
just those classes into a stylesheet and injects it into the page.

Behind the scenes it does a few coordinated things. Class rules are kept in a
pluggable storage backend — either **configuration** (exportable and deploy-friendly)
or the **database** (better for large or frequently changing sets). A JIT handler
drives Tailwind's CSS generation for the collected classes, and a stack middleware
injects the resulting stylesheet into responses. For editors, it adds a **class-name
autocomplete** while editing and hooks into Layout Builder so Tailwind classes can be
attached to sections and blocks. The generated CSS is cached and only covers the
classes actually in use.

It depends on core's **File** module. Its admin form lives at **Appearance → Tailwind**
(`/admin/appearance/tailwind`).

A word on security, because it matters here. Two of the module's routes — the styles
form and the class autocomplete — are gated by the admin permission **`administer
tailwindcss_utility`**. There is also a third route, an **add-rules API** endpoint
(`/tailwindcss-utility/add-rules-api`), gated by a *separate* permission **`access
tailwindcss_utility endpoint`**. That endpoint **writes CSS rules into storage**, and
the permission's own description warns that it "can be exploited" and should be given
to trusted site editors only. Treat it as a privileged write surface: grant it
deliberately and never to anonymous or untrusted roles. (None of the routes are open
to the public — access is permission-gated throughout.)

This guide is written for a **human** clicking through the admin UI. If you are an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.
2. [Configuration](configuration/index.md) — the styles form, rule storage,
   Layout Builder integration, and the permissions to set carefully.

## Where it lives in the admin menu

The main settings form is at **Appearance → Tailwind**
(`/admin/appearance/tailwind`). Tailwind classes can also be attached directly on
**Layout Builder** section and block forms once the module is enabled.
