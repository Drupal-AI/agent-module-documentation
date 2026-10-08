# Configuration

## The styles form

The main configuration lives at **Appearance → Tailwind**
(`/admin/appearance/tailwind`), reachable by users with the **`administer
tailwindcss_utility`** permission. From here you manage the utility-class
configuration — adding new CSS classes with their rules, or overriding existing ones
— and saving triggers Tailwind's (JIT) CSS generation for the collected classes.

## Choose a rule-storage backend

Class rules are kept in a pluggable storage backend, and you should pick the one that
suits how you deploy:

- **Configuration storage** — rules live in Drupal configuration, so they are
  exportable and travel through your normal config deployment workflow. Good for
  most sites where styles should move from staging to production with the rest of
  your config.
- **Database storage** — rules live in the database, which suits large or frequently
  changing (volatile) rule sets where you would not want them in exported config.

## Applying classes with Layout Builder

With the module enabled, Layout Builder section and block forms gain a Tailwind
**class input**, and the module applies the stored classes to the section's rendered
output. While editing, the **class-name autocomplete** helps you enter valid Tailwind
class names (you can include or exclude Tailwind's core classes in the suggestions).

## How the CSS reaches the page

You do not need a separate build step: a JIT handler compiles the collected classes,
and a stack middleware injects the generated stylesheet into responses. Only the
classes actually in use are compiled, and the result is cached.

## Permissions — set these carefully

This module ships permissions that deserve deliberate attention:

- **`administer tailwindcss_utility`** — grants access to the styles form and the
  class autocomplete. Give it to your theme/site administrators.
- **`access tailwindcss_utility endpoint`** — grants access to the **add-rules API**
  endpoint (`/tailwindcss-utility/add-rules-api`), which *writes* CSS rules into
  storage. The module's own permission description warns that it "can be exploited"
  and should be given to **trusted site editors only**. Treat this as a privileged
  write permission: never grant it to anonymous or untrusted authenticated roles.
  The permission is the whole protection on that endpoint, so assign it consciously.

Set both at **People → Permissions**.

## Save

Save the styles form (and your permissions). Newly added or overridden classes are
compiled and served automatically, and the generated CSS stays in sync as you add
more.
