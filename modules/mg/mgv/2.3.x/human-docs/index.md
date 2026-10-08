# More Global Variables (mgv) — manual setup guide

**More Global Variables** (`mgv`) gives themers a ready‑made bag of common values — the
current path, the page title, the current language, your site's name/slogan/logo, and
social‑sharing URLs — printable in **any** Twig template as a single `global_variables`
object. It saves you from writing a preprocess function every time you need one of these
everyday values in a template.

Once enabled, every template gains a `global_variables` variable, so you can write things like
`{{ global_variables.site_name }}`, `{{ global_variables.current_page_title }}`,
`{{ global_variables.current_path }}`, or a share link such as
`<a href="{{ global_variables.social_sharing.facebook }}">Share</a>` — in `html.html.twig`,
`page.html.twig`, a node, a field, a block, or a region template. Values that make sense to
vary by page or language carry the right cache metadata automatically, so render caching stays
correct.

The module has **no configuration, no permissions, and no admin page** — it is developer/
theming tooling. It is also easily extensible: because each value is a small "GlobalVariable"
plugin, you can add your own value (for example the current node's title) by dropping a plugin
class into any module. It needs no contrib dependencies and runs on Drupal 10.3+, 11 and 12.

This guide is written for a **human** working in a theme. If you want the full list of built‑in
variables and the plugin API (dependencies, context‑awareness, cache metadata) for an AI
coding agent, read the sibling [`agent/`](../agent/start.md) docs.

## Contents

1. [Installation](installation/index.md) — install the module with Composer and enable it.

## How to use it

There is nothing to configure. After enabling, print any of the built‑in values in a Twig
template:

- **Site information:** `{{ global_variables.site_name }}`,
  `{{ global_variables.site_slogan }}`, `{{ global_variables.site_mail }}`,
  `{{ global_variables.logo }}` (the logo URL).
- **Current page / path:** `{{ global_variables.current_page_title }}`,
  `{{ global_variables.current_path }}`, `{{ global_variables.current_path_alias }}`,
  `{{ global_variables.base_url }}`.
- **Language:** `{{ global_variables.current_langcode }}`,
  `{{ global_variables.current_langname }}`.
- **Social sharing** (wrap each in an anchor): `global_variables.social_sharing.facebook`,
  `.twitter`, `.linkedin`, `.whatsapp`, and `.email` (a `mailto:` link with the page title as
  the subject).

For example, a footer copyright line: `© {{ "now"|date("Y") }} {{ global_variables.site_name }}`.

To add your **own** global variable, write a small `#[Variable('my_id')]` plugin class in any
module's `Plugin/GlobalVariable/` directory and print it as `{{ global_variables.my_id }}` —
see the [`agent/`](../agent/start.md) docs for the plugin API.
