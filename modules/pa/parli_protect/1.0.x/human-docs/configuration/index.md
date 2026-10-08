# Configuration

Parliament Protect is driven entirely from its settings form, where you decide
which visitors are blocked and what they see instead of your content.

## Open the settings form

1. Log in as a user with permission to administer the module (an administrator by
   default — the module provides its own permission for this).
2. Open the **Parliament Protect** settings form from the site's configuration
   area.

## What you can configure

The exact labels may vary slightly by release, but the settings form gives you
control over the following, all described on the module's project page:

- **Blocked IP ranges.** The list of IP addresses and ranges that trigger a
  redirect. The module ships with the UK Parliament ranges pre‑loaded, but you can
  edit this freely — add or remove any single address or range you want to block.
  This is what turns the module from a UK‑Parliament joke into a general
  block‑these‑visitors tool.
- **What blocked visitors see.** Choose between the built‑in satirical form (whose
  submissions are intentionally *not* saved — it is a joke, not a data‑collection
  form) and a **custom title and message** of your own. Use the custom message
  when you want to return a plain, themed "you are not allowed here" page instead
  of the form.
- **Debugging.** A debug option makes the redirect fire for ordinary internal
  links so you can see the block behavior for yourself without visiting from a
  blocked IP. This is how the module's demo site illustrates the effect. Turn it
  **off** in production — with it on, normal visitors get redirected too.

## Logging

Blocked attempts are logged automatically, and the module keeps a running count of
how many times each configured range has tried to reach the site. Review these to
gauge how often your blocked ranges are actually hitting the site.

## Save

Save the form to apply your changes. The block takes effect on subsequent requests
from matching IP addresses.
