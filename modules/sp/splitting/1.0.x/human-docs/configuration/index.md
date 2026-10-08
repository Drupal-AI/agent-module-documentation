# Configuration

The base **Splitting** module has no settings — you drive it from your theme's
JavaScript. The configuration described here belongs to the optional
**Splitting UI** submodule (`splitting_ui`), which lets you apply Splitting to
elements without writing any code. If you have not enabled that submodule, see
[Installation](../installation/index.md) first.

## Open the Splitting UI settings

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → User interface → Splitting**, or navigate directly to
   `/admin/config/user-interface/splitting`.

## What you configure

- **CSS selectors** — list the selectors for the elements you want Splitting to
  process (for example a heading class). Splitting.js will split the text inside
  each matched element into words and characters and add its CSS variables, so
  your stylesheet can then animate them.
- **Global options** — a few settings that control how Splitting behaves across
  the site.

## Save

Save the form, then reload a front‑end page containing one of your selectors. The
targeted text should now be wrapped per word and character, ready for you to style
and animate with CSS.
