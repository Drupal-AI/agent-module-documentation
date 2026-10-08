<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Orchestration Connector (flowdrop_orchestration_connector) — agent index

Submodule of **flowdrop**. Exposes workflows to **external automation platforms** through the
Orchestration module; adds an "Orchestration Invoke" capability. Version **2.0.0**. Core `^11.3`.

Realistic positioning: the organisation's existing automation platform (n8n, Make, Zapier, an
internal scheduler) is not going away. This is the seam — external platform orchestrates across
systems, Drupal-side work runs where the Drupal data is.

**Raise this as an authorisation surface, not just an integration.** Whatever can invoke a
workflow can make the site do whatever that workflow does — call models, write content, issue HTTP
requests. Settle which workflows are invokable, what authenticates the caller, and what the
Orchestration module's access model requires. *"Only reachable from our automation platform"* is a
network assumption, not an access control.