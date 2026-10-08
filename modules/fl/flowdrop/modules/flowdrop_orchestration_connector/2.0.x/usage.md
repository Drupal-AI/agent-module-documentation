<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
FlowDrop Orchestration Connector exposes workflows to external automation platforms via the Orchestration module, adding an "Orchestration Invoke" capability.

---

Most organisations already have an automation platform — n8n, Make, Zapier, an internal scheduler — and it is usually not going away because Drupal grew a workflow editor. The realistic goal is that the two cooperate: the external platform orchestrates across systems, and Drupal-side work runs where the Drupal data is.

This submodule provides that seam. A FlowDrop workflow becomes something the external platform can invoke, so a process that spans several systems can call into Drupal for the part that belongs there instead of reaching into the database or reimplementing the content model over an API.

**Treat it as an authorisation surface, not just an integration.** Anything that can invoke a workflow can make the site do whatever that workflow does — call models, write content, make HTTP requests. Before exposing workflows, settle which ones are invokable, what authenticates the caller, and what the Orchestration module's own access model requires. "It is only reachable from our automation platform" is a network assumption, not an access control.

---

- Invoke a Drupal workflow from an external platform.
- Let n8n or Make call into Drupal.
- Run Drupal-side work where the data is.
- Avoid reimplementing the content model over an API.
- Span a process across several systems.
- Expose selected workflows for invocation.
- Authenticate an external automation caller.
- Return a workflow result to the caller.
- Integrate with an internal scheduler.
- Keep external orchestration and Drupal logic separate.
- Decide which workflows may be invoked.
- Audit what external systems can trigger.
- Review the Orchestration module's access model.
- Avoid relying on network position as access control.
- Retire a bespoke integration endpoint.