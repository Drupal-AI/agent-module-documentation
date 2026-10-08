# Configuration

All of Page Attach Library's setup happens on one form, where you build a list of
rules. Each rule says "on these pages, load these libraries."

## Open the settings form

1. Log in as a user with the **Administer site configuration** permission (an
   administrator by default).
2. Go to **Configuration → Page Attach Library → Page Attach Library Settings**,
   or navigate directly to
   `/admin/config/page-attach-library/page-attach-library-settings`.

You will see a draggable table of rules.

## The fields in each rule

- **Enabled** — a checkbox that turns the rule on or off. Untick it to disable a
  rule without deleting it, then re‑enable it later.
- **Pages** — a textarea listing the paths this rule applies to, **one path per
  line**. You can use:
  - the `*` wildcard to match a whole section — for example `/node/*` matches every
    node page, and
  - the `<front>` token to match the site's front page.
  Matching also considers URL aliases, so an aliased path matches as well as the
  system path.
- **library** — a textarea listing the asset libraries to attach, in the standard
  `module_name/library_name` form. List several by separating them with newlines
  or commas. Only libraries actually declared by an installed module or theme take
  effect.

## Managing the list of rules

- **Reorder** rules by dragging the handle on each row — weighting controls the
  order they are processed.
- **Add** another row for a different path/library combination.
- **Remove** a row with its Remove button.

Click **Save configuration** when you are done; the rules are stored in the
`page_attach_library.settings` config object.

## A typical rule

To load a slider library only on node pages:

- **Enabled:** ticked
- **Pages:**
  ```
  /node/*
  ```
- **library:**
  ```
  my_theme/slider
  ```

## Verify

Visit a page that matches the rule (for example any `/node/…` page) and view its
source — the attached library's CSS/JS should now be present. Visit a page that
does *not* match and confirm the library is absent, which is the whole point:
loading assets only where they are needed keeps other pages lighter.
