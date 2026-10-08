# Configuration

Browscap works by keeping a local copy of the Browser Capabilities Project data.
The settings page is where you confirm the data source and how that data is kept
up to date.

## Open the settings form

1. Log in as a user with the module's administration permission (grant it under
   **People → Permissions**).
2. Go to the **Browscap settings** page under **Configuration → Development** (the
   `browscap.admin` route).

## What you configure

The settings page controls the **browscap data source and its updates** — where the
browser‑capabilities data is fetched from and how the module refreshes its local
copy over time. Because the underlying data changes as new browsers and devices
appear, the module downloads and updates it periodically so that detection stays
current.

After saving, the module can download the data. Once the data is in place,
`get_browser()`‑style lookups in your code return capability information based on
the visitor's user‑agent string.

## Keep in mind

- Browser detection here is **user‑agent based**, which is a heuristic and can be
  spoofed. Use the results for presentation and feature decisions, not for
  security‑sensitive logic.
- The module has **no content‑access role** — it only reports browser/device
  information; it does not gate access to anything.
