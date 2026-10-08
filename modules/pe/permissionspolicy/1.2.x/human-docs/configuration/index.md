# Configuration

Everything is done on one form: **Configuration → System → Permissions Policy**
(`/admin/config/system/permissionspolicy`). You need the **Administer permissions
policy configuration** permission.

## How the form is laid out

The policy has a master switch (the "enforce" policy, on by default) and then one
collapsible row per browser feature — the full standard list, including
`geolocation`, `camera`, `microphone`, `payment`, `fullscreen`, `autoplay`, `usb`,
`clipboard-read`, `display-capture`, sensors like `accelerometer` and `gyroscope`,
and advertising APIs like `interest-cohort` and `browsing-topics`.

For each feature you want to control, tick **Enable** and then choose a **Base** and,
optionally, list extra **Sources**:

- **Base** — the core allow rule for that feature:
  - **Self** — only your own site's origin may use the feature.
  - **None** — nobody may use it (fully disabled).
  - **Any** — everyone may use it (a wildcard).
  - **(empty)** — no base keyword; rely entirely on the Sources you list.
- **Sources** — extra origins to add to the allowlist, such as
  `https://embed.example.com`. You can enter several, separated by spaces, commas, or
  newlines. Sources only make sense with a Base of *Self* or *(empty)* — with *Any*
  or *None* they are ignored, because those already resolve to "everyone" or "nobody".

Only the features you enable are saved; the rest are left untouched.

## What the header ends up looking like

The module assembles all your enabled features into a single `Permissions-Policy`
header, listing features alphabetically. Some examples of how a feature's settings
translate:

| Base | Sources | Header fragment |
|---|---|---|
| Self | — | `geolocation=(self)` |
| None | — | `geolocation=()` |
| Any | — | `geolocation=*` |
| Self | `https://a.example` | `geolocation=(self "https://a.example")` |

A full header might read: `geolocation=(self), camera=(), autoplay=*`.

## A sensible starting point

A common hardening baseline is to set the sensitive features you do not use to
**None** — for example `geolocation`, `camera`, `microphone`, `usb`, `payment`,
`display-capture` — and set the ones you do use (say `fullscreen`) to **Self**, adding
a trusted embed provider under Sources only where you genuinely embed one.

## Save

Click **Save configuration**. The change takes effect on the next request; the module
adds a cache tag so cached responses are invalidated when the policy changes. If you
later disable every feature again, the header stops being sent (an empty policy
produces no header).

## For developers

Another module can adjust the policy per-response by subscribing to the module's
**policy alter event** (`permissionspolicy.policy_alter`) and calling methods like
`setFeature()` or `appendFeature()` on the policy object before it is serialized. See
the sibling [`agent/`](../agent/start.md) docs for the exact API.
