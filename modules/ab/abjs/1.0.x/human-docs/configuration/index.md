# Configuration

A/B Test JS is administered under **Configuration → User interface → A/B Test JS**
(`/admin/config/user-interface/abjs`). Everything you build here falls into three
kinds of object that work together.

## The three building blocks

- **Conditions** — a snippet of JavaScript that decides *who is eligible* for a
  test. For example, a condition might match only visitors on a specific page, or
  only logged-in users. Conditions are authored here as reusable pieces.
- **Experiences** — a snippet of JavaScript that *changes the page*: swaps a
  headline, recolours a button, rearranges a layout. An experience is what a
  visitor in a variant actually sees.
- **Tests** — a test binds conditions and experiences together and sets the
  **traffic split** — what proportion of eligible visitors get each variant. This
  is where an experiment is actually turned on and run.

A typical flow: a developer writes and approves the conditions and experiences; a
marketer then assembles a test from those approved pieces and chooses the split.

## The permission split — configure this first

The screens above are not all gated the same way, and that is intentional:

- Creating or editing a **condition or experience** — anywhere JavaScript is
  authored — requires **`administer ab test scripts and settings`**, a
  *restricted* permission. Treat holding it as equivalent to being able to deploy
  code, because an experience is arbitrary JavaScript that runs on every page
  view. Give it only to people trusted to deploy code.
- Creating and running **tests** requires **`administer ab tests`**, which is not
  restricted. A marketer with this permission can run experiments built only from
  snippets a developer already approved — they cannot write new JavaScript.

Set both under **People → Permissions**. Granting the marketing team only
`administer ab tests` is the intended, safe arrangement.

## Two things to watch when tests go live

- **Flicker.** A client-side variant can visibly flash the original content
  before the JavaScript rewrites it, unless the variant is applied before the
  page first paints. Test how each experience renders on a real page.
- **Page caching.** Client-side tests interact badly with aggressive page
  caching — if the cache serves every visitor the same flattened HTML, the split
  never happens. The traffic split has to be decided somewhere the cache does not
  flatten it.

## Turning a test off

Because tests are their own objects, you can disable an experiment quickly by
turning its test off without deleting the underlying conditions and experiences —
useful if a variant misbehaves in production.
