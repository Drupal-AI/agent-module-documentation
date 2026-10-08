<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# FlowDrop Workflow (flowdrop_workflow) — agent index

Submodule of **flowdrop**. The **workflow entity type**: stores, versions and manages workflow
definitions. Version **2.0.0**. Core `^11.3`.

Where a workflow lives. The editor produces a definition; this stores it, versions it, and
supplies the management surface. The runtime, executor and orchestration layer all read from here.

**Versioning is the point to raise.** A workflow editable in a browser is behaviour without a
deployment, so knowing what changed and being able to go back is what makes it operable.