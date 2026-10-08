# Configuration

Breakpoint Javascript Settings has one settings form, at **Configuration →
System → Breakpoint JS** (`/admin/config/system/breakpoint_js`). It is gated by
the core **Administer site configuration** permission, so it is administrator-only.

## Define the mappings

On this form you define the breakpoint values that get serialized into
`drupalSettings` for your front-end scripts:

- **Min-width values** — the pixel thresholds for each named breakpoint, matching
  what your theme uses so JS and CSS agree.
- **Device mappings** — the device categories (for example mobile, tablet,
  desktop) each breakpoint corresponds to, so scripts can reason in those terms.

Save the form and the module attaches these values to the page under
`drupalSettings`.

## Read them in JavaScript

With the values in place, your scripts read them from `drupalSettings` instead of
hard-coding widths. That gives you one source of truth: change a breakpoint here
and every script that reads it stays in sync, rather than hunting down duplicated
media-query numbers across the codebase. Typical uses include choosing
mobile-versus-desktop behaviour, configuring a responsive carousel, toggling
lazy-loading by viewport, and recalculating behaviour on window resize.
