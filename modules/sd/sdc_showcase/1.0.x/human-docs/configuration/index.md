# Configuration

SDC Showcase works out of the box, but its settings form lets you control who can
reach the showcase and how variations are generated.

## Open the settings form

1. Log in as a user with the **`administer sdc showcase`** permission.
2. Go to **Configuration → Development → SDC Showcase**
   (`/admin/config/development/sdc-showcase`).

Note that the settings page itself is always gated by that permission — never by the
access modes below (those govern only the public showcase routes).

## Access modes

The **access mode** decides how the showcase pages (`/sdc-showcase` and friends) are
reached:

| Mode | Behaviour |
|------|-----------|
| **Open** *(default)* | Requires the standard **`access sdc showcase`** permission. |
| **Disabled** | All showcase routes return 403. Use this on production. |
| **HTTP auth** | A valid Basic Auth username/password *or* the permission grants access. Credentials are compared securely. |
| **Query string** | A valid `?sdc_key=` matching the configured key *or* the permission grants access. |

The HTTP-auth and query-string modes exist so headless CI tools can reach the
showcase without a Drupal login. They are an explicit opt-in — the default stays
permission-gated, and nothing is exposed anonymously unless you choose one of them.

## Variation and data settings

- **Seed** *(default 42)* — the seed for the deterministic fake data, so previews are
  reproducible from run to run.
- **Variation layers** — toggle which layers are generated: *baseline*, *sweep*
  (every enum value and boolean state), *edges* (empty, long, zero, negative, missing
  optional props), and *combinations*.
- **Maximum variations** *(default 50)* — a cap on how many variations are generated
  per component.
- **Enabled providers** — restrict which SDC providers (themes/modules) appear in the
  showcase.
- **Slot defaults** — the placeholder markup used for slots, in short, medium, long,
  empty, and image flavours.
- **Iframe mode** — render variation pages bare (without site chrome) so screenshot
  tools can capture them cleanly.

## Extending the fake data

Developers can override a component's demo data with a `*.stories.yml` file, or write
a custom data generator plugin for more realistic field data. These are code-level
extensions rather than form settings.

## Save

Click **Save configuration**. Changes to the seed and variation layers take effect on
the next render of the showcase pages.
