# Configuration

The module ships with a configuration form where you decide which search indexes
it applies to and which Layout Builder blocks get stripped out before a page is
rendered for indexing. Reaching this form requires the permission the module
provides, so make sure your account has it (an administrator does by default).

## Open the settings form

Go to the module's configuration page. If you're not sure of the exact path, go to
**Extend** (`/admin/modules`), find **Search API Layout Block Filter** in the
list, and click its gear/settings icon to jump straight to the form.

## Set the options

The form gives you two choices plus a switch:

- **Search indices** — tick the indexes this filter should work on. Leave any
  indexes you don't want affected unchecked.
- **Blocks to exclude** — tick the Layout Builder blocks that should be removed
  from the rendered output before indexing. These are the navigational or
  contextual blocks (related-content sliders, promotional blocks, and the like)
  whose text you don't want polluting your search results.
- **Enable filter** — a checkbox that switches the whole filter on. The exclusions
  only take effect when this is ticked.

## Save and re-index

Click **Save** to store the configuration. Excluding blocks changes what gets
written to the index, so your content needs to be **re-indexed** afterward for the
change to matter.

> **Test before you re-index everything.** The maintainers recommend trying your
> configuration on a single node first — ideally on a non-production environment —
> to confirm the right blocks are being excluded before you queue your whole site
> for re-indexing.
