# Configuration

Language Switcher Enhanced does not add a separate settings screen. You choose how
it behaves on the **language‑switcher block** itself.

## Open the block configuration

1. Log in as a user with the **Administer blocks** permission (an administrator by
   default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. Find the **Language switcher** block in the region where you placed it (place it
   first if you have not), and choose **Configure**.

## Choose the behaviour for untranslated languages

In the block's configuration you select what should happen to a language that has
**no translation of the current page**. The three choices, and how to think about
them, are:

- **Hide** — remove the untranslated language from the switcher entirely. The
  switcher stays clean, but be aware the list of languages will *change from page
  to page*, which can disorient visitors who have learned where each option sits.
- **Disable / mark as unavailable** — keep the language visible but non‑clickable
  (or visibly flagged as unavailable). The switcher stays stable and honest about
  what exists. For most public sites this is the safest default.
- **Redirect** — send the visitor elsewhere (typically that language's homepage)
  when the current page has no translation. Use this with care: it loses the
  visitor's place, and if it is implemented as a real HTTP redirect rather than a
  link it can confuse search engines about the canonical URL.

Pick the behaviour that matches your site, then **Save block**.

## Verify

View a page that is deliberately *not* translated into every language, as an
ordinary visitor, and confirm the switcher now hides, disables, or redirects the
untranslated languages exactly as you configured — instead of linking to an
untranslated original or a 404.
