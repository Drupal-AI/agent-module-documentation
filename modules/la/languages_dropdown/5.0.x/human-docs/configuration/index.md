# Configuration

Languages Dropdown has **no central settings page** — the project's own notes say
"No configuration required." Everything happens when you place its block, and the
block's own configuration form is where you choose how the dropdown looks.

## Place and configure the block

1. Log in as a user with the **Administer blocks** permission (an administrator by
   default).
2. Go to **Structure → Block layout** (`/admin/structure/block`).
3. In the region where you want the switcher (a header is typical), choose **Place
   block** and pick **Languages Dropdown (Bootstrap)**.
4. In the block configuration, set how each language is presented — the module can
   render options as **country flags**, as **language labels**, or as both
   together. Choose whichever suits your header design.
5. Set the usual block **visibility** conditions and **region** as for any block.
6. **Save block.**

You can place the block **multiple times** across different regions if you need
the switcher in more than one place.

## Accessibility worth verifying

The dropdown presentation makes a few accessibility details easy to miss — check
them against your theme rather than assuming:

- Each option should expose its **`lang` / `hreflang`** so assistive technology
  announces the language names correctly.
- The control should have a clear, **accessible label** — a bare select of
  language names is ambiguous on its own.
- If the dropdown navigates **on change** rather than on an explicit submit,
  consider whether that catches keyboard users mid‑selection; a submit button or
  confirmation avoids the surprise.

## Verify

View the site as a visitor and confirm the dropdown shows your enabled languages
with the flags/labels you chose, the current language is clearly indicated, and
selecting a language takes you to that language's version of the page.
