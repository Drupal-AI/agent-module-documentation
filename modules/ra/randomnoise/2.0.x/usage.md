<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Random Noise attaches a third-party JavaScript file to every page so each visitor makes an extra request to a random IP, adding noise to ISP traffic logs.
---
The premise is a privacy/anti-surveillance one: if a user's real traffic is buried in randomly generated requests to arbitrary IP addresses, the aggregated browsing profile that ISPs (or data brokers) can sell becomes less reliable and therefore less valuable. The module is a single `hook_page_attachments()` that adds the `randomnoise` library on every page for every visitor, including anonymous users.

The library definition loads `https://randomnoise.us/js/squawk.js` as an external, minified script. This means the module unconditionally injects a remote third-party script into every page: there is no Subresource Integrity, the behavior depends on an external domain staying trustworthy and available, and the script itself causes browsers to emit outbound requests. There is no server-side code, no routes, no configuration and no permissions — enabling the module is the entire operation. Setup: enable the module; it starts attaching the script immediately.
---
- Enable the module to add traffic noise for every visitor.
- Obscure real browsing patterns from ISP logging.
- Devalue resale of aggregated visitor traffic data.
- Attach the noise script on all pages automatically.
- Apply the behavior to anonymous and authenticated users alike.
- Contribute cover traffic to random IP addresses per request.
- Deploy a zero-configuration privacy gesture site-wide.
- Signal a privacy-first stance to your users.
- Remove the effect instantly by uninstalling the module.
- Pair with other privacy modules (cookie consent, IP anonymization).
- Review the remote `squawk.js` before enabling in sensitive environments.
- Weigh the third-party-script dependency against the privacy benefit.
- Turn every served page into a source of decoy traffic.
- Add cover requests without touching your own analytics setup.
- Frustrate passive network-level browsing-profile collection.
- Ship the anti-surveillance behavior with a single module enable.
