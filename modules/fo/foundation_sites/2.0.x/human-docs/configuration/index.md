# Configuration

ZURB Foundation Sites Library is mostly about *attaching* libraries from your own
theme or module (see "How to use it" on the [overview](../index.md) page), but it
does register a small settings form and a permission of its own.

## Open the settings form

1. Log in as a user with permission to administer the module.
2. Go to **Administration → Configuration** and open the **Foundation Sites**
   settings (route `foundation_sites.admin`).

## Choosing how Foundation is loaded

The module exposes Foundation in several **variants**, and this is where you decide
which one your site should rely on:

- **`complete`** — the full Foundation framework (all components and JavaScript).
- **`essential`** — a lighter subset covering the most commonly used pieces.
- **`core`** — the minimum base; every individual plugin library depends on it.
- **`cdn`** — loads Foundation from a content delivery network instead of the local
  `libraries/` copy, if you prefer not to host the files yourself.

Pick the variant that matches your needs: `complete` is the simplest if you use a
lot of Foundation, while attaching `core` plus only the specific plugins you need
keeps the front‑end payload smaller.

## Permission

The module provides its own permission for administering these settings. Grant it at
**People → Permissions** (`/admin/people/permissions`) only to trusted
administrator roles, since it controls how the framework is loaded site‑wide. Leave
it off for ordinary content roles.

## Overriding or trimming library contents

You don't have to accept the shipped library definitions as‑is. Using Drupal's
standard **libraries‑override** mechanism (in your theme's `*.info.yml`), you can
override, extend, or remove parts of the Foundation libraries — for example to drop
a component you never use or to swap in your own build. This is a code‑level
customization rather than something on the settings form, but it's the intended way
to tailor exactly what Foundation ships to the browser.
