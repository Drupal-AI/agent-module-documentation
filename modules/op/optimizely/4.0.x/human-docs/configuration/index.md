# Configuration

Setup is two parts: enter your Optimizely **account ID** once, then create one or
more **projects** that say which snippet loads on which paths. Both screens require
the **Administer optimizely** permission (`administer optimizely`), which you grant
at **People → Permissions**.

## 1. Set your account ID

1. Go to **Configuration → System → Optimizely → Settings**
   (`/admin/config/system/optimizely/settings`).
2. Enter your **Optimizely account ID** (the numeric ID from your Optimizely
   account) and save.

Saving refreshes the caches for the paths of all enabled projects.

## 2. Create and target projects

Each experiment target is a **project** you manage from the list at
**Configuration → System → Optimizely** (`/admin/config/system/optimizely`). Add
or edit a project and set:

- **Label** — a human-friendly name for the project.
- **Code** — the numeric Optimizely project/experiment code. This is what builds
  the snippet URL `//cdn.optimizely.com/js/<code>.js`.
- **Enabled (state)** — only enabled projects load their snippet.
- **Paths** — a list of Drupal path patterns, one per line, where this project's
  snippet should load. `*` is a wildcard; a trailing `*` matches a prefix (for
  example `/products/*`); and `*` on its own means the whole site. Paths are
  matched against both the internal system path and its URL alias.

Examples of path targeting:

- `/products/*` — run a product-page test only on product pages.
- `/node/1` or the homepage path — run a test only on the front page.
- `/blog/*` — target every blog post.
- `/es/*` — target a language or section prefix.

### The Default project

A shipped **Default** project targets the whole site (`paths: *`). It **cannot be
deleted** — only disabled. Use it for a genuinely sitewide experiment, or disable
it and rely on narrower, path-targeted projects so experiment JavaScript loads only
where a test is running.

## Why split experiments across projects?

Keeping each experiment in its own path-targeted project means each hosted
JavaScript file stays small and only loads on the pages that need it — visitors on
unrelated pages don't download or run experiment code they'll never see. When a
project's paths change, the module automatically invalidates the affected pages'
caches so the change takes effect. Projects are Drupal config entities, so your
experiment targeting exports and imports with the rest of your configuration.
