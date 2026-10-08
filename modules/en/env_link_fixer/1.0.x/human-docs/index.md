# Environment Link Fixer — manual setup guide

**Environment Link Fixer** (`env_link_fixer`) rewrites links and URLs so they
point at the **correct environment**. When content authors save absolute URLs
that were written for one environment — typically production — those links keep
pointing at production even when you view the content on a development or staging
copy. This module strips the production domain from such links (and images) so
they resolve to the environment you are actually on, avoiding cross‑environment
link leakage where a staging page quietly sends visitors back to the live site.

It works in three complementary ways:

- A **link field widget** that automatically strips the current domain from an
  absolute URL when you save a link field, storing it as a relative link.
- A **link field formatter** that rewrites links on output, using either a custom
  mapping or the module's general mapping.
- An **HTML text filter** that does the same rewriting inside formatted‑text
  fields, again using a custom or the general mapping.

The module provides its own permission and has no access‑control role beyond that
— it is a development and site‑building aid. Keeping links environment‑correct on
non‑production copies is also a small data‑hygiene win, since it stops staging
content from linking back to production.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer and enable the
   module.

The domain mappings and per‑environment behavior are set up on the field
widget/formatter, in the text‑format filter, and via `settings.php`, described in
"How to use it" below.

## Where it lives in the admin menu

Environment Link Fixer works through existing Drupal UIs rather than a single
settings page:

- The **text filter** is enabled per text format under **Configuration → Content
  authoring → Text formats and editors** (`/admin/config/content/formats`).
- The **widget** and **formatter** are chosen on a link field's **Manage form
  display** and **Manage display**.

## How to use it

1. **On link fields:** on the relevant bundle's **Manage form display**, set the
   link field's widget to the Environment Link Fixer widget so that absolute URLs
   have the current domain stripped when saved. On **Manage display**, set the
   field's formatter to the Environment Link Fixer formatter to rewrite links on
   output.
2. **In formatted text:** on **Configuration → Content authoring → Text
   formats**, edit the format(s) you use and enable the Environment Link Fixer
   filter so links inside body text are rewritten too.
3. **Add your local/dev domains via `settings.php`.** You can define custom
   mappings that are merged with the general mapping, for example:

   ```php
   $settings['env_link_fixer_custom_mappings'] = [
     'local.example.com' => 'www.example.com,example.com',
     'local.example.net' => [
       'www.example.net',
       'example.net',
     ],
   ];
   ```

4. **Disable it in production.** The module's rewriting is meant for
   non‑production copies. On the live site, turn its logic off in `settings.php`:

   ```php
   $settings['env_link_fixer_disabled'] = TRUE;
   ```
