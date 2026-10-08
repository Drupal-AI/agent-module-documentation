<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
## What it does

- Helps detect malicious clones/phishing copies of your website by embedding a small beacon link into the HTML source.
- When someone copies your pages onto another host, the beacon still points back and signals that a foreign copy has loaded.
- Lets you become aware of scam/duplicate sites impersonating yours.

---

## Install & configure

- Enable the module (note the internal machine name is `didsomeonecloneme`).
- Configure at `/admin/config/system/did-someone-clone-me` (route `didsomeonecloneme.settings`, permission `administer didsomeonecloneme settings`).
- Set the beacon behaviour/identifiers per the settings form.

---

## Usage & behaviour

- The settings form is gated by the dedicated `administer didsomeonecloneme settings` permission (declared in `permissions.yml`).
- The module injects a marker/beacon into page output that references your canonical host.
- On a cloned copy, the beacon's presence on the wrong host is what reveals the clone.
- Detection is heuristic and depends on the cloned copy preserving the embedded markup.
- A determined attacker can strip the beacon, so treat this as an early-warning aid, not a guarantee.
- No inbound endpoints accept anonymous mutations; the module only adds output and an admin form.
- Use it for brand-protection on sites frequently targeted by phishing (banks, gov, popular brands).
- Configuration is stored via config factory and exportable via CMI.
- The beacon adds negligible page weight.
- Combine with monitoring/alerting so a detected clone actually notifies someone.
- Works across Drupal 8, 9 and 10.
- No cron, queue, or external API dependency is required by the core module.
- Disabling the module removes the injected beacon.
- Review the injected markup to ensure it fits your Content Security Policy.
- Pair with takedown procedures — detection is only useful if you act on it.
- Consider privacy/legal implications of any callback the beacon performs.
