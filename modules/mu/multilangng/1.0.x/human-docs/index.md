# MultiLangNG — manual setup guide

**MultiLangNG** (`multilangng`) is a collection of "next‑generation" multilingual
tooling for Drupal, aimed at improving translation and multilingual workflows
beyond core's defaults. In practice its useful piece is a submodule,
**MultiLangNG Translations** (`multilangng_translations`), which provides an
alternative service that translates configuration **at runtime**. That approach
brings some advantages over the standard config‑translation flow: it can translate
non‑English configuration, allows contextual translation of config strings, and can
auto‑translate site‑builder configuration.

> **Heads up — this module is winding down.** The maintainers recommend switching
> to **[TranslationBliss](https://www.drupal.org/project/multilangng)** (the
> project's stated successor), which is intended to do everything MultiLangNG does
> and more. MultiLangNG is marked *no further development* and is not covered by
> Drupal's security advisory policy. If you are starting fresh, prefer
> TranslationBliss; use MultiLangNG only if you already depend on it.

Because it works by swapping in an alternative config‑translation service, its
effect is behavioral rather than something you click through: enable the submodule
and configuration is translated at runtime through its service. It provides its own
permission(s) but no dedicated settings form.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module (and its translations submodule).

There is **no dedicated settings form** for this module. Its behavior comes from
enabling the `multilangng_translations` submodule, which replaces the runtime
config‑translation service; see its project README for the finer points.

## Where it lives in the admin menu

MultiLangNG adds no admin page of its own. Its work happens through the alternative
config‑translation service provided by the `multilangng_translations` submodule; you
continue to manage translations through Drupal's normal language and
configuration‑translation screens under **Configuration → Regional and language**.
