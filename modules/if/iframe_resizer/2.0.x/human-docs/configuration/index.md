# Configuration

All of iFrame Resizer's behaviour is controlled from one settings form. Before it
does anything, make sure the iframe-resizer 4.x library is installed (see
[Installation](../installation/index.md)) and that you enable at least one of the two
usage modes below.

## Open the settings form

1. Log in as a user with the **Administer iframe resizer** permission.
2. Go to **Configuration → User interface → iFrame Resizer**, or navigate directly to
   `/admin/config/user-interface/iframe_resizer`.

## Choose a usage mode

Two independent checkboxes decide what the module loads. At least one must be on:

- **Host** — turn this on if *your* site embeds iframes that should resize to their
  content. Loads the resizer library and initialises it on your iframes.
- **Hosted** — turn this on if *your* site is displayed inside another site's
  resizable iframe. Loads the "content window" script so the parent site can size
  your page.

You can enable both if your site plays both roles.

## Host-mode options

These appear when **Host** is enabled.

### Which iframes to resize

- **All iframes** — the resizer is applied to every `<iframe>` on the page.
- **Specific selectors** — supply a list of CSS/jQuery selectors (one per line, for
  example `#report-frame`), and only matching iframes are resized.

### Override defaults

By default the library's own sensible defaults are used. Tick **Override defaults**
to expose the full option set below; leave it unticked to keep the defaults (the
individual options are then ignored). The most useful options are:

- **Height / width calculation method** — how the library measures the content to
  decide the size. Height offers methods such as `bodyOffset` (the default),
  `bodyScroll`, `documentElementOffset`, `lowestElement`, `taggedElement`, `max`,
  `min`, and `grow`; width offers a similar list. Try an alternative if a tricky
  layout is measured incorrectly.
- **Auto resize** — keep the iframe resizing automatically as its content changes
  (on by default).
- **Min / max height and width** — bounds on the resized dimensions. Leaving max
  height or width blank means "no limit" (unbounded).
- **In-page links** — enable so that anchor links work across the iframe boundary.
- **Body background / margin / padding** — CSS overrides applied inside the iframe.
- **Scrolling** — allow scrollbars inside the iframe when needed.
- **Size height / size width** — whether the library adjusts height (on by default)
  and/or width (off by default) — turn width on for a fully fluid frame.
- **Tolerance** — a pixel threshold before a resize is triggered, to reduce churn.
- **Interval** — the resize check interval in milliseconds, used as a fallback in
  browsers without MutationObserver.
- **Log** — turn on console logging to debug the parent/child messaging.
- **Check origin** — when on (the default), the library only accepts messages from
  the iframe's own source domain. The library documentation advises disabling this
  only when the frame navigates across domains.

## Hosted-mode options

These appear when **Hosted** is enabled and control how your page behaves inside
someone else's frame:

- **Target origin** — restrict which parent domain may embed your site. The default
  `*` means any parent; set it to your parent site's origin (for example
  `https://parent.example.com`) to stop other sites from mimicking it.
- **Height / width calculation method** — the measurement method used when the parent
  sizes your page (defaults to `parent`).

## Save

Click **Save configuration**. On every page where the enabled mode applies, the
module now loads the library and passes your settings to it. If you need to change
the emitted settings from code rather than the form, the module provides two alter
hooks (`hook_iframe_resizer_host_settings_alter` and
`hook_iframe_resizer_hosted_settings_alter`) — see the sibling
[`agent/`](../agent/start.md) docs for details.
