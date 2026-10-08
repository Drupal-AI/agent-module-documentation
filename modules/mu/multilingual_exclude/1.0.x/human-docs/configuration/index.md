# Configuration

Configuring Multilingual exclude is simply a matter of listing the routes you want
kept out of translation handling and choosing the theme they should use. It is a
short, single‑form setup.

## Open the settings form

1. Log in as a user with the permission the module provides for managing the
   exclusion list (an administrator by default).
2. Go to the settings form at route `multilingual_exclude.settings` — via the
   module's *Configure* link on the **Extend** page.

## Add routes to exclude

The form lets you build a list of the routes (pages) that should **not** be treated
as translatable or language‑prefixed. For each entry you:

- **Add the route** you want to exclude — for example an admin, API, or utility
  page such as the Layout Builder editing route. Add one entry per route you want
  to keep in the default/admin language.
- **Choose the theme** to display that route with, so the excluded page renders
  consistently.

Add as many routes as you need, then **save** the form.

## What happens after saving

From then on, the routes you listed stay in the language your admin pages use,
rather than being pulled into the multilingual URL and language‑negotiation scheme.
Your content and access rules are untouched — this only affects which routes take
part in translation and language handling.

## Verify it worked

Visit one of the routes you excluded while browsing in a non‑default language. The
page should stay in the default/admin language (and use the theme you selected)
rather than switching language or gaining a language prefix.
